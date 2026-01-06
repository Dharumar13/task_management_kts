
// To parse this JSON data, do
//
//     final calenderData = calenderDataFromJson(jsonString);

import 'dart:convert';

CalenderData calenderDataFromJson(Map<String,dynamic>json) => CalenderData.fromJson(json);

String calenderDataToJson(CalenderData data) => json.encode(data.toJson());

class CalenderData {
  int? statusCode;
  bool? status;
  Data? data;
  String? message;

  CalenderData({
    this.statusCode,
    this.status,
    this.data,
    this.message,
  });

  factory CalenderData.fromJson(Map<String, dynamic> json) => CalenderData(
    statusCode: json["status_code"],
    status: json["status"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status": status,
    "data": data!.toJson(),
    "message": message,
  };
}

class Data {
  List<LayoutStatus>? layoutStatus;

  Data({
    this.layoutStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    layoutStatus: List<LayoutStatus>.from(json["layout_status"].map((x) => LayoutStatus.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "layout_status": List<dynamic>.from(layoutStatus!.map((x) => x.toJson())),
  };
}

class LayoutStatus {
  String? date;
  String? status;
  int? assignedLayouts;

  LayoutStatus({
    this.date,
    this.status,
    this.assignedLayouts,
  });

  factory LayoutStatus.fromJson(Map<String, dynamic> json) => LayoutStatus(
    date:json["date"],
    status: json["status"],
    assignedLayouts: json["assigned_layouts"],
  );

  Map<String, dynamic> toJson() => {
    "date":date,
    "status": status,
    "assigned_layouts": assignedLayouts,
  };
}
