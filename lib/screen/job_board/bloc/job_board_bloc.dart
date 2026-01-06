import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:task_management_kts/app_utility/app_util.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../service/api_repository.dart';
import '../model/calender_data_model.dart';
import '../model/job_board_model.dart';
part 'job_board_event.dart';
part 'job_board_state.dart';

class JobBoardBloc extends Bloc<JobBoardEvent, JobBoardState> {
  JobBoardModel? jobBoardModel;
  CalenderData?calenderData;

  late DateTime selectedDay;
  late DateTime focusedDay;

  DateTime?updateSelectedDay;
  DateTime?updateFocusDay;
  String? position;
  CalendarFormat calendarFormat = CalendarFormat.month;
bool? type;
  JobBoardBloc() : super(JobBoardInitial()) {
    on<GetJobBoardData>(getJobBoardData);
    on<GetCurrentDateTime>(changeCurrentTime);
    on<ChangeWeekTime>(changeWeek);
    on<JobBoardLocationFetching>(fetchingLocation);

  }

  Future<FutureOr> getJobBoardData(
      GetJobBoardData event, Emitter<JobBoardState> emit) async {
    try {
      emit(JobBoardLoading());
     selectedDay = event.selectedDay;
      focusedDay =event.focusedDay;
   var data={
     "date":event.date
   };

      await ApiRepository.jobBoard(date:event.date).then((value) async {
        if (value.statusCode == 200) {
          jobBoardModel = value;
          await ApiRepository.calenderData(data:data).then((value) async {
            if (value.statusCode == 200) {
              calenderData = value;
              emit(const JobBoardLoaded());

          }});

          if(jobBoardModel?.data!.length == 0 || jobBoardModel == null){
            debugPrint("inside null check");
            emit(const JobBoardEmpty());
          }else{

          }

        } else if (value.statusCode == 403) {
          emit(JobBoardError(value.message));
        }else if(value.statusCode==400){
          print("in valid token");
          emit(const JobBoardAuthorization());
        }
        else {
          emit(JobBoardError(value.message));
        }
      });
    } catch (e) {
      emit(JobBoardException(e.toString()));
    }
  }




  Future<FutureOr> changeCurrentTime(
      GetCurrentDateTime event, Emitter<JobBoardState> emit) async {
    try {
      emit(JobBoardLoading());
      focusedDay=event.date;
      emit(const JobBoardLoaded());

    } catch (e) {
      emit(JobBoardException(e.toString()));
    }
  }
  Future<FutureOr> changeWeek(
      ChangeWeekTime event, Emitter<JobBoardState> emit) async {
    try {
      emit(JobBoardLoading());
      focusedDay=event.date;
      var data={
        "date":AppUtils.dateTimeFormat(event.date)
      };
      await ApiRepository.calenderData(data:data).then((value) async {
        if (value.statusCode == 200) {
          calenderData = value;
          emit(const JobBoardLoaded());

        } else if (value.statusCode == 403) {
          emit(JobBoardError(value.message));
        }else if(value.statusCode==400){
          emit(const JobBoardAuthorization());
        }
        else {
          emit(JobBoardError(value.message));
        }
      });
      emit(const JobBoardLoaded());

    } catch (e) {
      emit(JobBoardException(e.toString()));
    }
  }
  Future<FutureOr<void>> fetchingLocation(
      JobBoardLocationFetching event, Emitter<JobBoardState> emit) async {
    try {
      emit(JobBoardLoading());

      Position position;
      try {
        position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      } catch (e) {
        emit(const JobBoardLocationDisable("Location Services Disabled. Please enable location services for this app in settings."));
        return null; // Add return null here to exit the function
      }
      var data = {
        "site_id": event.siteId,
        "latitude": position.latitude,
        "longitude": position.longitude,
        "current_date_time": AppUtils.currentDateTimeFormat(DateTime.now()),
      };

      await ApiRepository.checkLocation(data: data).then((value) async {
        if (value.statusCode == 200) {
          emit(const JobBoardLoaded());
          emit(JobBoarLocationAlert(true, event.siteId, value.message));
        } else if (value.statusCode == 202) {
          emit(JobBoarLocationAlert(false, event.siteId, value.message));
          emit(const JobBoardLoaded());
        } else if (value.statusCode == 403) {
          emit(JobBoardError(value.message));
        } else if (value.statusCode == 400) {
          emit(const JobBoardAuthorization());
        } else {
          emit(JobBoardError(value.message));
        }
      });

      emit(const JobBoardLoaded());
    } catch (e) {
      emit(JobBoardException(e.toString()));
    }
  }


}
