part of 'my_profile_bloc.dart';


abstract class MyProfileState extends Equatable {
  const MyProfileState();

  @override
  List<Object?> get props => [];
}

class MyProfileInitial extends MyProfileState {}
class MyProfileAuthorization extends MyProfileState {}

class MyProfileLoading extends MyProfileState {}

class MyProfileLoaded extends MyProfileState {
  final String? message;
  const MyProfileLoaded(this.message);
}

class MyProfileError extends MyProfileState {
  final String? message;
  const MyProfileError(this.message);
}

class MyProfileException extends MyProfileState {
  final String? message;
  const MyProfileException(this.message);
}


