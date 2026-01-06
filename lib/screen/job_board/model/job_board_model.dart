/*
// To parse this JSON data, do
//
//     final jobBoardModel = jobBoardModelFromJson(jsonString);

import 'dart:convert';

JobBoardModel jobBoardModelFromJson(Map<String,dynamic> json) => JobBoardModel.fromJson(json);

String jobBoardModelToJson(JobBoardModel data) => json.encode(data.toJson());

class JobBoardModel {
  int? statusCode;
  bool? status;
  List<Datum>? data;
  String? message;

  JobBoardModel({
    this.statusCode,
    this.status,
    this.data,
    this.message,
  });

  factory JobBoardModel.fromJson(Map<String, dynamic> json) => JobBoardModel(
    statusCode: json["status_code"],
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  String? siteId;
  String? siteName;
  String? clientName;
  String? layoutDate;
  int? noOfTasks;
  int? completed;
  int? notCompleted;

  Datum({
    this.siteId,
    this.siteName,
    this.clientName,
    this.layoutDate,
    this.noOfTasks,
    this.completed,
    this.notCompleted,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    siteId: json["site_id"],
    siteName: json["site_name"],
    clientName: json["client_name"],
    layoutDate: json["layout_date"],
    noOfTasks: json["no_of_tasks"],
    completed: json["completed"],
    notCompleted: json["not_completed"],
  );

  Map<String, dynamic> toJson() => {
    "site_id": siteId,
    "site_name": siteName,
    "client_name": clientName,
    "layout_date": layoutDate,
    "no_of_tasks": noOfTasks,
    "completed": completed,
    "not_completed": notCompleted,
  };
}


*/
// To parse this JSON data, do
//
//     final jobBoardModel = jobBoardModelFromJson(jsonString);

import 'dart:convert';

JobBoardModel jobBoardModelFromJson(Map<String,dynamic>json) => JobBoardModel.fromJson(json);

String jobBoardModelToJson(JobBoardModel data) => json.encode(data.toJson());

class JobBoardModel {
  int? statusCode;
  bool? status;
  List<Datum>? data;
  PrivacyPolicy? privacyPolicy;
  String? message;

  JobBoardModel({
    this.statusCode,
    this.status,
    this.data,
    this.privacyPolicy,
    this.message,
  });

  factory JobBoardModel.fromJson(Map<String, dynamic> json) => JobBoardModel(
    statusCode: json["status_code"],
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    privacyPolicy: PrivacyPolicy.fromJson(json["privacy_policy"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "privacy_policy": privacyPolicy!.toJson(),
    "message": message,
  };
}

class Datum {
  String? siteId;
  String? siteName;
  String? clientName;
  String? layoutDate;
  int? noOfTasks;
  int? completed;
  int? notCompleted;

  Datum({
    this.siteId,
    this.siteName,
    this.clientName,
    this.layoutDate,
    this.noOfTasks,
    this.completed,
    this.notCompleted,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    siteId: json["site_id"],
    siteName: json["site_name"],
    clientName: json["client_name"],
    layoutDate:json["layout_date"],
    noOfTasks: json["no_of_tasks"],
    completed: json["completed"],
    notCompleted: json["not_completed"],
  );

  Map<String, dynamic> toJson() => {
    "site_id": siteId,
    "site_name": siteName,
    "client_name": clientName,
    "layout_date": layoutDate,
    "no_of_tasks": noOfTasks,
    "completed": completed,
    "not_completed": notCompleted,
  };
}
class PrivacyPolicy {
  String? notice;
  String? policyUrl;
  int? privacyStatus;

  PrivacyPolicy({
    this.notice,
    this.policyUrl,
    this.privacyStatus,
  });

  factory PrivacyPolicy.fromJson(Map<String, dynamic> json) => PrivacyPolicy(
    notice: json["notice"],
    policyUrl: json["policy_url"],
    privacyStatus: json["privacy_status"],
  );

  Map<String, dynamic> toJson() => {
    "notice": notice,
    "policy_url": policyUrl,
    "privacy_status": privacyStatus,
  };
}