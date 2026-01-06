import 'dart:async';
import 'package:task_management_kts/app_utility/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_utility/color_resource.dart';
import '../../app_utility/constant.dart';
import '../../app_utility/image_resource.dart';
import '../../app_utility/internet_connection_checker.dart';
import '../../app_utility/preference_helper.dart';
import '../../app_utility/singleton.dart';
import '../../router/router_names.dart';
import '../../service/services.dart';
import 'bloc/splash_bloc.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription<bool>? _networkSubscription; // Store the subscription
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  String? greetings;

  @override
  void initState() {
    NetworkService().initialize().then((_) {
      NetworkService().monitorNetwork();
      _networkSubscription = NetworkService().connectionStream.listen((isConnected) {
        if (!mounted) return;

        setState(() {
          Singleton().isConnection = isConnected;
        });


      });
    });

    super.initState();
    _initializeApp();

  }

  Future<void> _initializeApp() async {
    try {
      await _setTokenValue();

      Timer(const Duration(seconds:1), () {
       _navigateToNextScreen();
      });
    } catch (e) {
     debugPrint(e.toString());

    }
  }


  Future<void> _setTokenValue() async {
    try {
      Singleton().token = await PreferenceHelper.getToken();
      Singleton().userFirstName = await PreferenceHelper.getUserName();
      Singleton().emailID = await PreferenceHelper.getEmailId();
      Singleton().image = await PreferenceHelper.getUserImage();
      Singleton().userLastName = await PreferenceHelper.getLastName();
      HttpServices().setHeader();
    } catch (e) {
debugPrint(e.toString());
    }
  }

  void _navigateToNextScreen() async {
    try {
      SharedPreferences.getInstance().then((value) {
        if (value.getBool(SharedPrefKeys.isLogin) == null) {
          context.goNamed(RouterNames.loginRouter);
        } else {
          if (value.getBool(SharedPrefKeys.isLogin) == true) {
            context.goNamed(RouterNames.jobBoardRouter);
            context.read<SplashBloc>().add(const SplashInfo());
          } else {
            context.goNamed(RouterNames.loginRouter);
          }
        }
      });
    } catch (e) {
      print('Error navigating to next screen: $e');
    }
  }

  @override
  void dispose() {
    _networkSubscription?.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc,SplashState>(builder: (context,state){
      return  Container(
          height: MediaQuery.sizeOf(context).height,
          color: ColorResource.colorWhite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Image.asset(ImageResource.pactSplashScreen,height: AppUtils.getDeviceType()=="tablet"?250:200,width:  AppUtils.getDeviceType()=="tablet"?250:200)),
            ],
          )
      );
    }, listener: (state,context){});
  }
}
