part of 'forgot_bloc.dart';

abstract class ForgotState extends Equatable {
  const ForgotState();

  @override
  List<Object?> get props => [];
}

class ForgotInitial extends ForgotState {}

class ForgotLoading extends ForgotState {}



class ForgotLoaded extends ForgotState {



  const ForgotLoaded();
}

class ForgotError extends ForgotState {
  final String? message;
  const ForgotError(this.message);
}


class ForgotException extends ForgotState {
  final String? message;
  const ForgotException(this.message);
}

