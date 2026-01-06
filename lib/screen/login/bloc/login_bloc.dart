import 'dart:async';
import 'dart:io' show Platform;
import 'package:task_management_kts/app_utility/app_constant.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app_utility/preference_helper.dart';
import '../../../app_utility/singleton.dart';
import '../../../service/api_repository.dart';
import '../../../service/services.dart';
import '../model/login_model.dart';
part 'login_event.dart';
part 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool?isVisible2=true;
  String? token = '';
  String? deviceName;
  String? deviceVersion;
  String? identifier;
  LoginModel?loginModel;
  bool popCan = false;
  LoginBloc() : super(LoginInitial()) {
    on<GetLoginList>(getLoginList);
    on<VisiblePostEvent>(passwordConfirmVisible);
    on<PopScopeEventLogin>(popScope);
    //Todo Developer can add more method here based on requirement
  }

  Future<FutureOr> getLoginList(
      GetLoginList event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      getDeviceDetails();
      debugPrint("event.userName ${event.userName} event.password ${event.password} deviceId ${identifier.toString()}");
      await ApiRepository.login(
          username: event.userName, password: event.password, deviceId: identifier.toString())
          .then((value) async {
        if (value.statusCode == 200) {
          await PreferenceHelper.setLoginId(emailController.text);
          await PreferenceHelper.setPassword(passwordController.text);
          await PreferenceHelper.setUserId(value.data?.candidateId.toString());
          await PreferenceHelper.setUserName(value.data?.firstName);
          await PreferenceHelper.setLastName(value.data?.lastName);
          await PreferenceHelper.setToken(value.data?.token);
          Singleton().token = value.data!.token.toString();
          await PreferenceHelper.setEmailId(value.data?.email);
          Singleton().userFirstName = value.data!.firstName!;
          Singleton().emailID = value.data!.email.toString();
          Singleton().userLastName = value.data!.lastName!;
          HttpServices().setHeader();
          loginModel=value;
          deviceInfo();
          emit(const LoginLoaded());
          emit(const LoginRequestLoaded());
        } else if (value.statusCode == 401) {
          emit(LoginError(value.message));
        } else {
          emit(LoginError(value.message));
        }
      });
    } catch (e) {
      emit(LoginException(e.toString()));
    }
  }


  deviceInfo() async {

    try {
      var data= {
        "device_id": identifier,
        "device_name":deviceName,
        "fcm_key": "",
        "app_version": StringResource.version,
        "release_version":StringResource.releaseVersion
      };
      await ApiRepository.deviceInfo(data: data).then((value) async {
        if (value.statusCode == 200) {
        } else if (value.statusCode == 403) {
        }
        else if (value.statusCode == 400) {

        }
        else {

        }
      });
    } catch (e) {

      //emit(LayoutListException(e.toString()));
    }
  }
  getDeviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName ="Android";
        deviceVersion = build.version.release;
        identifier = build.device; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName ="iOS";
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
     //f
    }
  }
  Future<FutureOr> passwordConfirmVisible(
      VisiblePostEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoginLoading());
      isVisible2=event.isVisible;
      emit(const LoginLoaded());

    } catch (e) {
      emit(LoginException(e.toString()));
    }
  }

  Future<FutureOr> popScope(
      PopScopeEventLogin event, Emitter<LoginState> emit) async {

    emit(LoginLoading());
    popCan=event.value!;

    emit(const LoginLoaded());


  }
}
