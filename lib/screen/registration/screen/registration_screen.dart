import 'dart:ui';

import 'package:task_management_kts/router/router_names.dart';
import 'package:task_management_kts/screen/registration/screen/registeration_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../app_utility/app_util.dart';
import '../../../app_utility/color_resource.dart';
import '../../../app_utility/singleton.dart';
import '../../../widgets/custom_text.dart';
import '../bloc/registration_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  void initState() {
    data();
    getDeviceType();
    super.initState();
  }

  data() async {}
  String getDeviceType() {
    final data = MediaQueryData.fromView(PlatformDispatcher.instance.views.first);
    return data.size.shortestSide < 550 ? 'phone' :'tablet';
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return BlocConsumer<RegistrationBloc,RegistrationState>(builder: (context,state){
      return Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  if( isPortrait==true && getDeviceType()=="phone" )
                    Expanded(child:mobilePortrait(context)),
                  if( isPortrait==false && getDeviceType()=="phone")
                    Expanded(child: SingleChildScrollView(child: mobileLandscape(context))),
                  if(isPortrait==true &&getDeviceType()=="tablet")
                    Expanded(child: tabletPortrait(context)),
                  if( isPortrait==false && getDeviceType()=="tablet")
                    Expanded(child: tabletLandscape(context)),

                ],
              ),
              if (state is RegistrationLoading)
                SizedBox(
                    height: MediaQuery.of(context).size.height / 1,
                    child: AppUtils().buildLoading()),
            ],
          )
      );
    }, listener:(context,state){
      if(state is RegistrationException){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 1),
            backgroundColor:
            Singleton().isConnection == false ? Colors.grey : Colors.red,
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

      if(state is RegistrationError){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.red,
            content: Text(state.message!),
          ),
        );
      }

      if(state is RegistrationLoaded){
       // context.pushNamed(RouterNames.loginRouter);
        context.pushReplacementNamed(RouterNames.registerSuccessScreenRouter);
        context.read<RegistrationBloc>().fullNameController.clear();
        context.read<RegistrationBloc>().emailController.clear();
        context.read<RegistrationBloc>().mobileController.clear();
        //AppUtils.showToast(context.read<RegistrationBloc>().registrationModel!.message.toString());
      }
    });
  }


}


