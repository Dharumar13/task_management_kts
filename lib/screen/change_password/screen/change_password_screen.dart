import 'package:task_management_kts/app_utility/app_util.dart';
import 'package:task_management_kts/screen/change_password/bloc/change_password_bloc.dart';
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

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  void initState() {
    AppUtils.getDeviceType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              scrolledUnderElevation: 0.0,
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
                StringResource.changePassword,
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
              height:double.infinity,
              constraints: const BoxConstraints.expand(),
              width: double.infinity,
              child: SingleChildScrollView(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    if (state is ChangePasswordLoading)
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 1,
                        child: AppUtils().buildLoading(),
                      ),
                    Form(
                      key: context.read<ChangePasswordBloc>().formKey,
                      child: Column(
                 mainAxisAlignment: MainAxisAlignment.end,

                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18.0, right: 14.0, top: 10),
                            child: Row(
                              children: [
                                CustomText(
                                  "${Singleton().userFirstName} ${Singleton().userLastName}",
                                  style: GoogleFonts.inter(
                                    color: ColorResource.color003867,
                                    fontSize:
                                        AppUtils.getDeviceType() == "tablet"
                                            ? FontSize1.thirteen
                                            : FontSize1.eleven,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                CustomText(
                                  Singleton().emailID,
                                  style: GoogleFonts.inter(
                                    color: ColorResource.color232323,
                                    fontSize:
                                        AppUtils.getDeviceType() == "tablet"
                                            ? FontSize1.thirteen
                                            : FontSize1.eleven,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 99.0),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 34.0, right: 34.0),
                            child: TextFormField(
                              validator: (String? values) {
                                if (values!.isEmpty) {
                                  return "Please old password";
                                }
                                return null;
                              },
                              obscureText: true,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: AppUtils.getDeviceType() == "tablet"
                                    ? FontSize1.fifteen
                                    : FontSize1.twelve,
                                color: ColorResource.color232323,
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.text,
                              controller: context
                                  .read<ChangePasswordBloc>()
                                  .oldPasswordController,
                              maxLines: 1,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 15.0,
                                ),
                                hintText: "Old Password",
                                hintStyle: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppUtils.getDeviceType() == "tablet"
                                      ? FontSize1.fifteen
                                      : FontSize1.twelve,
                                  color: ColorResource.color232323,
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: ColorResource.colorE0E3E7,
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: ColorResource.colorE0E3E7,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: ColorResource.colorE0E3E7,
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: Colors.red,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                errorStyle: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppUtils.getDeviceType() == "tablet"
                                      ? FontSize1.fifteen
                                      : FontSize1.twelve,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 27.0),

                          Padding(
                            padding:
                                const EdgeInsets.only(left: 34.0, right: 34.0),
                            child: TextFormField(
                              validator: (String? values) {
                                if (values!.isEmpty) {
                                  return "Please new password";
                                }
                                return null;
                              },
                              obscureText:
                                  context.read<ChangePasswordBloc>().isVisible!,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.text,
                              controller: context
                                  .read<ChangePasswordBloc>()
                                  .newPasswordControllerController,
                              maxLines: 1,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: AppUtils.getDeviceType() == "tablet"
                                    ? FontSize1.fifteen
                                    : FontSize1.twelve,
                                color: ColorResource.color232323,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 15.0,
                                ),
                                hintText: "New Password",
                                hintStyle: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppUtils.getDeviceType() == "tablet"
                                      ? FontSize1.fifteen
                                      : FontSize1.twelve,
                                  color: ColorResource.color232323,
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: ColorResource.colorE0E3E7,
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: ColorResource.colorE0E3E7,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: ColorResource.colorE0E3E7,
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: Colors.red,
                                  ),
                                ),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      if (context
                                              .read<ChangePasswordBloc>()
                                              .isVisible ==
                                          true) {
                                        context
                                            .read<ChangePasswordBloc>()
                                            .add(VisiblePostEvent(false));
                                      } else {
                                        context
                                            .read<ChangePasswordBloc>()
                                            .add(VisiblePostEvent(true));
                                      }
                                    },
                                    child: Icon(
                                      context
                                                  .read<ChangePasswordBloc>()
                                                  .isVisible ==
                                              true
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: ColorResource.colorADAFB3,
                                      size: 30,
                                    )),
                                filled: true,
                                fillColor: Colors.white,
                                errorStyle: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppUtils.getDeviceType() == "tablet"
                                      ? FontSize1.fifteen
                                      : FontSize1.twelve,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 27.0),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 34.0, right: 34.0),
                            child: TextFormField(
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please reconfirm the password';
                                }
                                if (val !=
                                    context
                                        .read<ChangePasswordBloc>()
                                        .newPasswordControllerController
                                        .text) {
                                  return 'Password not match';
                                }
                                return null;
                              },
                              obscureText: context
                                  .read<ChangePasswordBloc>()
                                  .isVisible2!,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: context
                                  .read<ChangePasswordBloc>()
                                  .confirmPasswordControllerController,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: AppUtils.getDeviceType() == "tablet"
                                    ? FontSize1.fifteen
                                    : FontSize1.twelve,
                                color: ColorResource.color232323,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 15.0,
                                ),
                                hintText: "Confirm new Password",
                                hintStyle: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppUtils.getDeviceType() == "tablet"
                                      ? FontSize1.fifteen
                                      : FontSize1.twelve,
                                  color: ColorResource.color232323,
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: ColorResource.colorE0E3E7,
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: ColorResource.colorE0E3E7,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: ColorResource.colorE0E3E7,
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: Colors.red,
                                  ),
                                ),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      if (context
                                              .read<ChangePasswordBloc>()
                                              .isVisible2 ==
                                          true) {
                                        context.read<ChangePasswordBloc>().add(
                                            VisibleConfirmPostEvent(false));
                                      } else {
                                        context
                                            .read<ChangePasswordBloc>()
                                            .add(VisibleConfirmPostEvent(true));
                                      }
                                    },
                                    child: Icon(
                                      context
                                                  .read<ChangePasswordBloc>()
                                                  .isVisible2 ==
                                              true
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: ColorResource.colorADAFB3,
                                      size: 30,
                                    )),
                                filled: true,
                                fillColor: Colors.white,
                                errorStyle: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppUtils.getDeviceType() == "tablet"
                                      ? FontSize1.fifteen
                                      : FontSize1.twelve,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: AppUtils.getDeviceType()=="tablet"?MediaQuery.sizeOf(context).height/4:MediaQuery.sizeOf(context).height/4),
                          AppUtils.getDeviceType() == "tablet"
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          context.pop();
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            border: Border.all(
                                              width: 1.0,
                                              color: ColorResource.colorE0E3E7,
                                            ),
                                            color: ColorResource.colorWhite,
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Cancel",
                                                style: GoogleFonts.inter(
                                                  color:
                                                      ColorResource.color5A5C60,
                                                  fontSize: FontSize1.fifteen,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();

                                          if (context
                                              .read<ChangePasswordBloc>()
                                              .formKey
                                              .currentState!
                                              .validate()) {
                                            context.read<ChangePasswordBloc>().add(
                                                const ChangePasswordPostEvent());
                                          }
                                        },
                                        child: Container(
                                          height: 40,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Reset",
                                                style: GoogleFonts.inter(
                                                  color: Colors.white,
                                                  fontSize: FontSize1.fifteen,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (context
                                              .read<ChangePasswordBloc>()
                                              .formKey
                                              .currentState!
                                              .validate()) {
                                            context.read<ChangePasswordBloc>().add(
                                                const ChangePasswordPostEvent());
                                          }
                                        },
                                        child: Container(
                                          height: 34,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width /
                                              1.5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            border: Border.all(
                                              width: 1.0,
                                              color: ColorResource.color003867,
                                            ),
                                            color: ColorResource.color003867,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0, right: 4.0),
                                            child: Center(
                                              child: Text(
                                                "Reset",
                                                style: GoogleFonts.inter(
                                                  color: Colors.white,
                                                  fontSize: FontSize1.thirteen,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          context.pop();
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.5,
                                          height: 34,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            border: Border.all(
                                              width: 1.0,
                                              color: ColorResource.colorE0E3E7,
                                            ),
                                            color: ColorResource.colorWhite,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0, right: 4.0),
                                            child: Center(
                                              child: Text(
                                                "Cancel",
                                                style: GoogleFonts.inter(
                                                  color:
                                                      ColorResource.color5A5C60,
                                                  fontSize: FontSize1.thirteen,
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
                  ],
                ),
              ),
            ));
      },
      listener: (context, state) {
        if (state is ChangePasswordLoaded) {
          AppUtils.showToast(state.message.toString());
          context.pop();
        }
        if (state is ChangePasswordError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 4),
              backgroundColor: Colors.red,
              content: Center(child: Text(state.message.toString())),
            ),
          );

        }
        if (state is ChangePasswordException) {
          AppUtils.showInternetDialog(context, onPressed: () {
            context.pop();
          });
        }
        if (state is ChangeAuthorization) {
          AppUtils.showAuthDialog(context, onPressed: () {
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
