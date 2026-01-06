part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class GetLoginList extends LoginEvent {
  final String userName;
  final String password;

  const GetLoginList(this.userName,this.password);


}
class VisiblePostEvent extends LoginEvent {
final  bool? isVisible;
 const VisiblePostEvent(this.isVisible);
}

class PopScopeEventLogin extends LoginEvent {
  final bool? value;
  const PopScopeEventLogin(this.value);
}