part of 'home_bloc.dart';


abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeRequestLoaded extends HomeState {
 // final HomeModel loginModel;
 // const HomeRequestLoaded(this.loginModel);
}

class HomeLoaded extends HomeState {
  const HomeLoaded();
}

class HomeAuthorization extends HomeState {}

class HomeError extends HomeState {
  final String? message;
  const HomeError(this.message);
}

class HomeException extends HomeState {
  final String? message;
  const HomeException(this.message);
}

