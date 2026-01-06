import 'dart:async';
import 'package:task_management_kts/app_utility/app_util.dart';
import 'package:task_management_kts/app_utility/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app_utility/app_constant.dart';
import '../../app_utility/color_resource.dart';
import '../../app_utility/image_resource.dart';
import '../../router/router_names.dart';
import '../../widgets/custom_text.dart';


class RegisterSuccessScreen extends StatefulWidget {
  const RegisterSuccessScreen({super.key});

  @override
  State<RegisterSuccessScreen> createState() => _RegisterSuccessScreenState();
}

class _RegisterSuccessScreenState extends State<RegisterSuccessScreen> {
  String? greetings;

  @override
  void initState() {
    AppUtils.getDeviceType();
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    Timer(const Duration(seconds:3), () {
        context.goNamed(RouterNames.loginRouter);
      });

  }


  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: isPortrait==true?Container(
        height: double.infinity,
        width:double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageResource.signBg), // Replace with your asset image path
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.only(left: 52.0,right: 52.0),
              child: Container(
                height:MediaQuery.of(context).size.height/3,
                width:MediaQuery.of(context).size.width/1,
                decoration: const BoxDecoration(
                    color: ColorResource.colorWhite,
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height:AppUtils.getDeviceType()=="tablet"? 90.0:78.0,
                      width: AppUtils.getDeviceType()=="tablet"? 90.0:78.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorResource.color003867
                      ),
                      child:  Icon(Icons.check,size:AppUtils.getDeviceType()=="tablet"?65:50,color: ColorResource.colorWhite,),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    CustomText(
                      StringResource.registerSuccess,
                      style: GoogleFonts.readexPro(
                          color: ColorResource.color232323,
                          fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.twenty:FontSize1.seventeen,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    CustomText(
                      "You will soon receive your log-in details",
                      style: GoogleFonts.inter(
                          color: ColorResource.color232323,
                          fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.twelve,
                          fontWeight: FontWeight.w500),
                    ),
                    CustomText(
                      "through email. Thank you.",
                      style: GoogleFonts.inter(
                          color: ColorResource.color232323,
                          fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.twelve,
                          fontWeight: FontWeight.w500),
                    ),

                  ],
                ),
              ),
            ),

          ],
        ),
      ):Container(
        height: double.infinity,
        width:double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageResource.signBg), // Replace with your asset image path
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.only(left:200.0,right:200.0),
              child: Container(
                height:MediaQuery.of(context).size.height/2,
                width:MediaQuery.of(context).size.width/1,
                decoration: const BoxDecoration(
                    color: ColorResource.colorWhite,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorResource.color003867
                      ),
                      child: const Icon(Icons.check,size:65,color: ColorResource.colorWhite,),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    CustomText(
                      StringResource.registerSuccess,
                      style: GoogleFonts.readexPro(
                          color: ColorResource.color232323,
                          fontSize:FontSize1.twenty,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    CustomText(
                      "You will soon receive your log-in details",
                      style: GoogleFonts.inter(
                          color: ColorResource.color232323,
                          fontSize:FontSize1.fifteen,
                          fontWeight: FontWeight.w500),
                    ),
                    CustomText(
                      "through email. Thank you.",
                      style: GoogleFonts.inter(
                          color: ColorResource.color232323,
                          fontSize:FontSize1.fifteen,
                          fontWeight: FontWeight.w500),
                    ),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
