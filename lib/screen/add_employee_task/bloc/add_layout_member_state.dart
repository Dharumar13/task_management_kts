part of 'add_layout_member_bloc.dart';

abstract class AddLayoutMemberState extends Equatable {
  const AddLayoutMemberState();
  @override
  List<Object> get props => [];
}

class AddLayoutMemberInitial extends AddLayoutMemberState {

}
class AddLayoutMemberLoading extends AddLayoutMemberState {}
class AddLayoutAuthorization extends AddLayoutMemberState {}

class AddLayoutMemberEmpty extends AddLayoutMemberState {}

class AddLayoutMemberLoaded extends AddLayoutMemberState {
  const AddLayoutMemberLoaded();
}

class AssignLayout extends AddLayoutMemberState {
  final String? message;
  const AssignLayout(this.message);
}

class AddLayoutMemberError extends AddLayoutMemberState {
  final String? message;
  const AddLayoutMemberError(this.message);
}

class AddLayoutMemberException extends AddLayoutMemberState {
  final String? message;
  const AddLayoutMemberException(this.message);
}