import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../app_utility/app_util.dart';
import '../../../service/api_repository.dart';
import '../model/add_layout_members.dart';
part 'add_layout_member_event.dart';
part 'add_layout_member_state.dart';



class AddLayoutMemberBloc extends Bloc<AddLayoutMemberEvent, AddLayoutMemberState> {
  AddLayoutMembersModel? addLayoutMembersModel;
  List<String>? members = [];
  String layoutId = "";
  String layoutName = "";

  AddLayoutMemberBloc() : super(AddLayoutMemberInitial()) {
    on<GetLayoutMemberList>(getLayoutMemberList);
    on<AssignLayoutEvent>(assignLayout);
  }

  Future<FutureOr> getLayoutMemberList(
      GetLayoutMemberList event, Emitter<AddLayoutMemberState> emit) async {
    try {
      var data= {
        "layout_id": event.layoutId,
        "date": AppUtils.dateTimeFormat(DateTime.now())
      };
      emit(AddLayoutMemberLoading());
      emit(const AddLayoutMemberLoaded());
      /*
      await ApiRepository.layoutMemberList(data: data).then((value) async {
        if (value.statusCode == 200) {
          print(value.data);
          addLayoutMembersModel = value;
          debugPrint("1");
          emit(const AddLayoutMemberLoaded());
          debugPrint("2");
        } else if (value.statusCode == 403) {
          emit(AddLayoutMemberError(value.message));
        }
        else if (value.statusCode == 400) {
          emit(AddLayoutAuthorization());
        }
        else {
          emit(AddLayoutMemberError(value.message));
        }
      });
      */
    } catch (e) {
      print("except...");
      print(e);
      emit(AddLayoutMemberException(e.toString()));
    }
  }

  /*
  Future<FutureOr> addMemberEvent(
      AddMemberEvent event, Emitter<AddLayoutMemberState> emit) async {
    emit(AddLayoutMemberLoading());
    members?.add(event.id.toString());
    debugPrint(members?.length.toString());
    debugPrint(members.toString());
    emit(const AddLayoutMemberLoaded());
  }
  */

  /*
  Future<FutureOr> removeMemberEvent(
      RemoveMemberEvent event, Emitter<AddLayoutMemberState> emit) async {
    emit(AddLayoutMemberLoading());
    members?.removeAt(members!.indexOf(event.id.toString()));
    debugPrint(members?.length.toString());
    debugPrint(members.toString());
    emit(const AddLayoutMemberLoaded());
  }
  */

  Future<FutureOr> assignLayout(
      AssignLayoutEvent event, Emitter<AddLayoutMemberState> emit) async {
    try {
      emit(AddLayoutMemberLoading());
      var data = {
        "layout_id": layoutId,
        "date": AppUtils.dateTimeFormat(DateTime.now()) //SHOULD BE ONLY CURRENT DATE AND TIME
      };

      debugPrint(data.toString());
      await ApiRepository.assignLayoutToMember(data: data).then((value) async {
        if (value.statusCode == 200) {

          emit(AssignLayout(value.message));
        } else if (value.statusCode == 403) {
          emit(AddLayoutMemberError(value.message));
        }
        else if (value.statusCode == 400) {
          emit(AddLayoutAuthorization());
        }
        else {
          emit(AddLayoutMemberError(value.message));
        }
      });

    } catch (e) {
      print("except................${e.toString()}");
      print(e);
      emit(AddLayoutMemberException(e.toString()));
    }
  }
}
