// To parse this JSON data, do
//
//     final registrationModel = registrationModelFromJson(jsonString);

import 'dart:convert';

RegistrationModel registrationModelFromJson(Map<String,dynamic>json) => RegistrationModel.fromJson(json);

String registrationModelToJson(RegistrationModel data) => json.encode(data.toJson());

class RegistrationModel {
  int? statusCode;
  bool? status;
  Data? data;
  bool? dataCode;
  String? message;

  RegistrationModel({
    this.statusCode,
    this.status,
    this.data,
    this.dataCode,
    this.message,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) => RegistrationModel(
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
  int? registeredId;

  Data({
    this.registeredId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    registeredId: json["registered_id"],
  );

  Map<String, dynamic> toJson() => {
    "registered_id": registeredId,
  };
}
