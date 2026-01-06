part of 'change_password_bloc.dart';


abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object?> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}
class ChangePasswordVisible extends ChangePasswordState {}
class ChangePasswordLoaded extends ChangePasswordState {
  final String? message;
  const ChangePasswordLoaded(this.message);
}

class ChangeAuthorization extends ChangePasswordState {}

class ChangePasswordError extends ChangePasswordState {
  final String? message;
  const ChangePasswordError(this.message);
}

class ChangePasswordException extends ChangePasswordState {
  final String? message;
  const ChangePasswordException(this.message);
}


