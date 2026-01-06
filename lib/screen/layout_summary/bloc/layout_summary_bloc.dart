import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../app_utility/app_util.dart';
import '../../../service/api_repository.dart';
import '../model/layout_summary_model.dart';
part 'layout_summary_event.dart';
part 'layout_summary_state.dart';


class LayoutSummaryBloc extends Bloc<LayoutSummaryEvent, LayoutSummaryState> {
  LayoutSummaryModel? layoutSummaryModel;
  bool?layoutSummaryModelIsEmpty;
  TextEditingController searchController = TextEditingController();

  LayoutSummaryBloc() : super(LayoutSummaryInitial()) {
    on<GetLayoutSummaryList>(getAllLayoutSummaryList);

  }

  Future<FutureOr> getAllLayoutSummaryList(
      GetLayoutSummaryList event, Emitter<LayoutSummaryState> emit) async {
    try {
      emit(LayoutSummaryLoading());
      var data={
        "date":event.date,
        "type": event.type,
        "time": AppUtils.currentTimeFormat(DateTime.now()),
        "search": searchController.text,
        "site_id": event.siteId,
      };

      await ApiRepository.layouts(data: data).then((value) async {
        if (value.statusCode == 200) {
          layoutSummaryModel = value;
          layoutSummaryModelIsEmpty=layoutSummaryModel?.data?.isEmpty;
          emit(const LayoutSummaryLoaded());
        } else if (value.statusCode == 403) {
          emit(LayoutSummaryError(value.message));
        }
        else if(value.statusCode==400){
          emit(LayoutSummaryAuthorization());
        }
        else {
          emit(LayoutSummaryError(value.message));
        }
      });
    } catch (e) {
      emit(LayoutSummaryException(e.toString()));
    }
  }

}



