import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../../../app_utility/app_constant.dart';
import '../../../service/api_repository.dart';
import 'dart:io';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  bool?isVisible2=true;
  String? token = '';
  String? deviceName;
  String? deviceVersion;
  String? identifier;

  SplashBloc() : super(SplashInitial()) {
    on<SplashInfo>(getInfo);
  }
    Future<FutureOr> getInfo(
        SplashInfo event, Emitter<SplashState> emit) async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName ="Android";
        deviceVersion = build.version.release;
        identifier = build.device; //UUID for Android
        print("here print id:$identifier");
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName ="iOS";
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      debugPrint("check");
    }

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
            print(value.data);

           emit(const SplashLoaded());
          } else if (value.statusCode == 403) {
            print(value.data);
            //emit(LayoutListError(value.message));
          }
          else if (value.statusCode == 400) {
            print(value.data);
            //emit(LayoutAuthorization());
          }
          else {
            //emit(LayoutListError(value.message));
          }
        });
      } catch (e) {
        print("except...");
        print(e);
        //emit(LayoutListException(e.toString()));
      }
    }


  }

