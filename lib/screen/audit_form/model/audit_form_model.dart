// To parse this JSON data, do
//
//     final auditFormModel = auditFormModelFromJson(jsonString);
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'dart:io';



AuditFormModel auditFormModelFromJson(Map<String,dynamic>json) => AuditFormModel.fromJson(json);

String auditFormModelToJson(AuditFormModel data) => json.encode(data.toJson());

class AuditFormModel {
  int? statusCode;
  bool? status;
  Data? data;
  String? message;

  AuditFormModel({
    this.statusCode,
    this.status,
    this.data,
    this.message,
  });

  factory AuditFormModel.fromJson(Map<String, dynamic> json) => AuditFormModel(
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
  List<Question>? questions;
  bool? submitted;
  bool? withInLocation;
  String? layoutName;

  Data({
    this.questions,
    this.submitted,
    this.layoutName,
    this.withInLocation
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
    submitted: json["submitted"],
    withInLocation: json["withInLocation"],
    layoutName: json["layout_name"],
  );

  Map<String, dynamic> toJson() => {
    "questions": List<dynamic>.from(questions!.map((x) => x.toJson())),
    "submitted": submitted,
    "withInLocation":withInLocation,
    "layout_name": layoutName,
  };
}

class Question {
  int? qstnId;
  String? question;
  String? qstnType;
  int? typeId;
  List<String>? choice;
  int? mandatory;
  int? answer;
  String? ansReqired;
  String? comment;
  int? imgUpload;
  int? imgMandatory;
  List<Image>? images;
  List<File>? imageFileList;

  Question({
    this.qstnId,
    this.question,
    this.qstnType,
    this.typeId,
    this.choice,
    this.mandatory,
    this.answer,
    this.ansReqired,
    this.comment,
    this.imgUpload,
    this.imgMandatory,
    this.images,
    this.imageFileList
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    qstnId: json["qstn_id"],
    question: json["question"],
    qstnType: json["qstn_type"],
    typeId: json["type_id"],
    choice: List<String>.from(json["choice"].map((x) => x)),
   // imageFileList: List<File>.from(json["imageFileList"].map((x) => x)),
    mandatory: json["mandatory"],
   // imageFileList: List<String>.from(json["imageFileList"].map((x) => x)), // Update this line
    answer: json["answer"],
    ansReqired: json["ans_reqired"],
    comment: json["comment"],
    imgUpload: json["img_upload"],
    imgMandatory: json["img_mandatory"],
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    imageFileList: json["imageFileList"] != null
        ? List<File>.from(json["imageFileList"].map((x) {
      String path = x["url"]; // Assuming the URL key is "url"
      return File(path);
    }))
        : [], // If imageFileList is null, initialize it as an empty list

  );

  Map<String, dynamic> toJson() => {
    "qstn_id": qstnId,
    "question": question,
    "qstn_type": qstnType,
    "type_id": typeId,
    "choice": List<dynamic>.from(choice!.map((x) => x)),
    "mandatory": mandatory,
    "answer": answer,
    "ans_reqired": ansReqired,
    "comment": comment,
    "img_upload": imgUpload,
    "img_mandatory": imgMandatory,
    "images": List<dynamic>.from(images!.map((x) => x.toJson())),
    "imageFileList": List<dynamic>.from(imageFileList!.map((x) => x)), // Update this line
    //"imageFileList": List<dynamic>.from(imageFileList!.map((x) => x)),
  };
}

class Image {
  String? id;
  String? url;

  Image({
    this.id,
    this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
  };
}
