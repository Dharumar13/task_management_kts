import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';
import '../../../service/api_repository.dart';
import '../model/forgot_password_model.dart';
part 'forgot_event.dart';
part 'forgot_state.dart';


class ForgotBloc extends Bloc<ForgotEvent, ForgotState> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  ForgotPassword?forgotPassword;

  ForgotBloc() : super(ForgotInitial()) {
    on<ForgotPost>(getLoginList);
    //Todo Developer can add more method here based on requirement
  }

  Future<FutureOr> getLoginList(
      ForgotPost event, Emitter<ForgotState> emit) async {
    try {
      emit(ForgotLoading());
      var data={
        "email":emailController.text,

      };
      await ApiRepository.forgotPassword(data: data).then((value) async {
        if (value.statusCode == 200) {
          forgotPassword = value;

          emit(const ForgotLoaded());
        } else if (value.statusCode == 403) {
          emit(ForgotError(value.message));
        } else {
          emit(ForgotError(value.message));
        }
      });

    } catch (e) {
      emit(ForgotException(e.toString()));
    }
  }
}
