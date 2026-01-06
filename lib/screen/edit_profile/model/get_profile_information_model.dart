// To parse this JSON data, do
//
//     final profileInformation = profileInformationFromJson(jsonString);

import 'dart:convert';

ProfileInformation profileInformationFromJson(Map<String,dynamic>json) => ProfileInformation.fromJson(json);

String profileInformationToJson(ProfileInformation data) => json.encode(data.toJson());

class ProfileInformation {
  int? statusCode;
  bool? status;
  Data? data;
  bool? dataCode;
  String? message;

  ProfileInformation({
    this.statusCode,
    this.status,
    this.data,
    this.dataCode,
    this.message,
  });

  factory ProfileInformation.fromJson(Map<String, dynamic> json) => ProfileInformation(
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
  String? name;
  String? email;
  String? phone;
  String? profilePic;

  Data({
    this.name,
    this.email,
    this.phone,
    this.profilePic,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    profilePic: json["profile_pic"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "profile_pic": profilePic,
  };
}
