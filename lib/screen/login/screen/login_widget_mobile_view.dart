import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app_utility/app_constant.dart';
import '../../../app_utility/color_resource.dart';
import '../../../app_utility/custom_text_form_field.dart';
import '../../../app_utility/fonts.dart';
import '../../../app_utility/image_resource.dart';
import '../../../router/router_names.dart';
import '../../../widgets/custom_text.dart';
import '../bloc/login_bloc.dart';

Widget mobilePortraitView(BuildContext context) {
  return Container(
    height: MediaQuery.sizeOf(context).height,
    color: ColorResource.colorWhite,
    child: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2.0,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageResource.signBg),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          child: Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0,top: 50,bottom: 20),
            child: Form(
              key: context.read<LoginBloc>().formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height:139,
                      width: 172,
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
                      height:27,
                    ),
                    CustomText(
                      StringResource.signIn,
                      style: GoogleFonts.readexPro(
                        color: ColorResource.color232323,
                        fontSize:FontSize1.thirty,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      StringResource.useTheAccountBelowToSignIn,
                      style: GoogleFonts.inter(
                        color: ColorResource.color232323,
                        fontSize:FontSize1.twelve,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 109,
                    ),
                    DialogTextField(
                      controller: context.read<LoginBloc>().emailController,
                      inputAction:TextInputAction.next,
                      validator: validateEmail,
                      label: 'Email',
                      backgroundColor: Colors.white,
                      hint: StringResource.email,
                      isDecoration: true,
                      filledColor: true,

                    ),
                    const SizedBox(
                      height:23,
                    ),
                    DialogTextField(
                      controller: context.read<LoginBloc>().passwordController,
                      showIcon: true,
                      inputAction:TextInputAction.done,
                      obscureText:context.read<LoginBloc>().isVisible2,
                      validator: (String? values) {
                        if (values!.isEmpty) {
                          return "Please enter password";
                        }
                        return null;
                      },
                      onTapSuffix: (){
                        if( context.read<LoginBloc>().isVisible2==true){
                          context.read<LoginBloc>().add(VisiblePostEvent(false));
                        }
                        else {
                          context.read<LoginBloc>().add(VisiblePostEvent(true));
                        }
                      },
                      label: 'Password',
                      backgroundColor: Colors.white,
                      hint: StringResource.password,
                      isDecoration: true,
                      filledColor: true,
                    ),
                    const SizedBox(height: 100),
                    MaterialButton(
                      onPressed: () {

                        FocusScope.of(context).unfocus();
  if (context
    .read<LoginBloc>()
    .formKey
    .currentState!
    .validate()) {
  context.read<LoginBloc>().add(
      GetLoginList(
          context
                .read<LoginBloc>()
                .emailController
                .text
                .trim(),
          context
                .read<LoginBloc>()
                .passwordController
                .text
                .trim()));
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
                        StringResource.signIn,
                        style: GoogleFonts.inter(
                          color: ColorResource.colorWhite,
                          fontSize:FontSize1.twelve,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    GestureDetector(
                      onTap: () {
                        context
                            .goNamed(RouterNames.forgotPasswordScreenRouter);
                      },
                      child: CustomText(
                        StringResource.forgotPassword,
                        style: GoogleFonts.inter(
                          color: ColorResource.color1E2027,
                          fontSize:FontSize1.twelve,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    GestureDetector(
                      onTap: () {
                        context.goNamed(RouterNames.registerRouter);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            StringResource.or,
                            color: ColorResource.color1E2027,
                            style: GoogleFonts.inter(
                              color: ColorResource.color1E2027,
                              fontSize:FontSize1.twelve,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          CustomText(
                            StringResource.registerNow,
                            style: GoogleFonts.inter(
                              color: ColorResource.color003867,
                              fontSize:FontSize1.twelve,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget mobileLandscapeView(BuildContext context) {
  return Container(
    height: MediaQuery.sizeOf(context).height,
    color: ColorResource.colorWhite,
    child: SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.0,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageResource.signBg),
                // Replace with your asset image path
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Form(
                key: context.read<LoginBloc>().formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height:30,
                        ),
                        Container(
                          height:139,
                          width: 172,
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
                          height:27,
                        ),
                        CustomText(
                          StringResource.signIn,
                          style: GoogleFonts.readexPro(
                            color: ColorResource.color232323,
                            fontSize:FontSize1.thirty,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        CustomText(
                          StringResource.useTheAccountBelowToSignIn,
                          style: GoogleFonts.inter(
                            color: ColorResource.color232323,
                            fontSize:FontSize1.twelve,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height:20,
                        ),
                        DialogTextField(
                          controller: context.read<LoginBloc>().emailController,
                          inputAction:TextInputAction.next,
                          validator: validateEmail,
                          label: 'Email',
                          backgroundColor: Colors.white,
                          hint: StringResource.email,
                          isDecoration: true,
                          filledColor: true,

                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DialogTextField(
                          controller: context.read<LoginBloc>().passwordController,
                          showIcon: true,
                          inputAction:TextInputAction.done,
                          obscureText:context.read<LoginBloc>().isVisible2,
                          validator: (String? values) {
                            if (values!.isEmpty) {
                              return "Please enter password";
                            }
                            return null;
                          },
                          onTapSuffix: (){
                            if( context.read<LoginBloc>().isVisible2==true){
                              context.read<LoginBloc>().add(VisiblePostEvent(false));
                            }
                            else {
                              context.read<LoginBloc>().add(VisiblePostEvent(true));
                            }
                          },
                          label: 'Password',
                          backgroundColor: Colors.white,
                          hint: StringResource.password,
                          isDecoration: true,
                          filledColor: true,
                        ),
                        const SizedBox(height: 20),
                        MaterialButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (context
                                .read<LoginBloc>()
                                .formKey
                                .currentState!
                                .validate()) {
                              context.read<LoginBloc>().add(
                                  GetLoginList(
                                      context
                                          .read<LoginBloc>()
                                          .emailController
                                          .text
                                          .trim(),
                                      context
                                          .read<LoginBloc>()
                                          .passwordController
                                          .text
                                          .trim()));
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
                            StringResource.signIn,
                            style: GoogleFonts.inter(
                              color: ColorResource.colorWhite,
                              fontSize:FontSize1.twelve,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            context
                                .goNamed(RouterNames.forgotPasswordScreenRouter);
                          },
                          child: CustomText(
                            StringResource.forgotPassword,
                            style: GoogleFonts.inter(
                              color: ColorResource.color1E2027,
                              fontSize:FontSize1.twelve,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            context.goNamed(RouterNames.registerRouter);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                StringResource.or,
                                color: ColorResource.color1E2027,
                                style: GoogleFonts.inter(
                                  color: ColorResource.color1E2027,
                                  fontSize:FontSize1.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              CustomText(
                                StringResource.registerNow,
                                style: GoogleFonts.inter(
                                  color: ColorResource.color003867,
                                  fontSize:FontSize1.twelve,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height:10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
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

//Tablet view

Widget tabletPortraitView(BuildContext context) {
  return SingleChildScrollView(
    child: Container(
      height: MediaQuery.sizeOf(context).height,
      color: ColorResource.colorWhite,
      child: Stack(
        children: [
// Background Image
          Container(
            height: MediaQuery.of(context).size.height / 2.0,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageResource.signBg),
                // Replace with your asset image path
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(left: 34.0, right: 34.0),
              child: Form(
                key: context.read<LoginBloc>().formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                      Container(
  height:225,
  width: 276,
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
                          height:20,
                        ),
                        CustomText(
                          StringResource.signIn,
                          style: GoogleFonts.readexPro(
                            color: ColorResource.color232323,
                            fontSize: FontSize1.thirtyFive,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          StringResource.useTheAccountBelowToSignIn,
                          style: GoogleFonts.inter(
                            color: ColorResource.color232323,
                            fontSize:FontSize1.fifteen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height:118,
                        ),
                        DialogTextField(
                          controller: context.read<LoginBloc>().emailController,
                          inputAction:TextInputAction.next,
                          validator: validateEmail,
                          label: 'Email',
                          backgroundColor: Colors.white,
                          hint: StringResource.email,
                          isDecoration: true,
                          filledColor: true,

                        ),
                        const SizedBox(
                          height:27,
                        ),
                        DialogTextField(
                          controller: context.read<LoginBloc>().passwordController,
                          showIcon: true,
                          inputAction:TextInputAction.done,
                          obscureText:context.read<LoginBloc>().isVisible2,
                          validator: (String? values) {
                            if (values!.isEmpty) {
                              return "Please enter password";
                            }
                            return null;
                          },
                          onTapSuffix: (){
                            if( context.read<LoginBloc>().isVisible2==true){
                              context.read<LoginBloc>().add(VisiblePostEvent(false));
                            }
                            else {
                              context.read<LoginBloc>().add(VisiblePostEvent(true));
                            }
                          },
                          label: 'Password',
                          backgroundColor: Colors.white,
                          hint: StringResource.password,
                          isDecoration: true,
                          filledColor: true,
                        ),
                        const SizedBox(height:130),
                        MaterialButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (context
                                .read<LoginBloc>()
                                .formKey
                                .currentState!
                                .validate()) {
                              context.read<LoginBloc>().add(
                                  GetLoginList(
                                      context
                                          .read<LoginBloc>()
                                          .emailController
                                          .text
                                          .trim(),
                                      context
                                          .read<LoginBloc>()
                                          .passwordController
                                          .text
                                          .trim()));
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
                            StringResource.signIn,
                            style: GoogleFonts.inter(
                                color: ColorResource.colorWhite,
                                fontSize:FontSize1.fifteen,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(height: 26),
                        GestureDetector(
                          onTap: () {
                            context
                                .goNamed(RouterNames.forgotPasswordScreenRouter);
                            },
                          child: CustomText(
                            StringResource.forgotPassword,

                            style: GoogleFonts.inter(
                                color: ColorResource.color1E2027,
                                fontSize:FontSize1.fifteen,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 26),
                        GestureDetector(
                          onTap: () {
                            context.goNamed(RouterNames.registerRouter);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                StringResource.or,

                            style: GoogleFonts.inter(
                                color: ColorResource.color1E2027,
                                fontSize:FontSize1.fifteen,
                                fontWeight: FontWeight.w500),
                          ),
                              const SizedBox(width: 5.0),
                              CustomText(
                                StringResource.registerNow,

                                style: GoogleFonts.inter(
                                    color: ColorResource.color003867,
                                    fontSize:FontSize1.fifteen,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget tabletLandscapeView(BuildContext context) {
  return Container(
    height: MediaQuery.sizeOf(context).height,
    color: ColorResource.colorWhite,
    child: SingleChildScrollView(
      child: Stack(
        children: [
// Background Image
          Container(
            height: MediaQuery.of(context).size.height / 2.0,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageResource.signBg),
                // Replace with your asset image path
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(left: 34.0, right:34.0),
              child: Form(
                key: context.read<LoginBloc>().formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height:40,
                        ),
                        Container(
                          height:200,
                          width: 276,
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
                          height:20,
                        ),
                        CustomText(
                          StringResource.signIn,
                          style: GoogleFonts.readexPro(
                            color: ColorResource.color232323,
                            fontSize:FontSize1.thirtyFive,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          StringResource.useTheAccountBelowToSignIn,
                          style: GoogleFonts.inter(
                            color: ColorResource.color232323,
                            fontSize:FontSize1.fifteen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height:50,
                        ),
                        DialogTextField(
                          controller: context.read<LoginBloc>().emailController,
                          inputAction:TextInputAction.next,
                          validator: validateEmail,
                          label: 'Email',
                          backgroundColor: Colors.white,
                          hint: StringResource.email,
                          isDecoration: true,
                          filledColor: true,

                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DialogTextField(
                          controller: context.read<LoginBloc>().passwordController,
                          showIcon: true,
                          inputAction:TextInputAction.done,
                          obscureText:context.read<LoginBloc>().isVisible2,
                          validator: (String? values) {
                            if (values!.isEmpty) {
                              return "Please enter password";
                            }
                            return null;
                          },
                          onTapSuffix: (){
                            if( context.read<LoginBloc>().isVisible2==true){
                              context.read<LoginBloc>().add(VisiblePostEvent(false));
                            }
                            else {
                              context.read<LoginBloc>().add(VisiblePostEvent(true));
                            }
                          },
                          label: 'Password',
                          backgroundColor: Colors.white,
                          hint: StringResource.password,
                          isDecoration: true,
                          filledColor: true,
                        ),
                        const SizedBox(height:40),
                        MaterialButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (context
                                .read<LoginBloc>()
                                .formKey
                                .currentState!
                                .validate()) {
                              context.read<LoginBloc>().add(
                                  GetLoginList(
                                      context
                                          .read<LoginBloc>()
                                          .emailController
                                          .text
                                          .trim(),
                                      context
                                          .read<LoginBloc>()
                                          .passwordController
                                          .text
                                          .trim()));
                            }

                            // context.goNamed(RouterNames.mainRouter);
                          },
                          height: 50,
                          minWidth: 183,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: ColorResource.color003867,
                          child: CustomText(
                            StringResource.signIn,
                            color: ColorResource.colorWhite,
                            fontSize: FontSize1.fourteen,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 28),
                        GestureDetector(
                          onTap: () {
                            context
                                .goNamed(RouterNames.forgotPasswordScreenRouter);
                          },
                          child: CustomText(
                            StringResource.forgotPassword,
                            style: GoogleFonts.inter(
                                color: ColorResource.color1E2027,
                                fontSize:FontSize1.fifteen,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 28),
                        GestureDetector(
                          onTap: () {
                            context.goNamed(RouterNames.registerRouter);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                StringResource.or,
                                style: GoogleFonts.inter(
                                    color: ColorResource.color1E2027,
                                    fontSize:FontSize1.fifteen,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(width: 5.0),
                              CustomText(
                                StringResource.registerNow,

                                style: GoogleFonts.inter(
                                    color: ColorResource.color003867,
                                    fontSize:FontSize1.fifteen,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
// Main Content
        ],
      ),
    ),
  );
}