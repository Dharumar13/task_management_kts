// To parse this JSON data, do
//
//     final auditSubmitResponseModel = auditSubmitResponseModelFromJson(jsonString);

import 'dart:convert';

AuditSubmitResponseModel auditSubmitResponseModelFromJson(Map<String,dynamic> json) => AuditSubmitResponseModel.fromJson(json);

String auditSubmitResponseModelToJson(AuditSubmitResponseModel data) => json.encode(data.toJson());

class AuditSubmitResponseModel {
  int? statusCode;
  bool? status;
  Data? data;
  bool? dataCode;
  String? message;

  AuditSubmitResponseModel({
    this.statusCode,
    this.status,
    this.data,
    this.dataCode,
    this.message,
  });

  factory AuditSubmitResponseModel.fromJson(Map<String, dynamic> json) => AuditSubmitResponseModel(
    statusCode: json["status_code"],
    status: json["status"],
    data: Data.fromJson(json["data"]),
    dataCode: json["data_code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status": status,
    "data": data!.toJson(),
    "data_code": dataCode,
    "message": message,
  };
}

class Data {
  dynamic layoutId;
  String? ansStatus;

  Data({
    this.layoutId,
    this.ansStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    layoutId: json["layout_id"],
    ansStatus: json["ans_status"],
  );

  Map<String, dynamic> toJson() => {
    "layout_id": layoutId,
    "ans_status": ansStatus,
  };
}
