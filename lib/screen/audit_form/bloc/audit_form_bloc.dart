import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:task_management_kts/app_utility/app_util.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import '../../../service/api_repository.dart';
import '../model/audit_form_model.dart';
import '../model/audit_submit_response_model.dart';
import '../model/delete_image_file.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
part 'audit_form_event.dart';
part 'audit_form_state.dart';

class AuditFormBloc extends Bloc<AuditFormEvent, AuditFormState> {
  AuditFormModel? auditFormModel;
  AuditSubmitResponseModel? auditSubmitResponseModel;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController outStandingController = TextEditingController();
  List<String>? questionId = [];
  List<String>? questionImageId = [];
  List<String>? answer = [];
  List<String>? comments = [];
  DeleteImageFile? deleteImageFile;
  String handOverId = "";
  String handOverAnswer = "";
  String message = "";
  bool? isSubmit = false;
  List<XFile>? images;
  final ImagePicker _picker = ImagePicker();
  var tempPath;
  var tempName;
  List<File>? imageFileList2 = [];

  AuditFormBloc() : super(AuditFormInitial()) {
    on<GetAuditList>(getAuditList);
    on<SelectAuditRadioButton>(selectRadioButton);
    on<SaveOrSubmitAnswers>(saveOrSubmitAnswers);
    on<SelectHandoverRadioButton>(selectHandoverRadioButton);
    on<DeleteAuditImage>(deleteAuditImage);
    on<MultipleImageEvent>(selectImage);
    on<RemoveImageEvent>(removeImage);
    on<MultipleCameraEvent>(selectCamera);
    on<FinalSubmitAnswers>(finalSubmitAnswers);
  }

  Future<FutureOr> getAuditList(
      GetAuditList event, Emitter<AuditFormState> emit) async {
    try {
      emit(AuditFormLoading());
      var data = {
        "layout_id": event.layoutId,
        "current_time": AppUtils.currentFullDateTimeFormat(DateTime.now()),
      };

      debugPrint(data.toString());
      await ApiRepository.auditQuestionList(data: data).then((value) async {
        if (value.statusCode == 200) {
          auditFormModel = value;
          isSubmit = value.data?.submitted;
          if(value.data?.withInLocation==false){
            isSubmit=value.data?.withInLocation==false?true:false;
          }
          message=value.message!;
          emit(const AuditFormLoaded());
        } else if (value.statusCode == 403) {
          emit(AuditFormError(value.message));
          emit(const AuditFormLoaded());
        } else if (value.statusCode == 400) {
          emit(AuditAuthorization());
        } else {
          emit(AuditFormError(value.message));
          emit(const AuditFormLoaded());
        }
      });
    } catch (e) {
      emit(AuditFormException(e.toString()));
    }
  }

  Future<FutureOr> selectRadioButton(
      SelectAuditRadioButton event, Emitter<AuditFormState> emit) async {
    try {
      emit(AuditFormLoading());

      auditFormModel?.data?.questions![event.selectedIndex].answer =
          event.values;

      emit(const AuditFormLoaded());
    } catch (e) {
      emit(AuditFormException(e.toString()));
    }
  }

  Future<FutureOr> removeImage(
      RemoveImageEvent event, Emitter<AuditFormState> emit) async {
    try {
      emit(AuditFormLoading());

      auditFormModel?.data?.questions![event.questionIndex].imageFileList
          ?.removeAt(event.selectIndex!);

      emit(const AuditFormLoaded());
    } catch (e) {
      emit(AuditFormException(e.toString()));
    }
  }

  Future<FutureOr> selectHandoverRadioButton(
      SelectHandoverRadioButton event, Emitter<AuditFormState> emit) async {
    try {
      emit(AuditFormLoading());
      emit(const AuditFormLoaded());
    } catch (e) {
      emit(AuditFormException(e.toString()));
    }
  }

  Future<FutureOr> deleteAuditImage(
      DeleteAuditImage event, Emitter<AuditFormState> emit) async {
    try {
      emit(AuditFormLoading());
      var data = {
        "img_id": event.imageId,
        "type": "audit", //need to send date and time
      };
      debugPrint(data.toString());
      await ApiRepository.deleteAuditImage(data: data).then((value) async {
        if (value.statusCode == 200) {
          deleteImageFile = value;
          emit(const AuditFormLoaded());
          emit(AuditFormImageDelete());
          // emit(ApisCallSuccess(value.message));
        } else if (value.statusCode == 403) {
          emit(AuditFormError(value.message));
        } else if (value.statusCode == 400) {
          emit(AuditAuthorization());
        } else {
          emit(AuditFormError(value.message));
        }
      });
    } catch (e) {
      emit(AuditFormException(e.toString()));
    }
  }

  Future<FutureOr> saveOrSubmitAnswers(
      SaveOrSubmitAnswers event, Emitter<AuditFormState> emit) async {
    try {
      emit(AuditFormLoading());
      Position position;
      try {
        position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high, // Set desired accuracy
          ),
        );
      } catch (e) {
        emit(const AuditLocationDisable("Location Services Disabled. Please enable location services for this app in settings."));
        return null; // Add return null here to exit the function
      }
      questionId?.clear();
      answer?.clear();

