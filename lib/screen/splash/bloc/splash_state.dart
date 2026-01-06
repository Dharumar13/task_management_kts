part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();
  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashLoaded extends SplashState {
  const SplashLoaded();
}

class SplashError extends SplashState {
  final String? message;
  const SplashError(this.message);
}

class SplashException extends SplashState {
  final String? message;
  const SplashException(this.message);
}

