part of 'forgot_bloc.dart';

abstract class ForgotEvent extends Equatable {
  const ForgotEvent();

  @override
  List<Object> get props => [];
}

class ForgotPost extends ForgotEvent {

  const ForgotPost();


}