part of 'job_board_bloc.dart';

abstract class JobBoardState extends Equatable {
  const JobBoardState();
  @override
  List<Object> get props => [];
}

class JobBoardInitial extends JobBoardState {}

class JobBoardLoading extends JobBoardState {}
class JobBoardLoading2 extends JobBoardState {}

class JobBoardLoaded extends JobBoardState {
  const JobBoardLoaded();
}
class JobBoardEmpty extends JobBoardState
{const JobBoardEmpty();
}
class JobBoarLocationAlert extends JobBoardState {
  final bool inLocation;
  final String? siteId;
  final String? message;
  const JobBoarLocationAlert(this.inLocation, this.siteId, this.message);
}
class JobBoardAuthorization extends JobBoardState {
  const JobBoardAuthorization();
}

class JobBoardError extends JobBoardState {
  final String? message;
  const JobBoardError(this.message);
}
class JobBoardLocationDisable extends JobBoardState {
  final String? message;
  const JobBoardLocationDisable(this.message);
}
class JobBoardException extends JobBoardState {
  final String? message;
  const JobBoardException(this.message);
}
