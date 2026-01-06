part of 'login_bloc.dart';


abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginRequestLoaded extends LoginState {

  const LoginRequestLoaded();
}

class LoginLoaded extends LoginState {
  const LoginLoaded();
}

class LoginError extends LoginState {
  final String? message;
  const LoginError(this.message);
}

class RegisterError extends LoginState {
  final String? message;
  const RegisterError(this.message);
}
class LoginException extends LoginState {
  final String? message;
  const LoginException(this.message);
}

class LogOutState extends LoginState {
  final String? message;
  const LogOutState(this.message);
}