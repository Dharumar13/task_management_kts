// To parse this JSON data, do
//
//     final locationValidateModel = locationValidateModelFromJson(jsonString);

import 'dart:convert';

LocationValidateModel locationValidateModelFromJson(Map<String,dynamic> json) => LocationValidateModel.fromJson(json);

String locationValidateModelToJson(LocationValidateModel data) => json.encode(data.toJson());

class LocationValidateModel {
  int? statusCode;
  bool? status;
  Data? data;
  String? message;

  LocationValidateModel({
    this.statusCode,
    this.status,
    this.data,
    this.message,
  });

  factory LocationValidateModel.fromJson(Map<String, dynamic> json) => LocationValidateModel(
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
  int? distance;

  Data({
    this.distance,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    distance: json["distance"],
  );

  Map<String, dynamic> toJson() => {
    "distance": distance,
  };
}
