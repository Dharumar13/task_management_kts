import 'package:task_management_kts/screen/audit_form/model/audit_form_model.dart';
import 'package:task_management_kts/service/services.dart';
import 'package:flutter/material.dart';
import '../app_utility/common_model.dart';
import '../screen/add_employee_task/model/add_layout_members.dart';
import '../screen/add_employee_task/model/assign_layout_model.dart';
import '../screen/add_task/model/layout_list_model.dart';
import '../screen/audit_form/model/audit_submit_response_model.dart';
import '../screen/audit_form/model/delete_image_file.dart';
import '../screen/change_password/model/change_password_model.dart';
import '../screen/edit_profile/model/get_profile_information_model.dart';
import '../screen/edit_profile/model/profile_update_model.dart';
import '../screen/forgot_passowrd/model/forgot_password_model.dart';
import '../screen/home/model/home_model.dart';
import '../screen/job_board/model/calender_data_model.dart';
import '../screen/job_board/model/job_board_model.dart';
import '../screen/job_board/model/location_validate_model.dart';
import '../screen/layout_summary/model/complete_layout_model.dart';
import '../screen/layout_summary/model/layout_summary_model.dart';
import '../screen/login/model/login_model.dart';
import '../screen/my_profile/model/logout_model.dart';
import '../screen/registration/model/registration_model.dart';




class ApiRepository {

  static Future<LoginModel> login(
      {required String username, required String password, required String deviceId}) async {
    var data = {"email": username, "password": password, "device_id": deviceId};
    return await HttpServices()
        .post("authentication/login", data: data)
        .then((value) {
      debugPrint("response:$value");
      return loginModelFromJson(value);
    });
  }

  static Future<LoginModel> deviceInfo(
      {Map? data}) async {
    return await HttpServices()
        .post("authentication/deviceInfo", data: data)
        .then((value) {
      debugPrint("response:$value");
      return loginModelFromJson(value);
    });
  }

  static Future<HomeModel> home(
      {required String date}) async {
    var data = {"date": date};
    debugPrint("request:$data");
    return await HttpServices()
        .post("layout/home", data: data)
        .then((value) {
      debugPrint("response:$value");
      return homeModelFromJson(value);
    });
  }

  static Future<JobBoardModel> jobBoard(
      {required String date}) async {
    var data = {"date": date};
    return await HttpServices()
        .post("/layout/jobBoard", data: data)
        .then((value) {
      debugPrint("response:$value");
      return jobBoardModelFromJson(value);
    });
  }

  static Future<LocationValidateModel> checkLocation(
      {Map? data}) async {
    return await HttpServices()
        .post("layout/verifyLocation", data: data)
        .then((value) {
      debugPrint("response:$value");
      return locationValidateModelFromJson(value);
    });
  }

  static Future<LayoutListModel> layoutList(
      {Map? data}) async {
    //var data = {"date": date};
    return await HttpServices()
        .post("/layout/layoutList", data: data)
        .then((value) {
      debugPrint("response:$value");
      return layoutListModelFromJson(value);
    });
  }

  static Future<AddLayoutMembersModel> layoutMemberList(
      {Map? data}) async {
    return await HttpServices()
        .post("/layout/layoutMembers", data: data)
        .then((value) {
      debugPrint("response:$value");
      return addLayoutMembersModelFromJson(value);
    });
  }

  static Future<AssignLayoutModel> assignLayoutToMember({Map? data}) async {
    return await HttpServices()
        .post("/layout/assignLayout", data: data)
        .then((value) {
      debugPrint("response:$value");
      return assignLayoutModelFromJson(value);
    });
  }

  static Future<LayoutSummaryModel> layouts(
      {Map? data}) async {
    return await HttpServices()
        .post("layout/assignedLayoutList", data: data)
        .then((value) {
      debugPrint("response:$value");
      return layoutSummaryModelFromJson(value);
    });
  }



  static Future<LayoutSummaryModel> layoutSummary(
      {Map? data}) async {
    return await HttpServices()
        .post("layout/taskSummary", data: data)
        .then((value) {
      debugPrint("response:$value");
      return layoutSummaryModelFromJson(value);
    });
  }

