import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';
import '../../../service/api_repository.dart';
import '../model/registration_model.dart';
part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  RegistrationModel?registrationModel;

  RegistrationBloc() : super(RegistrationInitial()) {
    on<RegistrationPost>(getLoginList);
    //Todo Developer can add more method here based on requirement
  }

  Future<FutureOr> getLoginList(
      RegistrationPost event, Emitter<RegistrationState> emit) async {
    try {
      emit(RegistrationLoading());
      var data={
        "name":fullNameController.text,
        "phone":mobileController.text,
        "email":emailController.text,
      };
      await ApiRepository.registrationNewUser(data: data).then((value) async {
        if (value.statusCode == 200) {
          registrationModel = value;
          emit(const RegistrationLoaded());
        } else if (value.statusCode == 403) {
          emit(RegistrationError(value.message));
        } else {
          emit(RegistrationError(value.message));
        }
      });

    } catch (e) {
      emit(RegistrationException(e.toString()));
    }
  }
}
