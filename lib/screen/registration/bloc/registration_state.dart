part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object?> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationRequestLoaded extends RegistrationState {


  const RegistrationRequestLoaded();
}

class RegistrationLoaded extends RegistrationState {



  const RegistrationLoaded();
}

class RegistrationError extends RegistrationState {
  final String? message;
  const RegistrationError(this.message);
}

class RegisterError extends RegistrationState {
  final String? message;
  const RegisterError(this.message);
}
class RegistrationException extends RegistrationState {
  final String? message;
  const RegistrationException(this.message);
}

