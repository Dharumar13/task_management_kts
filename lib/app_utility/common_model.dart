// To parse this JSON data, do
//
//     final commonModel = commonModelFromJson(jsonString);

import 'dart:convert';

CommonModel commonModelFromJson(Map<String, dynamic>json) => CommonModel.fromJson(json);

String commonModelToJson(CommonModel data) => json.encode(data.toJson());

class CommonModel {
  String statusCode;
  String status;
  List<dynamic> data;
  String message;

  CommonModel({
    required this.statusCode,
    required this.status,
    required this.data,
    required this.message,
  });

  factory CommonModel.fromJson(Map<String, dynamic> json) => CommonModel(
    statusCode: json["status_code"],
    status: json["status"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x)),
    "message": message,
  };
}
