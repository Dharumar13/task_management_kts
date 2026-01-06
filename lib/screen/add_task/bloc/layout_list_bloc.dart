import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../service/api_repository.dart';
import '../model/layout_list_model.dart';
import 'package:flutter/material.dart';
part 'layout_list_event.dart';
part 'layout_list_state.dart';

class LayoutListBloc extends Bloc<LayoutListEvent, LayoutListState> {
  LayoutListModel? layoutListModel;
  int? selectedId;
  int? selectedIndex=0;
  String? selectedLayoutName="";
  bool? isDescending = false;
  String? date = "";
  TextEditingController searchController = TextEditingController();
  LayoutListBloc() : super(LayoutListInitial()) {
    on<GetLayoutList>(getLayoutMembers);
    on<SelectedLayoutEvent>(selectedLayout);
    on<SelectedIndexEvent>(selectedIndexValuesChange);
    on<SearchEvent>(search);
  }

  Future<FutureOr> getLayoutMembers(
      GetLayoutList event, Emitter<LayoutListState> emit) async {
    try {
      date = event.date;
      var data= {
        "date": event.date,
        "sort":selectedIndex == 0 ? "all" : selectedIndex == 1 ? "seq_no" : selectedIndex == 2 ? "date" : "name",  //seq_no/date/name/all
        "order": "asc", // asc/desc
        "search": searchController.text,
        "site_id":event.siteId,
      };
      emit(LayoutListLoading());
      await ApiRepository.layoutList(data: data).then((value) async {
        if (value.statusCode == 200) {
          layoutListModel = value;
          emit(const LayoutListLoaded());
        } else if (value.statusCode == 403) {
          emit(LayoutListError(value.message));
        }
        else if (value.statusCode == 400) {
          emit(LayoutAuthorization());
        }
        else {
          emit(LayoutListError(value.message));
        }
      });
    } catch (e) {
      emit(LayoutListException(e.toString()));
    }
  }

  Future<FutureOr> selectedLayout(
      SelectedLayoutEvent event, Emitter<LayoutListState> emit) async {
    emit(LayoutListLoading());
    selectedId=event.id;
    selectedLayoutName=event.layoutName;
    emit(const LayoutListLoaded());

  }
  Future<FutureOr> selectedIndexValuesChange(
      SelectedIndexEvent event, Emitter<LayoutListState> emit) async {
    emit(LayoutListLoading());
    selectedIndex=event.id;
    isDescending = event.isDescending;
    try {
      var data= {
        "date": date,
        "sort":event.id == 0 ? "all" : event.id == 1 ? "seq_no" : event.id == 2 ? "date" : "name", //seq_no/date/name/all
        "order": event.orderBy, // asc/desc
        "site_id":event.siteId
      };
      emit(LayoutListLoading());
      await ApiRepository.layoutList(data: data).then((value) async {
        if (value.statusCode == 200) {
          layoutListModel = value;
          emit(const LayoutListLoaded());
        } else if (value.statusCode == 403) {
          emit(LayoutListError(value.message));
        }
        else if (value.statusCode == 400) {
          emit(LayoutAuthorization());
        }
        else {
          emit(LayoutListError(value.message));
        }
      });
    } catch (e) {
      emit(LayoutListException(e.toString()));
    }

  }
  Future<FutureOr> search(
      SearchEvent event, Emitter<LayoutListState> emit) async {
    emit(LayoutListLoading());

    emit(const LayoutListLoaded());

  }
}
