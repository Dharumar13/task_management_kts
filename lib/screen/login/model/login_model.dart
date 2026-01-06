// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(Map<String, dynamic> json) => LoginModel.fromJson(json);

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  int? statusCode;
  bool? status;
  Data? data;
  String? message;

  LoginModel({
    this.statusCode,
    this.status,
     this.data,
     this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
  String? firstName;
  String? email;
  String? phone;
  String? token;
  int? candidateId;
  String? lastName;

  Data({
     this.firstName,
     this.email,
    this.phone,
     this.token,
     this.candidateId,
     this.lastName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    firstName: json["first_name"],
    email: json["email"],
    phone: json["phone"],
    token: json["token"],
    candidateId: json["candidate_id"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "email": email,
    "phone": phone,
    "token": token,
    "candidate_id": candidateId,
    "last_name": lastName,
  };
}
