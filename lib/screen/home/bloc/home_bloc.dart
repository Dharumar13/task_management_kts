import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:task_management_kts/app_utility/app_util.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../../service/api_repository.dart';
import '../model/home_model.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeModel? homeModel;
  bool? homeLength;
  bool popCan = false;

  HomeBloc() : super(HomeInitial()) {
    on<GetHomeData>(getHomeData);
    on<PopScopeEvent>(popScope);

  }

  Future<FutureOr> getHomeData(
      GetHomeData event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoading());
      await ApiRepository.home(date:AppUtils.dateTimeFormat(event.date)).then((value) async {
        if (value.statusCode == 200) {
          homeModel = value;
          homeLength = value.data?.tasks?.isEmpty;
          debugPrint(homeLength.toString());
         emit(const HomeLoaded());
        } else if (value.statusCode == 403) {
          emit(HomeError(value.message));
        } else if (value.statusCode == 400) {
          emit(HomeAuthorization());
        }else {
          emit(HomeError(value.message));
        }
      });
    } catch (e) {
      emit(HomeException(e.toString()));
    }
  }


  Future<FutureOr> popScope(
      PopScopeEvent event, Emitter<HomeState> emit) async {

    emit(HomeLoading());
    popCan=event.value!;

    emit(const HomeLoaded());


  }
}

