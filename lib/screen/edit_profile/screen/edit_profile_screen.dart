
import 'package:task_management_kts/app_utility/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_utility/app_constant.dart';
import '../../../app_utility/color_resource.dart';
import '../../../app_utility/constant.dart';
import '../../../app_utility/fonts.dart';
import '../../../app_utility/singleton.dart';
import '../../../router/router_names.dart';
import '../../../widgets/custom_text.dart';
import '../bloc/edit_profile_bloc.dart';
import '../bloc/edit_profile_state.dart';
import 'edit_profile_widget.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    AppUtils.getDeviceType();
    data();
    super.initState();
  }
void data()async{
    context.read<EditProfileBloc>().add(const GetProfileInformationEvent());
}
  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return BlocConsumer<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            scrolledUnderElevation:0.0,
            backgroundColor: ColorResource.colorF6F6F6,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: ColorResource.color5A5C60,
              ),
              iconSize: 30,
              onPressed: () {
                context.pop();
              },
            ),
            title: CustomText(
              "Edit Profile",
              style: GoogleFonts.readexPro(
                color: ColorResource.color232323,
                fontSize: AppUtils.getDeviceType() == "tablet"
                    ? FontSize1.twentyEight
                    : FontSize1.twentyFour,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Container(
            color: ColorResource.colorF6F6F6,

            child: Stack(
              clipBehavior: Clip.none,
              children: [
               if(state is EditProfileLoaded)
                Container(
                  height:double.infinity,
                  constraints: const BoxConstraints.expand(),
                  child: Form(
                    key: context.read<EditProfileBloc>().formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, right: 14.0),
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
                          isPortrait==true?  SizedBox(height:AppUtils.getDeviceType()=="tablet" ?60.0:50): SizedBox(height:AppUtils.getDeviceType()=="tablet" ?10:10),
                          profileImage(context),
                          isPortrait==true?  SizedBox(height:AppUtils.getDeviceType()=="tablet"?100.0:80):SizedBox(height:AppUtils.getDeviceType()=="tablet"?40.0:40.0),
                          Padding(
               padding: const EdgeInsets.only(left: 52.0,right: 52.0),
               child: Row(


                 children: [

                   Padding(
                     padding: const EdgeInsets.only(right: 50),
                     child: CustomText(
                     "Name",
                     style: GoogleFonts.inter(
                         color: ColorResource.color232323,
                         fontSize:AppUtils.getDeviceType()=="tablet"? FontSize1.twenty:FontSize1.seventeen,
                         fontWeight: FontWeight.w500,
                     ),
                     ),
                   ),

                   CustomText(
                   "${context.read<EditProfileBloc>().profileInformation?.data?.name.toString()}",
                   style: GoogleFonts.inter(
                       color: ColorResource.color707070,
                       fontSize:AppUtils.getDeviceType()=="tablet"? FontSize1.twenty:FontSize1.seventeen,
                       fontWeight: FontWeight.w500,
                   ),
                   ),


                 ],
               ),
             ),
                          const SizedBox(height:67.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 52.0,right: 52.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 45),
                                  child: CustomText(
                                    "Email",
                                    style: GoogleFonts.inter(
                                      color: ColorResource.color232323,
                                      fontSize:AppUtils.getDeviceType()=="tablet"? FontSize1.twenty:FontSize1.seventeen,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width:AppUtils.getDeviceType()=="tablet" &&  isPortrait==true?MediaQuery.sizeOf(context).width/1.38:AppUtils.getDeviceType()=="phone" &&  isPortrait==true?MediaQuery.sizeOf(context).width/2.15:MediaQuery.sizeOf(context).width/1.4,
                                  child: TextFormField(
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize:AppUtils.getDeviceType()=="tablet"? FontSize1.twenty:FontSize1.seventeen,
                                      color: ColorResource.color232323,
                                    ),
                                    controller: context.read<EditProfileBloc>().emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    maxLines: 1, // when user presses enter it will adapt to it
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      isDense: true,
                                      contentPadding: const EdgeInsets.symmetric(horizontal:10, vertical: 10.0),
                                      hintStyle: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppUtils.getDeviceType()=="tablet"? FontSize1.twenty:FontSize1.seventeen,
                                        color: ColorResource.color232323,
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 3.0,
                                          color: ColorResource.color707070,
                                        ),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 3.0,
                                          color: ColorResource.color707070,
                                        ),
                                      ),
                                      errorBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 3.0,
                                          color: ColorResource.colorE65454,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: ColorResource.colorF6F6F6,
                                      errorStyle: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontSize:AppUtils.getDeviceType()=="tablet"? FontSize1.twenty:FontSize1.seventeen,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),


                              ],
                            ),
                          ),
                          const SizedBox(height:67.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 52.0,right: 52.0),
                            child: Row(

                              children: [

                                Padding(
                                  padding: const EdgeInsets.only(right: 40),
                                  child: CustomText(
                                    "Phone",
                                    style: GoogleFonts.inter(
                                      color: ColorResource.color232323,
                                      fontSize:AppUtils.getDeviceType()=="tablet"? FontSize1.twenty:FontSize1.seventeen,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),

                                SizedBox(

                                 width:AppUtils.getDeviceType()=="tablet" &&  isPortrait==true?MediaQuery.sizeOf(context).width/1.38:AppUtils.getDeviceType()=="phone" &&  isPortrait==true?MediaQuery.sizeOf(context).width/2.15:MediaQuery.sizeOf(context).width/1.4,
                                  child: TextFormField(
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize:AppUtils.getDeviceType()=="tablet"? FontSize1.twenty:FontSize1.seventeen,
                                      color: ColorResource.color232323,
                                    ),
                                    controller: context.read<EditProfileBloc>().phoneController,
                                    keyboardType: TextInputType.number,
                                    maxLines: 1, // when user presses enter it will adapt to it
                                    decoration: InputDecoration(
                                      hintText: "Phone",
                                      isDense: true,
                                      contentPadding: const EdgeInsets.symmetric(horizontal:10, vertical: 10.0),
                                      hintStyle: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppUtils.getDeviceType()=="tablet"? FontSize1.twenty:FontSize1.seventeen,
                                        color: ColorResource.color232323,
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 3.0,
                                          color: ColorResource.color707070,
                                        ),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 3.0,
                                          color: ColorResource.color707070,
                                        ),
                                      ),
                                      errorBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 3.0,
                                          color: ColorResource.colorE65454,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: ColorResource.colorF6F6F6,
                                      errorStyle: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontSize: AppUtils.getDeviceType()=="tablet"? FontSize1.twenty:FontSize1.seventeen,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),


                              ],
                            ),
                          ),
                          SizedBox(height: AppUtils.getDeviceType()=="tablet"?MediaQuery.sizeOf(context).height/4:MediaQuery.sizeOf(context).height/10),
                          AppUtils.getDeviceType()=="tablet"?   Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                                child: GestureDetector(
                                  onTap: (){
                                    context.pop();
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 2.5,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      border: Border.all(
                                        width: 1.0,
                                        color:ColorResource.colorE0E3E7,
                                      ),
                                      color: ColorResource.colorWhite,
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Cancel",
                                          style: GoogleFonts.inter(
                                            color: ColorResource.color5A5C60,
                                            fontSize:FontSize1.fifteen,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                                child: GestureDetector(
                                  onTap: (){
                                    FocusScope.of(context).unfocus();


                                    if (context
                                        .read<EditProfileBloc>()
                                        .formKey
                                        .currentState!
                                        .validate()) {

                                      context.read<EditProfileBloc>().add(const ProfileUpdateEvent());
                                    }},
                                  child: Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width / 2.5,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      border: Border.all(
                                        width: 1.0,
                                        color: ColorResource.color003867,
                                      ),
                                      color: ColorResource.color003867,
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          StringResource.submit,
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize:FontSize1.fifteen,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ): Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: GestureDetector(
                                  onTap: (){
                                    if (context
                                        .read<EditProfileBloc>()
                                        .formKey
                                        .currentState!
                                        .validate()) {

                                      context.read<EditProfileBloc>().add(const ProfileUpdateEvent());
                                    }},

                                  child: Container(
                                    height: 34,
                                    width: MediaQuery.of(context).size.width /1.5,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      border: Border.all(
                                        width: 1.0,
                                        color: ColorResource.color003867,
                                      ),
                                      color: ColorResource.color003867,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4.0,right: 4.0),
                                      child: Center(
                                        child: Text(
                                          StringResource.submit,
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize:FontSize1.thirteen,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: GestureDetector(
                                  onTap: (){
                                    context.pop();
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width /1.5,
                                    height: 34,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      border: Border.all(
                                        width: 1.0,
                                        color:ColorResource.colorE0E3E7,
                                      ),
                                      color: ColorResource.colorWhite,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4.0,right: 4.0),
                                      child: Center(
                                        child: Text(
                                          "Cancel",
                                          style: GoogleFonts.inter(
                                            color: ColorResource.color5A5C60,
                                            fontSize:FontSize1.twelve,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),


                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state is EditProfileLoading)
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 1,
                      child: AppUtils().buildLoading()),
              ],
            ),
          ),
        );
      },

      listener: (context, state) {
        if (state is EditProfileUpdate) {
         context.pop();

        }
        if (state is EditProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 4),
              backgroundColor: Colors.red,
              content: Center(child: Text(state.message.toString())),
            ),
          );
          data();
        }
        if(state is EditProfileException){
          AppUtils.showInternetDialog(context,onPressed: () {
            data();
            context.pop();
          });
        }
        if(state is EditAuthorization){
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
      },
    );
  }

}
