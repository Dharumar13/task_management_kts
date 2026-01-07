import 'package:task_management_kts/screen/forgot_passowrd/bloc/forgot_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app_utility/app_constant.dart';
import '../../../app_utility/app_util.dart';
import '../../../app_utility/color_resource.dart';
import '../../../app_utility/custom_text_form_field.dart';
import '../../../app_utility/fonts.dart';
import '../../../app_utility/image_resource.dart';
import '../../../app_utility/singleton.dart';
import '../../../router/router_names.dart';
import '../../../widgets/custom_text.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {


  @override
  void initState() {
    AppUtils.getDeviceType();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery
        .of(context)
        .orientation == Orientation.portrait;
    return BlocConsumer<ForgotBloc, ForgotState>(builder: (context, state) {
      return Scaffold(
          body: isPortrait == true ? SingleChildScrollView(
            child: Container(
              height: MediaQuery
                  .sizeOf(context)
                  .height,
              color: ColorResource.colorWhite,
              child: Stack(
                children: [
                  // Background Image
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 2.0,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImageResource.signBg),
                        // Replace with your asset image path
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(child: Padding(
                    padding: EdgeInsets.only(left: AppUtils.getDeviceType() ==
                        "tablet" ? 34.0 : 14.0, right: AppUtils
                        .getDeviceType() == "tablet" ? 34.0 : 14.0),
                    child: Form(
                      key: context
                          .read<ForgotBloc>()
                          .formKey,
                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Column(
                            children: [
                              Container(
                                height:AppUtils
                                    .getDeviceType() == "tablet" ?225:139,
                                width: AppUtils
                                    .getDeviceType() == "tablet" ?276:172,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                                    color: ColorResource.colorWhite.withValues(alpha: 0.4)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(ImageResource.pactSplashScreen,alignment: Alignment.center,fit: BoxFit.contain),
                                ),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              CustomText(
                                "Forgot Password",
                                style: GoogleFonts.readexPro(
                                  color: ColorResource.color232323,
                                  fontSize: AppUtils.getDeviceType() == "tablet"
                                      ? FontSize1.thirtyFive
                                      : FontSize1.thirty,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                StringResource.useForgotBelowToSignIn,
                                style: GoogleFonts.inter(
                                  color: ColorResource.color232323,
                                  fontSize: AppUtils.getDeviceType() == "tablet"
                                      ? FontSize1.fifteen
                                      : FontSize1.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: AppUtils.getDeviceType() == "tablet"
                                    ? 122
                                    : 155,),
                              DialogTextField(
                                controller: context
                                    .read<ForgotBloc>()
                                    .emailController,
                                validator: validateEmail,
                                label: '',
                                backgroundColor: Colors.white,
                                hint: StringResource.email,
                                isDecoration: true,
                                filledColor: true,

                              ),

                              const SizedBox(height: 50),
                              MaterialButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  if (context
                                      .read<ForgotBloc>()
                                      .formKey
                                      .currentState!
                                      .validate()) {
                                    context.read<ForgotBloc>().add(
                                        const ForgotPost());
                                  }
                                },
                                height: 50,
                                minWidth: 183,
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: ColorResource.color003867,
                                child: CustomText(
                                  StringResource.reset,
                                  color: ColorResource.colorWhite,
                                  fontSize: AppUtils.getDeviceType() == "tablet"
                                      ? FontSize1.fifteen
                                      : FontSize1.thirteen,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),

                              const SizedBox(height: 58),
                              GestureDetector(
                                onTap: () {
                                  context.goNamed(RouterNames.loginRouter);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      StringResource.or,
                                      color: ColorResource.color1E2027,
                                      fontSize: AppUtils.getDeviceType() ==
                                          "tablet"
                                          ? FontSize1.fifteen
                                          : FontSize1.thirteen,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    const SizedBox(width: 5.0),
                                    CustomText(
                                      StringResource.signIn,
                                      color: ColorResource.color003867,
                                      fontSize: AppUtils.getDeviceType() ==
                                          "tablet"
                                          ? FontSize1.fifteen
                                          : FontSize1.thirteen,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),),
                  // Main Content

                  if (state is ForgotLoading)
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 1,
                        child: AppUtils().buildLoading()),],
              ),
            ),
          ) : Container(
            height: MediaQuery
                .sizeOf(context)
                .height,
            color: ColorResource.colorWhite,
            child: Stack(
              children: [
                // Background Image
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 2.0,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageResource.signBg),
                      // Replace with your asset image path
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(child: Padding(
                  padding: EdgeInsets.only(left: AppUtils.getDeviceType() ==
                      "tablet" ? 34.0 : 14.0, right: AppUtils
                      .getDeviceType() == "tablet" ? 34.0 : 14.0),
                  child: Form(
                    key: context
                        .read<ForgotBloc>()
                        .formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: AppUtils
                                .getDeviceType() == "tablet" ? 225:139,
                            width: AppUtils
                                .getDeviceType() == "tablet" ?  276:172,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(32)),
                                color: ColorResource.colorWhite.withValues(alpha: 0.4)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(ImageResource.pactSplashScreen,alignment: Alignment.center,fit: BoxFit.contain),
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          CustomText(
                            "Forgot Password",
                            style: GoogleFonts.readexPro(
                              color: ColorResource.color232323,
                              fontSize: AppUtils.getDeviceType() == "tablet"
                                  ? FontSize1.thirtyFive
                                  : FontSize1.thirty,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomText(
                            StringResource.useForgotBelowToSignIn,
                            style: GoogleFonts.inter(
                              color: ColorResource.color232323,
                              fontSize: AppUtils.getDeviceType() == "tablet"
                                  ? FontSize1.fifteen
                                  : FontSize1.twelve,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: AppUtils.getDeviceType() == "tablet"
                                ? 100
                                : 50,),
                          DialogTextField(
                            controller: context
                                .read<ForgotBloc>()
                                .emailController,
                            validator: validateEmail,
                            label: '',
                            backgroundColor: Colors.white,
                            hint: StringResource.email,
                            isDecoration: true,
                            filledColor: true,

                          ),

                          const SizedBox(height: 50),
                          MaterialButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (context
                                  .read<ForgotBloc>()
                                  .formKey
                                  .currentState!
                                  .validate()) {
                                context.read<ForgotBloc>().add(
                                    const ForgotPost());
                              }
                            },
                            height: 50,
                            minWidth: 183,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: ColorResource.color003867,
                            child: CustomText(
                              StringResource.reset,
                              color: ColorResource.colorWhite,
                              fontSize: AppUtils.getDeviceType() == "tablet"
                                  ? FontSize1.fifteen
                                  : FontSize1.thirteen,
                              fontWeight: FontWeight.normal,
                            ),
                          ),

                          const SizedBox(height: 58),
                          GestureDetector(
                            onTap: () {
                              context.goNamed(RouterNames.loginRouter);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  StringResource.or,
                                  color: ColorResource.color1E2027,
                                  fontSize: AppUtils.getDeviceType() ==
                                      "tablet"
                                      ? FontSize1.fifteen
                                      : FontSize1.thirteen,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(width: 5.0),
                                CustomText(
                                  StringResource.signIn,
                                  color: ColorResource.color003867,
                                  fontSize: AppUtils.getDeviceType() ==
                                      "tablet"
                                      ? FontSize1.fifteen
                                      : FontSize1.thirteen,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                ),),

                if (state is ForgotLoading)
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 1,
                      child: AppUtils().buildLoading()),
                // Main Content

              ],
            ),
          )
      );
    }, listener: (context, state) {
      if (state is ForgotError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds:4),
            backgroundColor: Colors.red,
            content: Text(state.message!),
          ),
        );
      }
      if (state is ForgotLoaded) {
        context.pushNamed(RouterNames.loginRouter);
        AppUtils.showToast(context.read<ForgotBloc>().forgotPassword!.message.toString());
      }

      if(state is ForgotException){
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
    });
  }




  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email ID'
        : value.isEmpty
        ? "Enter a valid email ID"
        : null;
  }
}
