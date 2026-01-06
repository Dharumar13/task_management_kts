import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../service/api_repository.dart';
part 'my_profile_event.dart';
part 'my_profile_state.dart';


class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {


  MyProfileBloc() : super(MyProfileInitial()) {
    on<DeleteAccountEvent>(deleteAccount);
    on<LogOutEvent>(logOutAccount);

    //Todo Developer can add more method here based on requirement
  }

  Future<FutureOr> deleteAccount(
      DeleteAccountEvent event, Emitter<MyProfileState> emit) async {
    try {
      emit(MyProfileLoading());


      await ApiRepository.deleteAccount(
      )
          .then((value) async {
        if (value.statusCode == 200) {

          emit( MyProfileLoaded(value.message));
        } else if (value.statusCode == 403) {
          emit(MyProfileError(value.message));
        }
        else if (value.statusCode == 400) {
          emit(MyProfileAuthorization());
        }
        else {
          emit(MyProfileError(value.message));
        }
      });
    } catch (e) {
      emit(MyProfileException(e.toString()));
    }
  }

  Future<FutureOr> logOutAccount(
      LogOutEvent event, Emitter<MyProfileState> emit) async {
    try {
      emit(MyProfileLoading());


      await ApiRepository.logoutAccount(
      )
          .then((value) async {
        if (value.statusCode == 200) {

          emit( MyProfileLoaded(value.message));
        } else if (value.statusCode == 403) {
          emit(MyProfileError(value.message));
        }
        else if (value.statusCode == 400) {
          emit(MyProfileAuthorization());
        }
        else {
          emit(MyProfileError(value.message));
        }
      });
    } catch (e) {
      emit(MyProfileException(e.toString()));
    }
  }


}
