part of 'add_layout_member_bloc.dart';

abstract class AddLayoutMemberEvent extends Equatable {
  const AddLayoutMemberEvent();
  @override
  List<Object> get props => [];
}

class GetLayoutMemberList extends AddLayoutMemberEvent {
  final String layoutId;
  const GetLayoutMemberList(this.layoutId);
}


class AddMemberEvent extends AddLayoutMemberEvent {
  final int id;
  const AddMemberEvent(this.id);
}

class RemoveMemberEvent extends AddLayoutMemberEvent {
  final int id;
  const RemoveMemberEvent(this.id);
}

class AssignLayoutEvent extends AddLayoutMemberEvent {}