part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetHomeData extends HomeEvent {
  final DateTime date;
  const GetHomeData(this.date);
}
class PopScopeEvent extends HomeEvent {
  final bool? value;
  const PopScopeEvent(this.value);
}