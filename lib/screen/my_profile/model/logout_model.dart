// To parse this JSON data, do
//
//     final logoutModel = logoutModelFromJson(jsonString);

import 'dart:convert';

LogoutModel logoutModelFromJson(Map<String,dynamic>json) => LogoutModel.fromJson(json);

String logoutModelToJson(LogoutModel data) => json.encode(data.toJson());

class LogoutModel {
  int? statusCode;
  bool? status;
  Data? data;
  bool? dataCode;
  String? message;

  LogoutModel({
    this.statusCode,
    this.status,
    this.data,
    this.dataCode,
    this.message,
  });

  factory LogoutModel.fromJson(Map<String, dynamic> json) => LogoutModel(
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
  int? candidateId;

  Data({
    this.candidateId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    candidateId: json["candidate_id"],
  );

  Map<String, dynamic> toJson() => {
    "candidate_id": candidateId,
  };
}
