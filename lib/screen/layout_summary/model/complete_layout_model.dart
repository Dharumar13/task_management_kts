// To parse this JSON data, do
//
//     final completeLayoutModel = completeLayoutModelFromJson(jsonString);

import 'dart:convert';

CompleteLayoutModel completeLayoutModelFromJson(Map<String,dynamic> json) => CompleteLayoutModel.fromJson(json);

String completeLayoutModelToJson(CompleteLayoutModel data) => json.encode(data.toJson());

class CompleteLayoutModel {
  int? statusCode;
  bool? status;
  Data? data;
  bool? dataCode;
  String? message;

  CompleteLayoutModel({
    this.statusCode,
    this.status,
    this.data,
    this.dataCode,
    this.message,
  });

  factory CompleteLayoutModel.fromJson(Map<String, dynamic> json) => CompleteLayoutModel(
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
  int? id;

  Data({
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}
