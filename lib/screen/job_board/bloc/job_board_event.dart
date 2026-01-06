part of 'job_board_bloc.dart';

abstract class JobBoardEvent extends Equatable {
  const JobBoardEvent();
  @override
  List<Object> get props => [];
}

class GetJobBoardData extends JobBoardEvent {
  final String date;
  final DateTime selectedDay;
  final DateTime focusedDay;
  const GetJobBoardData(this.date,this.focusedDay,this.selectedDay);
}

class JobBoardLocationVerify extends JobBoardEvent {
  final String siteId;
  final double latitude;
  final double longitude;
  const JobBoardLocationVerify(this.siteId, this.latitude, this.longitude);
}
class GetCurrentDateTime extends JobBoardEvent {
  final DateTime date;
  const GetCurrentDateTime(this.date);
}
class ChangeWeekTime extends JobBoardEvent {
  final DateTime date;
  const ChangeWeekTime(this.date);
}
class JobBoardLocationFetching extends JobBoardEvent {
  final String siteId;
  /*final  Position? position;*/
  const JobBoardLocationFetching(this.siteId);
}