  static Future<CompleteLayoutModel> completeLayout(
      {required int layoutId}) async {
    var data = {"layout_id": layoutId};
    return await HttpServices()
        .post("layout/completeLayout", data: data)
        .then((value) {
      debugPrint("response:$value");
      return completeLayoutModelFromJson(value);
    });
  }

  static Future<AssignLayoutModel> startStopLayout({Map? data}) async {
    return await HttpServices()
        .post("/layout/processTask", data: data)
        .then((value) {
      debugPrint("response:$value");
      return assignLayoutModelFromJson(value);
    });
  }

  static Future<AssignLayoutModel> saveLayoutComment({Map? data}) async {
    return await HttpServices()
        .post("layout/saveComment", data: data)
        .then((value) {
      debugPrint("response:$value");
      return assignLayoutModelFromJson(value);
    });
  }

  //AUDIT
  static Future<AuditFormModel> auditQuestionList(
      {Map? data}) async {
    return await HttpServices()
        .post("question/auditQuestion", data: data)
        .then((value) {
      debugPrint("response:$value");
      return auditFormModelFromJson(value);
    });
  }



  static Future<AuditSubmitResponseModel> saveOrSubmitAnswer(
      {required dynamic formData}) async {
    return await HttpServices()
        .postMultipartFile("question/saveAuditAnswer", data: formData)
        .then((value) {
      debugPrint("response:$value");
      return auditSubmitResponseModelFromJson(value);
    });
  }

  static Future<AuditSubmitResponseModel> submitAuditAnswer(
      {Map? data}) async {
    debugPrint("request:$data");
    return await HttpServices()
        .post("question/submitAuditAnswers", data: data)
        .then((value) {
      debugPrint("response:$value");
      return auditSubmitResponseModelFromJson(value);
    });
  }

  static Future<DeleteImageFile> deleteAuditImage(
      {Map? data}) async {
    return await HttpServices()
        .post("question/deleteFile", data: data)
        .then((value) {
      debugPrint("response:$value");
      return deleteImageFileFromJson(value);
    });
  }



  static Future<CommonModel> checkInTask({required Map data}) async {
    final response =
    await HttpServices().post("taskSchedule/storeCheckIn", data: data);
    return commonModelFromJson(response);
  }
  static Future<ChangePassword> passwordChange(
      {Map? data}) async {
    return await HttpServices()
        .post("/authentication/changePassword", data:data)
        .then((value) {
      debugPrint("response:$value");
      return changePasswordFromJson(value);
    });
  }
  static Future<LogoutModel> logoutAccount() async {
    final response = await HttpServices().get("/authentication/logout");
    return logoutModelFromJson(response);
  }
  static Future<LogoutModel> deleteAccount() async {
    final response = await HttpServices().get("/authentication/delete_account");
    return logoutModelFromJson(response);
  }
  static Future<ProfileInformation> getProfileInformation() async {
    final response = await HttpServices().get("/authentication/profile");
    return profileInformationFromJson(response);
  }
  static Future<ProfileUpdate> updateProfile(
      {required dynamic formData}) async {
    return await HttpServices()
        .postMultipartFile("/authentication/editProfile", data:formData)
        .then((value) {
      debugPrint("response:$value");
      return profileUpdateFromJson(value);
    });
  }
  static Future<RegistrationModel> registrationNewUser(
      {Map? data}) async {

    return await HttpServices()
        .post("/authentication/register", data: data)
        .then((value) {
      debugPrint("response:$value");
      return registrationModelFromJson(value);
    });
  }
  static Future<ForgotPassword> forgotPassword(
      {Map? data}) async {

    return await HttpServices()
        .post("/authentication/forgotPassword", data: data)
        .then((value) {
      debugPrint("response:$value");
      return forgotPasswordFromJson(value);
    });
  }
  static Future<CalenderData> calenderData({Map? data}) async {
    return await HttpServices()
        .post("layout/layoutStatusForDate", data: data)
        .then((value) {
      debugPrint("response:$value");
      return calenderDataFromJson(value);
    });
  }
}