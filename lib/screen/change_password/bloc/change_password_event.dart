part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordPostEvent extends ChangePasswordEvent {

  const ChangePasswordPostEvent();


}
class VisiblePostEvent extends ChangePasswordEvent {
final bool? isVisible;
const VisiblePostEvent(this.isVisible);
}
class VisibleConfirmPostEvent extends ChangePasswordEvent {
 final bool? isVisible;
 const VisibleConfirmPostEvent(this.isVisible);


}