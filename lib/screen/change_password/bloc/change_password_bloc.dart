import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../service/api_repository.dart';
import '../model/change_password_model.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordControllerController = TextEditingController();
  TextEditingController confirmPasswordControllerController = TextEditingController();
   bool?isVisible=true;
   bool?isVisible2=true;
   ChangePassword?changePassword;
  ChangePasswordBloc() : super(ChangePasswordInitial()) {
    on<ChangePasswordPostEvent>(getLoginList);
    on<VisiblePostEvent>(passwordVisible);
    on<VisibleConfirmPostEvent>(passwordConfirmVisible);
    //Todo Developer can add more method here based on requirement
  }

  Future<FutureOr> getLoginList(
      ChangePasswordPostEvent event, Emitter<ChangePasswordState> emit) async {
    try {
      emit(ChangePasswordLoading());
var data={

  "old_password":oldPasswordController.text,
  "new_password":newPasswordControllerController.text
};

      await ApiRepository.passwordChange(data: data
          )
          .then((value) async {
        if (value.statusCode == 200) {

          emit( ChangePasswordLoaded(value.message));
        } else if (value.statusCode == 403) {
          emit(ChangePasswordError(value.message));
        } else if (value.statusCode == 400) {
          emit(ChangeAuthorization());
        } else {
          emit(ChangePasswordError(value.message));
        }
      });
    } catch (e) {
      emit(ChangePasswordException(e.toString()));
    }
  }

  Future<FutureOr> passwordVisible(
      VisiblePostEvent event, Emitter<ChangePasswordState> emit) async {
    try {
      emit(ChangePasswordLoading());
      isVisible=event.isVisible;
      emit(ChangePasswordVisible());

    } catch (e) {
      emit(ChangePasswordException(e.toString()));
    }
  }
  Future<FutureOr> passwordConfirmVisible(
      VisibleConfirmPostEvent event, Emitter<ChangePasswordState> emit) async {
    try {
      emit(ChangePasswordLoading());
      isVisible2=event.isVisible;
      emit(ChangePasswordVisible());

    } catch (e) {
      emit(ChangePasswordException(e.toString()));
    }
  }
}
