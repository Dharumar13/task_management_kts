part of 'layout_list_bloc.dart';

abstract class LayoutListEvent extends Equatable {
  const LayoutListEvent();
  @override
  List<Object> get props => [];
}

class GetLayoutList extends LayoutListEvent {
  final String date;
  final String siteId;
  const GetLayoutList(this.date, this.siteId);
}


class SelectedLayoutEvent extends LayoutListEvent {
  final int id;
  final String layoutName;
  const SelectedLayoutEvent(this.id, this.layoutName);
}
class SelectedIndexEvent extends LayoutListEvent {
  final int id;
  final bool isDescending;
  final String orderBy;
  final String siteId;
  const SelectedIndexEvent(this.id, this.isDescending, this.orderBy, this.siteId);
}
class SearchEvent extends LayoutListEvent {

  const SearchEvent();
}

