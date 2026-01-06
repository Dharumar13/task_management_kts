// To parse this JSON data, do
//
//     final layoutSummaryModel = layoutSummaryModelFromJson(jsonString);

import 'dart:convert';

LayoutSummaryModel layoutSummaryModelFromJson(Map<String,dynamic> json) => LayoutSummaryModel.fromJson(json);

String layoutSummaryModelToJson(LayoutSummaryModel data) => json.encode(data.toJson());

class LayoutSummaryModel {
  int? statusCode;
  bool? status;
  List<Datum>? data;
  String? message;

  LayoutSummaryModel({
    this.statusCode,
    this.status,
    this.data,
    this.message,
  });

  factory LayoutSummaryModel.fromJson(Map<String, dynamic> json) => LayoutSummaryModel(
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
  String? typeFormUrl;
  String? layoutName;
  bool? completed;
  String? auditStatus;

  Datum({
    this.id,
    this.typeFormUrl,
    this.layoutName,
    this.completed,
    this.auditStatus,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    typeFormUrl: json["audit_form_url"],
    layoutName: json["layout_name"],
    completed: json["completed"],
    auditStatus: json["audit_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "audit_form_url": typeFormUrl,
    "layout_name": layoutName,
    "completed": completed,
    "audit_status": auditStatus,
  };
}