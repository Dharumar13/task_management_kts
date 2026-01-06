// To parse this JSON data, do
//
//     final addLayoutMembersModel = addLayoutMembersModelFromJson(jsonString);

import 'dart:convert';

AddLayoutMembersModel addLayoutMembersModelFromJson(Map<String,dynamic> json) => AddLayoutMembersModel.fromJson(json);

String addLayoutMembersModelToJson(AddLayoutMembersModel data) => json.encode(data.toJson());

class AddLayoutMembersModel {
  int? statusCode;
  bool? status;
  Data? data;
  bool? dataCode;
  String? message;

  AddLayoutMembersModel({
    this.statusCode,
    this.status,
    this.data,
    this.dataCode,
    this.message,
  });

  factory AddLayoutMembersModel.fromJson(Map<String, dynamic> json) => AddLayoutMembersModel(
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
  dynamic layoutId;
  String? layoutName;
  dynamic duration;
  String? date;
  String? day;
  List<Member>? members;

  Data({
    this.layoutId,
    this.layoutName,
    this.duration,
    this.date,
    this.day,
    this.members,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    layoutId: json["layout_id"],
    layoutName: json["layout_name"],
    duration: json["duration"],
    date: json["date"],
    day: json["day"],
    members: List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "layout_id": layoutId,
    "layout_name": layoutName,
    "duration": duration,
    "date": date,
    "day": day,
    "members": List<dynamic>.from(members!.map((x) => x.toJson())),
  };
}

class Member {
  dynamic candidateId;
  String? firstName;
  String? lastName;
  String? name;
  bool? assigned;

  Member({
    this.candidateId,
    this.firstName,
    this.lastName,
    this.name,
    this.assigned,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    candidateId: json["candidate_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    name: json["name"],
    assigned: json["assigned"],
  );

  Map<String, dynamic> toJson() => {
    "candidate_id": candidateId,
    "first_name": firstName,
    "last_name": lastName,
    "name": name,
    "assigned": assigned,
  };
}
