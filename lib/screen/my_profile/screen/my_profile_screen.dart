import 'package:task_management_kts/app_utility/singleton.dart';
import 'package:task_management_kts/screen/my_profile/bloc/my_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_utility/app_constant.dart';
import '../../../app_utility/color_resource.dart';
import '../../../app_utility/constant.dart';
import '../../../app_utility/app_util.dart';
import '../../../app_utility/fonts.dart';
import '../../../router/router_names.dart';
import '../../../widgets/custom_text.dart';
import 'my_prrofile_widget.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  void initState() {
  AppUtils.getDeviceType();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyProfileBloc,MyProfileState>(builder: (context,state){
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: AppBar(
                toolbarHeight: 80,
                scrolledUnderElevation:0.0,
                leadingWidth: MediaQuery.of(context).size.width,
                backgroundColor: ColorResource.colorF6F6F6,
                leading:Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: ColorResource.color5A5C60,
                        ),
                        iconSize:30,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0,bottom: 4.0),
                        child: CustomText(
                          StringResource.myProfile,
                          style: GoogleFonts.readexPro(
                              color: ColorResource.color232323,
                              fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.twentyEight:FontSize1.twentyFour,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              /*  actions: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 35,
                      ),
                      onPressed: () {
                        // Add your logic for handling the person icon press
                      },
                    ),
                  ),
                ],*/
              ),
            ),
            body: Container(
              color: ColorResource.colorF6F6F6,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height:double.infinity,
                    constraints: const BoxConstraints.expand(),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (state is MyProfileLoading)
                            SizedBox(
                                height: MediaQuery.of(context).size.height / 1,
                                child: AppUtils().buildLoading()),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0, right: 14.0,top: 10),
                                child: Row(
                                  children: [
                                    CustomText(
                                      "${Singleton().userFirstName} ${Singleton().userLastName}",
                                      style: GoogleFonts.inter(
                                        color: ColorResource.color003867,
                                        fontSize:AppUtils.getDeviceType()=="tablet"? FontSize1.thirteen:FontSize1.eleven,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    CustomText(
                                      Singleton().emailID,
                                      style: GoogleFonts.inter(
                                        color: ColorResource.color232323,
                                        fontSize:AppUtils.getDeviceType()=="tablet"? FontSize1.thirteen:FontSize1.eleven,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10.0,),
                              Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(width: 1.0, color: ColorResource.color707070),
                                      bottom: BorderSide(width: 1.0, color:ColorResource.color707070),
                                    ),
                                    color: ColorResource.colorWhite
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 18.0, top: 12.0, bottom: 12.0),
                                  child: CustomText(
                                    StringResource.myAccountInformation,
                                    style: GoogleFonts.inter(
                                      color: ColorResource.color5A5C60,
                                      fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen: FontSize1.thirteen,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  context.pushNamed(RouterNames.changePasswordScreenRouter);
                                },
                                child: Container(
                                  height: 75,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(width: 1.0, color:ColorResource.color707070),

                                      ),
                                      color: ColorResource.colorWhite
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 22.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          StringResource.changePassword,
                                          style: GoogleFonts.inter(
                                            color: ColorResource.color12151C,
                                            fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen: FontSize1.thirteen,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Icon(Icons.keyboard_arrow_right, color: ColorResource.color5A5C60, size: 35,)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  context.pushNamed(RouterNames.editProfileScreenRouter);
                                },
                                child: Container(
                                  height: 75,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(width: 1.0, color:ColorResource.color707070),
                                      ),
                                      color: ColorResource.colorWhite
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 22.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          StringResource.editProfile,
                                          style: GoogleFonts.inter(
                                            color: ColorResource.color12151C,
                                            fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen: FontSize1.thirteen,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Icon(Icons.keyboard_arrow_right, color: ColorResource.color5A5C60, size: 35,)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  deleteAlertSheet(context: context);
                                  /*AppUtils. showCustomDialog(context,onPressed: ()async{
                                    if(context.mounted){
                                      context.read<MyProfileBloc>().add(const DeleteAccountEvent());
                                      context.pop();

                                    }
                                  },data: "Are you sure you want to delete account?",title: "Delete Account");*/
                                },
                                child: Container(
                                  height: 75,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(width: 1.0, color:ColorResource.color707070),
                                      ),
                                      color: ColorResource.colorWhite
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 22.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          StringResource.deleteAccount,
                                          style: GoogleFonts.inter(
                                            color: ColorResource.color12151C,
                                            fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen: FontSize1.thirteen,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Icon(Icons.keyboard_arrow_right, color: ColorResource.color5A5C60, size: 35,)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40,),
                              Center(
                                child: GestureDetector(
                                  onTap: (){
                                    logoutAlertSheet(context: context);
                                  //  context.pop();

                                  },
                                  child: Container(
                                    height:AppUtils.getDeviceType()=="tablet"? 45:39,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2.0, color: ColorResource.colorE0E3E7),
                                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                      color: ColorResource.colorWhite,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 6.0,right: 6.0),
                                      child: Center(
                                        child: CustomText(
                                          StringResource.logOut,
                                          style: GoogleFonts.inter(
                                            color: ColorResource.color5A5C60,
                                            fontSize:AppUtils.getDeviceType()=="tablet"? FontSize1.fifteen:FontSize1.twelve,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              color: ColorResource.colorF6F6F6,
              height: 30,
              child: Center(
                child: CustomText(
                  StringResource.version,
                  style: GoogleFonts.inter(
                    color: ColorResource.color5A5C60,
                    fontSize:AppUtils.getDeviceType()=="tablet"? FontSize1.fifteen:FontSize1.twelve,
                    fontWeight: FontWeight.w400,
                  ),
                ),),),
          ),
        ),
      );
    }, listener: (context,state){
      if(state is MyProfileLoaded){

        SharedPreferences.getInstance().then((value) {
          value.setBool(SharedPrefKeys.isLogin, false).then((value) {
           if(context.mounted){
             context.pushReplacementNamed(RouterNames.loginRouter);
           }
          });
        });
      }
    if(state is MyProfileError){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
          content: Text(state.message!),
        ),
      );
      SharedPreferences.getInstance().then((value) {
        value.setBool(SharedPrefKeys.isLogin, false).then((value) {
        if(context.mounted){
          context.pushReplacementNamed(RouterNames.loginRouter);
        }

        });
      });
    }
    if(state is MyProfileAuthorization){
      AppUtils.showAuthDialog(context,onPressed: () {
        SharedPreferences.getInstance().then((value) {
          value.setBool(SharedPrefKeys.isLogin, false).then((value) {
           if(context.mounted){
             context.pushReplacementNamed(RouterNames.loginRouter);
           }
          });
        });
        context.pop();
      });
    }
    });
  }
}
