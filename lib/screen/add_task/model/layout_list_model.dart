// To parse this JSON data, do
//
//     final layoutListModel = layoutListModelFromJson(jsonString);

import 'dart:convert';

LayoutListModel layoutListModelFromJson(Map<String,dynamic> json) => LayoutListModel.fromJson(json);

String layoutListModelToJson(LayoutListModel data) => json.encode(data.toJson());
class LayoutListModel {
  int? statusCode;
  bool? status;
  List<Datum>? data;
  String? message;

  LayoutListModel({
    this.statusCode,
    this.status,
    this.data,
    this.message,
  });

  factory LayoutListModel.fromJson(Map<String, dynamic> json) => LayoutListModel(
    statusCode: json["status_code"],
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  int? id;
  String? layoutName;
  dynamic duration;
  String? date;
  String? day;
  int? seqNo;
  bool? assigned;

  Datum({
    this.id,
    this.layoutName,
    this.duration,
    this.date,
    this.day,
    this.seqNo,
    this.assigned,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    layoutName: json["layout_name"],
    duration: json["duration"],
    date: json["date"],
    day: json["day"],
    seqNo: json["seq_no"],
    assigned: json["assigned"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "layout_name": layoutName,
    "duration": duration,
    "date": date,
    "day": day,
    "seq_no": seqNo,
    "assigned": assigned,
  };
}
