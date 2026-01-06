import 'package:task_management_kts/app_utility/app_util.dart';
import 'package:task_management_kts/screen/my_profile/bloc/my_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app_utility/app_constant.dart';
import '../../../app_utility/color_resource.dart';
import '../../../app_utility/fonts.dart';
import '../../../widgets/custom_text.dart';

void logoutAlertSheet({
  required BuildContext context,
}) {
  final layoutBloc = context.read<MyProfileBloc>();
  showModalBottomSheet(
    enableDrag: true,
    isDismissible: true,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: ColorResource.colorWhite,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0),topRight:  Radius.circular(50.0)),
        side: BorderSide(width: 1.0,color: ColorResource.color003867)
    ),
    context: context,
    builder: (BuildContext context) {
      return  BlocProvider.value(
          value: layoutBloc, child: const LogOutAlertsSheet());
    },
  );
}

class LogOutAlertsSheet extends StatelessWidget {

  const LogOutAlertsSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    AppUtils.getDeviceType();
    return BlocConsumer<MyProfileBloc, MyProfileState>(builder: (context, state){
      return Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: AppUtils.getDeviceType()=="tablet"?50.0:50
                ),
                Center(
                  child: CustomText(
                    "Are you sure to logout?",
                    style: GoogleFonts.inter( color: ColorResource.color1C1F26,
                      fontWeight: FontWeight.w500,
                      fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.twenty:FontSize1.twelve,),
                  ),
                ),
                SizedBox(
                  height:AppUtils.getDeviceType()=="tablet"?50.0:30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                      child: MaterialButton(onPressed: (){
                        context.pop();
                      },
                        minWidth: isPortrait==true?MediaQuery.of(context).size.width/3:MediaQuery.of(context).size.width/6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height:AppUtils.getDeviceType()=="tablet"? 40:34,
                        color: ColorResource.color003867,
                        child:  CustomText(
                          StringResource.cancel,
                          style: GoogleFonts.inter(   color: ColorResource.colorWhite,
                            fontWeight: FontWeight.w400,
                            fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                      child: MaterialButton(onPressed: (){
                        context.read<MyProfileBloc>().add(const LogOutEvent());

                      },
                        minWidth: isPortrait==true?MediaQuery.of(context).size.width/3:MediaQuery.of(context).size.width/6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height:AppUtils.getDeviceType()=="tablet"? 40:34,
                        color: ColorResource.colorWhite,
                        child:  CustomText(
                          StringResource.confirm,
                          style: GoogleFonts.inter(   color: ColorResource.color5A5C60,
                            fontWeight: FontWeight.w400,
                            fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height:AppUtils.getDeviceType()=="tablet"?50.0:30,
                ),

              ],
            ),
          ),
        ],
      );
    }, listener: (context, state){

    });
  }
}

void deleteAlertSheet({

  required BuildContext context,
}) {
  final layoutBloc = context.read<MyProfileBloc>();
  showModalBottomSheet(
    enableDrag: true,
    isDismissible: true,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: ColorResource.colorWhite,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0),topRight:  Radius.circular(50.0)),
        side: BorderSide(width: 1.0,color: ColorResource.color003867)
    ),
    context: context,

    builder: (BuildContext context) {
      return  BlocProvider.value(
          value: layoutBloc, child: const DeleteAlertsSheet());
    },
  );
}

class DeleteAlertsSheet extends StatelessWidget {

  const DeleteAlertsSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return BlocConsumer<MyProfileBloc, MyProfileState>(builder: (context, state){
      return Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: AppUtils.getDeviceType()=="tablet"?50.0:50
                ),
                Center(
                  child: CustomText(
                    "Are you sure you want to delete account?",
                    style: GoogleFonts.inter( color: ColorResource.color1C1F26,
                      fontWeight: FontWeight.w500,
                      fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.twenty:FontSize1.twelve,),
                  ),
                ),
                SizedBox(
                  height:AppUtils.getDeviceType()=="tablet"?50.0:30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                      child: MaterialButton(onPressed: (){
                        //context.read<AllLayoutsBloc>().add(SaveCommentLayout());
                        context.pop();
                      },
                        minWidth: isPortrait==true?MediaQuery.of(context).size.width/3:MediaQuery.of(context).size.width/6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height:AppUtils.getDeviceType()=="tablet"? 40:34,
                        color: ColorResource.color003867,
                        child:  CustomText(
                          StringResource.cancel,
                          style: GoogleFonts.inter(   color: ColorResource.colorWhite,
                            fontWeight: FontWeight.w400,
                            fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                      child: MaterialButton(onPressed: (){
                        context.read<MyProfileBloc>().add(const DeleteAccountEvent());
                        context.pop();
                      },
                        minWidth: isPortrait==true?MediaQuery.of(context).size.width/3:MediaQuery.of(context).size.width/6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height:AppUtils.getDeviceType()=="tablet"? 40:34,
                        color: ColorResource.colorWhite,
                        child:  CustomText(
                          StringResource.confirm,
                          style: GoogleFonts.inter(   color: ColorResource.color5A5C60,
                            fontWeight: FontWeight.w400,
                            fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height:AppUtils.getDeviceType()=="tablet"?50.0:30,
                ),

              ],
            ),
          ),
        ],
      );
    }, listener: (context, state){});
  }
}