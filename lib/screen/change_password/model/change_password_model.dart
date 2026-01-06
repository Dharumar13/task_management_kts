// To parse this JSON data, do
//
//     final changePassword = changePasswordFromJson(jsonString);

import 'dart:convert';

ChangePassword changePasswordFromJson(Map<String,dynamic>json) => ChangePassword.fromJson(json);

String changePasswordToJson(ChangePassword data) => json.encode(data.toJson());

class ChangePassword {
  int? statusCode;
  bool? status;
  Data? data;
  bool? dataCode;
  String? message;

  ChangePassword({
    this.statusCode,
    this.status,
    this.data,
    this.dataCode,
    this.message,
  });

  factory ChangePassword.fromJson(Map<String, dynamic> json) => ChangePassword(
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
