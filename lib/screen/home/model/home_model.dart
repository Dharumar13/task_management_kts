// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(Map<String,dynamic> json) => HomeModel.fromJson(json);

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  int? statusCode;
  bool? status;
  Data? data;
  String? message;

  HomeModel({
    this.statusCode,
     this.status,
    this.data,
     this.message,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
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
  List<Task>? tasks;
  Guide? guide;

  Data({
     this.tasks,
     this.guide,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
    guide: Guide.fromJson(json["guides"]),
  );

  Map<String, dynamic> toJson() => {
    "tasks": List<dynamic>.from(tasks!.map((x) => x.toJson())),
    "guides": guide!.toJson(),
  };
}


class Task {
  dynamic siteId;
  String? siteName;
  String? clientName;
  String? layoutDate;
  dynamic noOfTasks;

  Task({
    this.siteId,
    this.siteName,
    this.clientName,
    this.layoutDate,
    this.noOfTasks,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    siteId: json["site_id"],
    siteName: json["site_name"],
    clientName: json["client_name"],
    layoutDate: json["layout_date"],
    noOfTasks: json["no_of_tasks"],
  );

  Map<String, dynamic> toJson() => {
    "site_id": siteId,
    "site_name": siteName,
    "client_name": clientName,
    "layout_date": layoutDate,
    "no_of_tasks": noOfTasks,
  };
}


class Guide {
  int? id;
  String? clientName;
  String? siteName;
  String? agencyName;
  String? roleName;
  int? noOfTasks;
  String? taskDate;

  Guide({
    this.id,
    this.clientName,
    this.siteName,
    this.agencyName,
    this.roleName,
    this.noOfTasks,
    this.taskDate,
  });

  factory Guide.fromJson(Map<String, dynamic> json) => Guide(
    id: json["id"],
    clientName: json["client_name"],
    siteName: json["site_name"],
    agencyName: json["agency_name"],
    roleName: json["role_name"],
    noOfTasks: json["no_of_tasks"],
    taskDate: json["task_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "client_name": clientName,
    "site_name": siteName,
    "agency_name": agencyName,
    "role_name": roleName,
    "no_of_tasks": noOfTasks,
    "task_date": taskDate,
  };
}