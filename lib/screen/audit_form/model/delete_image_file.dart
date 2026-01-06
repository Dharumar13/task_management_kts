// To parse this JSON data, do
//
//     final deleteImageFile = deleteImageFileFromJson(jsonString);

import 'dart:convert';

DeleteImageFile deleteImageFileFromJson(Map<String,dynamic>json) => DeleteImageFile.fromJson(json);

String deleteImageFileToJson(DeleteImageFile data) => json.encode(data.toJson());

class DeleteImageFile {
  int? statusCode;
  bool? status;
  Data? data;
  bool? dataCode;
  String? message;

  DeleteImageFile({
    this.statusCode,
    this.status,
    this.data,
    this.dataCode,
    this.message,
  });

  factory DeleteImageFile.fromJson(Map<String, dynamic> json) => DeleteImageFile(
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
