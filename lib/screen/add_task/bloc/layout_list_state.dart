part of 'layout_list_bloc.dart';

abstract class LayoutListState extends Equatable {
  const LayoutListState();
  @override
  List<Object> get props => [];
}

class LayoutListInitial extends LayoutListState {}

class LayoutListLoading extends LayoutListState {}
class LayoutAuthorization extends LayoutListState {}

class LayoutListEmpty extends LayoutListState {}

class LayoutListLoaded extends LayoutListState {
  const LayoutListLoaded();
}

class LayoutListError extends LayoutListState {
  final String? message;
  const LayoutListError(this.message);
}

class LayoutListException extends LayoutListState {
  final String? message;
  const LayoutListException(this.message);
}