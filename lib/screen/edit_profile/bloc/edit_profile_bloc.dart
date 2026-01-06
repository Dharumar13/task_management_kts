import 'dart:async';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../app_utility/app_util.dart';
import '../../../service/api_repository.dart';
import '../model/get_profile_information_model.dart';
import 'edit_profile_state.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
part 'edit_profile_event.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  ProfileInformation?profileInformation;
  List<XFile>? images;
  final ImagePicker _picker = ImagePicker();
  var tempPath;
  var tempName;
  List<File>? imageFileList = [];

  EditProfileBloc() : super(EditProfileInitial()) {
    on<GetProfileInformationEvent>(getProfileInformation);
    on<ProfileUpdateEvent>(profileUpdate);
    on<ImageUpdateEvent>(selectImage);

    //Todo Developer can add more method here based on requirement
  }

  Future<FutureOr> getProfileInformation(
      GetProfileInformationEvent event, Emitter<EditProfileState> emit) async {
    try {
      emit(EditProfileLoading());
      await ApiRepository.getProfileInformation(
      ).then((value) async {
        if (value.statusCode == 200) {
          emailController.text=value.data!.email.toString();
          phoneController.text=value.data!.phone.toString();
          profileInformation=value;
          emit( const EditProfileLoaded());
        } else if (value.statusCode == 403) {
          emit(EditProfileError(value.message));
        } else if (value.statusCode == 400) {
          emit(EditAuthorization());
        }else {
          emit(EditProfileError(value.message));
        }
      });
    } catch (e) {
      emit(EditProfileException(e.toString()));
    }
  }


  Future<FutureOr> profileUpdate(
      ProfileUpdateEvent event, Emitter<EditProfileState> emit) async {
    try {
      emit(EditProfileLoading());
      var formData = FormData.fromMap({
        "email": emailController.text,
        "phone": phoneController.text,

      });
      List.generate(imageFileList!.length, (index) => {
        formData.files.add(MapEntry("profile_pic",
            MultipartFile.fromFileSync(imageFileList![0].path,contentType: MediaType("image", "jpeg"),filename: imageFileList![0].path.split('/').last)))
      });
      await ApiRepository.updateProfile(formData: formData
      ).then((value) async {
        if (value.statusCode == 200) {
          emit(EditProfileUpdate(value.message));
        } else if (value.statusCode == 403) {
          emit(EditProfileError(value.message));
        } else if (value.statusCode == 400) {
          emit(EditAuthorization());
        }else {
          emit(EditProfileError(value.message));
        }
      });
    } catch (e) {
      emit(EditProfileException(e.toString()));
    }
  }

  FutureOr<void> selectImage(
      ImageUpdateEvent event, Emitter<EditProfileState> emit) async {
    try{
      emit(EditProfileLoading());
      imageFileList!.clear();
      final XFile? selectedImage = await _picker.pickImage(
          source: event.img!, imageQuality:50,);
      if(selectedImage != null){
        tempPath = File(selectedImage.path);
        imageFileList!.add(tempPath);
        emit(const EditProfileLoaded());
      }else{
        AppUtils.showErrorToast("No item selected");
        emit(const EditProfileLoaded());
      }
    } catch(e) {

      emit(EditProfileException(e.toString()));
    }
  }
}
