part of 'layout_summary_bloc.dart';

abstract class LayoutSummaryState extends Equatable {
  const LayoutSummaryState();
  @override
  List<Object> get props => [];
}

class LayoutSummaryInitial extends LayoutSummaryState {}
class LayoutSummaryAuthorization extends LayoutSummaryState {}

class LayoutSummaryLoading extends LayoutSummaryState {}

class LayoutSummaryEmpty extends LayoutSummaryState {}

class LayoutSummaryLoaded extends LayoutSummaryState {
  const LayoutSummaryLoaded();
}

class LayoutSummaryReload extends LayoutSummaryState {
  final String? message;
  const LayoutSummaryReload(this.message);
}

class LayoutSummaryError extends LayoutSummaryState {
  final String? message;
  const LayoutSummaryError(this.message);
}

class LayoutSummaryException extends LayoutSummaryState {
  final String? message;
  const LayoutSummaryException(this.message);
}