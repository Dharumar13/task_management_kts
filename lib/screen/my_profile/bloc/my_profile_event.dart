part of 'my_profile_bloc.dart';

abstract class MyProfileEvent extends Equatable {
  const MyProfileEvent();

  @override
  List<Object> get props => [];
}

class MyProfileGetEvent extends MyProfileEvent {

  const MyProfileGetEvent();


}
class DeleteAccountEvent extends MyProfileEvent {

  const DeleteAccountEvent();
}
class LogOutEvent extends MyProfileEvent {

  const LogOutEvent();


}