      var qst = auditFormModel?.data!.questions;
      for (var item in qst!) {
        questionId?.add(item.qstnId.toString());
        answer?.add(item.answer.toString() == "1"
            ? "yes": item.answer.toString() == "2" ? "no" :"#");
        comments?.add(item.comment.toString()==""?"#}":"${item.comment.toString()}}");
        if(item.imageFileList!.isNotEmpty){
          String? id=item.qstnId.toString();
          questionImageId?.add(id.toString());
        }



      }

      var formData = FormData.fromMap({
        "type": event.saveType,
        "layout_id": event.layoutId,
        "answer": answer.toString(),
        "qstn_id": questionId.toString(),
        "comment":comments.toString(),
        "image_id":questionImageId.toString().trim(),
        "current_time": AppUtils.currentFullDateTimeFormat(DateTime.now()),
        "latitude": position.latitude,
        "longitude": position.longitude,

      });
      var result = auditFormModel?.data?.questions?.length;
      List.generate(
          result!,
          (indexQuestions) => {
                List.generate(
                    auditFormModel?.data?.questions![indexQuestions].imageFileList!.length ??0,
                        (index) => {
                          formData.files.add(MapEntry(
                              "images_${auditFormModel?.data?.questions![indexQuestions].qstnId}[${auditFormModel?.data?.questions![indexQuestions].imageFileList![index]}]",
                              MultipartFile.fromFileSync(auditFormModel?.data?.questions![indexQuestions].imageFileList![index].path ?? "",
                                  contentType: MediaType("image", "jpeg"),
                                  filename: auditFormModel?.data?.questions![indexQuestions].imageFileList![index].path.split('/').last)))
                        }),

              });
      await ApiRepository.saveOrSubmitAnswer(formData: formData)
          .then((value) async {
        if (value.statusCode == 200) {
          auditSubmitResponseModel = value;
          emit(const AuditFormLoaded());
          emit(ApisCallSuccess(value.message));
        } else if (value.statusCode == 201) {
          //CONFIRMATION
          emit(AuditFormConfirmation(value.message));
          emit(const AuditFormLoaded());
        } else if (value.statusCode == 202) {
          //ALERT
          emit(AuditFormAlert(value.message));
          emit(const AuditFormLoaded());
        } else if (value.statusCode == 403) {
          emit(AuditFormError(value.message));
          emit(const AuditFormLoaded());
        } else if (value.statusCode == 400) {
          emit(AuditAuthorization());
        } else {
          emit(AuditFormError(value.message));
          emit(const AuditFormLoaded());
        }
      });
    } catch (e) {
      emit(AuditFormException(e.toString()));
    }
  }

  Future<FutureOr> finalSubmitAnswers(
      FinalSubmitAnswers event, Emitter<AuditFormState> emit) async {
    try {
      emit(AuditFormLoading());
      var data = {
        "layout_id": event.layoutId,
        "current_time": AppUtils.currentFullDateTimeFormat(DateTime.now()),
      };
      debugPrint(data.toString());
      await ApiRepository.submitAuditAnswer(data: data).then((value) async {
        if (value.statusCode == 200) {
          auditSubmitResponseModel = value;
          imageFileList2?.clear();
          emit(const AuditFormLoaded());
          emit(ApisCallSuccess(value.message));
        } else if (value.statusCode == 403) {
          emit(AuditFormError(value.message));
        } else if (value.statusCode == 400) {
          emit(AuditAuthorization());
        } else {
          emit(AuditFormError(value.message));
        }
      });
    } catch (e) {
      emit(AuditFormException(e.toString()));
    }
  }

  FutureOr<void> selectImage(
      MultipleImageEvent event, Emitter<AuditFormState> emit) async {
    try {
      emit(AuditFormLoading());
      images = await _picker.pickMultiImage(imageQuality: 50);
      if (images!.isNotEmpty) {
        for (XFile im in images!) {
          tempPath = File(im.path);
          tempName = File(im.name);
          auditFormModel?.data?.questions![event.imageIndex].imageFileList?.add(tempPath);
          emit(const AuditFormLoaded());
        }
      } else {
        AppUtils.showErrorToast("No item selected");
        emit(const AuditFormLoaded());
      }
    } catch (e) {
      AppUtils.showToast("No item selected");
      emit(const AuditFormLoaded());
    }
  }

  FutureOr<void> selectCamera(
      MultipleCameraEvent event, Emitter<AuditFormState> emit) async {
    try {
      emit(AuditFormLoading());
      final XFile? selectedImage = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
      if (selectedImage != null) {
        tempPath = File(selectedImage.path);
        auditFormModel?.data?.questions![event.imageIndex].imageFileList
            ?.add(tempPath);
        emit(const AuditFormLoaded());
      } else {
        AppUtils.showErrorToast("No item selected");
        emit(const AuditFormLoaded());
      }
    } catch (e) {
      emit(const AuditFormLoaded());
    }
  }
}


