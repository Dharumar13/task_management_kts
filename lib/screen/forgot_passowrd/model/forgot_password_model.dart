// To parse this JSON data, do
//
//     final forgotPassword = forgotPasswordFromJson(jsonString);

import 'dart:convert';

ForgotPassword forgotPasswordFromJson(Map<String,dynamic>json) => ForgotPassword.fromJson(json);

String forgotPasswordToJson(ForgotPassword data) => json.encode(data.toJson());

class ForgotPassword {
  int? statusCode;
  bool? status;
  Data? data;
  bool? dataCode;
  String? message;

  ForgotPassword({
    this.statusCode,
    this.status,
    this.data,
    this.dataCode,
    this.message,
  });

  factory ForgotPassword.fromJson(Map<String, dynamic> json) => ForgotPassword(
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

  Data({
    this.email,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}
