// To parse this JSON data, do
//
//     final profileUpdate = profileUpdateFromJson(jsonString);

import 'dart:convert';

ProfileUpdate profileUpdateFromJson(Map<String,dynamic>json) => ProfileUpdate.fromJson(json);

String profileUpdateToJson(ProfileUpdate data) => json.encode(data.toJson());

class ProfileUpdate {
  int? statusCode;
  bool? status;
  Data? data;
  bool? dataCode;
  String? message;

  ProfileUpdate({
    this.statusCode,
    this.status,
    this.data,
    this.dataCode,
    this.message,
  });

  factory ProfileUpdate.fromJson(Map<String, dynamic> json) => ProfileUpdate(
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
  String? email;
  String? phone;

  Data({
    this.email,
    this.phone,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    email: json["email"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "phone": phone,
  };
}
