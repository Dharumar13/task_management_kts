import 'dart:async';
import 'dart:ui';
import 'package:task_management_kts/app_utility/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_utility/color_resource.dart';
import '../../../app_utility/constant.dart';
import '../../../app_utility/app_util.dart';
import '../../../app_utility/preference_helper.dart';
import '../../../router/router_names.dart';
import '../../../widgets/custom_text.dart';
import '../bloc/login_bloc.dart';
import 'login_widget_mobile_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Timer timer = Timer(const Duration(milliseconds: 1), () {});
@override
  void initState() {
  getDeviceType();

  context.read<LoginBloc>().getDeviceDetails();
  data();
    // TODO: implement initState
    super.initState();
  }
  String getDeviceType() {
    final data = MediaQueryData.fromView(PlatformDispatcher.instance.views.first);
    return data.size.shortestSide < 550 ? 'phone' :'tablet';
  }

  data() async {
    var loginBloc = context.read<LoginBloc>();
    loginBloc.emailController.text =
    await PreferenceHelper.getLoginId();
    loginBloc.passwordController.text = await PreferenceHelper.getPassword();
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return BlocConsumer<LoginBloc, LoginState>(
      builder: (context, state) {
        return PopScope(
          canPop: context.read<LoginBloc>().popCan,
          onPopInvokedWithResult: (bool didPop, Object? result) async {
            if (!didPop) {
              AppUtils.showToast("Press back again to exit");
              context.read<LoginBloc>().add(PopScopeEventLogin(true));
            }
          },
          child: Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    if( isPortrait==true && getDeviceType()=="phone" )
                   Expanded(child: mobilePortraitView(context)),
                 if( isPortrait==false && getDeviceType()=="phone")
                   Expanded(child: SingleChildScrollView(child: mobileLandscapeView(context))),
                 if(isPortrait==true &&getDeviceType()=="tablet")
                   Expanded(child: tabletPortraitView(context)),
                 if( isPortrait==false && getDeviceType()=="tablet")
                   Expanded(child: tabletLandscapeView(context))

                  ],
                ),
                if (state is LoginLoading)
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 1,
                      child: AppUtils().buildLoading()),
              ],
            )
          ),
        );
      }, listener: (BuildContext context, state) {
      if (state is LoginError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red,
            content: Center(child: Text(state.message!)),
          ),
        );
      }
      if (state is LoginRequestLoaded) {
        SharedPreferences.getInstance().then((value) {
          value.setBool(SharedPrefKeys.isLogin, true).then((value) {
           if(context.mounted){
             context.pushReplacementNamed(RouterNames.jobBoardRouter);
           }
          });
        });
      }
      if(state is LoginException){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds:3),
            backgroundColor:
            Singleton().isConnection == false ? Colors.red : Colors.red,
            content: Singleton().isConnection == false
                ? const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               CustomText ("No internet connection"),
                Icon(
                  Icons.network_check,
                  color: ColorResource.colorWhite,
                )
              ],
            )
                :  const Center(child: CustomText("Something went to wrong"))));
      }
    },
    );
  }


}
