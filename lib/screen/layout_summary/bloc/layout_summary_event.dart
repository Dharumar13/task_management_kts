part of 'layout_summary_bloc.dart';

abstract class LayoutSummaryEvent extends Equatable {
  const LayoutSummaryEvent();
  @override
  List<Object> get props => [];
}
class GetLayoutSummaryList extends LayoutSummaryEvent {
  final String type;
  final String date;
  final String siteId;
  const GetLayoutSummaryList(this.type, this.date, this.siteId);
}

class CompleteLayout extends LayoutSummaryEvent {
  final int layoutId;
  const CompleteLayout(this.layoutId);
}

