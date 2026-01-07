import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app_utility/color_resource.dart';
import '../../../app_utility/fonts.dart';
import '../../../app_utility/preference_helper.dart';
import '../../../widgets/custom_text.dart';
import '../bloc/job_board_bloc.dart';


showPrivacyPolicyDialog(BuildContext context) {
  final exampleCubit = context.read<JobBoardBloc>();
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return BlocProvider<JobBoardBloc>.value(
        value: exampleCubit,
        child: const CustomDialog(),
      );
    },
  );
}

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobBoardBloc, JobBoardState>(
        builder: (context, state) {
          return AlertDialog(
            title: CustomText('Privacy Notice',
                style: GoogleFonts.inter(
                  color: ColorResource.color232323,
                  fontSize: FontSize1.fifteen,
                  fontWeight: FontWeight.w600,
                )),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      '${context.read<JobBoardBloc>().jobBoardModel?.privacyPolicy?.notice}',
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,
                        fontSize: FontSize1.thirteen,
                        fontWeight: FontWeight.w400,
                      )),
                  Text(
                      'Data Usage:',
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,
                        fontSize: FontSize1.thirteen,
                        fontWeight: FontWeight.w600,
                      )),
                  Text(
                      '- Personalization of content and features\n- Improvement of app performance\n- Communication and updates',
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,
                        fontSize: FontSize1.thirteen,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(height:15.0),
                  Text(
                      'Location Data Collection:',
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,
                        fontSize: FontSize1.thirteen,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(height:5.0),
                  Text(
                      'Data Collection and Usage Notice:',
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,
                        fontSize: FontSize1.thirteen,
                        fontWeight: FontWeight.w600,
                      )),
                  Text(
                      'PACT collects precise or approximate location data to track time and calculate distance for assigned sites.',
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,
                        fontSize: FontSize1.thirteen,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(height:5.0),
                  Text(
                      'Data Collected:',
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,
                        fontSize: FontSize1.thirteen,
                        fontWeight: FontWeight.w600,
                      )),
                  Text(
                      '- Your location data',
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,
                        fontSize: FontSize1.thirteen,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(height:5.0),
                  Text(
                      'How We Use Your Data:',
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,
                        fontSize: FontSize1.thirteen,
                        fontWeight: FontWeight.w600,
                      )),
                  Text(
                      '- To track the time spent on-site\n- To calculate the distance traveled to and from the assigned site',
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,
                        fontSize: FontSize1.thirteen,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(height:5.0),
                  Text(
                      'How We Share Your Data:',
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,
                        fontSize: FontSize1.thirteen,
                        fontWeight: FontWeight.w600,
                      )),
                  Text(
                      '- Your location data is not shared with third parties except as required by law or to improve our services.',
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,
                        fontSize: FontSize1.thirteen,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(height:5.0),
                  Text(
                      'Your Consent:',
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,
                        fontSize: FontSize1.thirteen,
                        fontWeight: FontWeight.w600,
                      )),
                  Text(
                      '- By clicking "Accept," you consent to the collection and use of your location data as described. If you decline, you will not be able to use the features that require location access.',
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,
                        fontSize: FontSize1.thirteen,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(height:15.0),
                  Text(
                      'Image and Document Access:',
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,
                        fontSize: FontSize1.thirteen,
                        fontWeight: FontWeight.w600,
                      )),

                  const SizedBox(height:5.0),
                  Text(
                      'Data Collection and Usage Notice:',
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,
                        fontSize: FontSize1.thirteen,
                        fontWeight: FontWeight.w600,
                      )),
                  Text(
                      'PACT collects images and documents as proof of task completion.',
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,
                        fontSize: FontSize1.thirteen,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(height:5.0),
                  Text(
                      'Data Collected:',
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,
                        fontSize: FontSize1.thirteen,
                        fontWeight: FontWeight.w600,
                      )),
                  Text(
                      '- Images and documents from Gallery and Camera',
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,
                        fontSize: FontSize1.thirteen,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(height:5.0),
                  Text(
                      'How We Use Your Data:',
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,
                        fontSize: FontSize1.thirteen,
                        fontWeight: FontWeight.w600,
                      )),
                  Text(
                      '- To verify presence at the appropriate site\n- As proof of task completion'
                      ,                      style: GoogleFonts.inter(
                    color: ColorResource.colorAG111111,
                    fontSize: FontSize1.thirteen,
                    fontWeight: FontWeight.w400,
                  )),
                  const SizedBox(height:5.0),
                  Text(
                      'How We Share Your Data:',
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,
                        fontSize: FontSize1.thirteen,
                        fontWeight: FontWeight.w600,
                      )),
                  Text(
                      '- Images and documents are not shared with third parties except as required by law or to improve our services.'
                      ,                      style: GoogleFonts.inter(
                    color: ColorResource.colorAG111111,
                    fontSize: FontSize1.thirteen,
                    fontWeight: FontWeight.w400,
                  )),
                  const SizedBox(height:5.0),
                  Text(
                      'Your Consent:',
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,
                        fontSize: FontSize1.thirteen,
                        fontWeight: FontWeight.w600,
                      )),
                  Text(
                      '- By clicking "Accept," you consent to the collection and use of your images and documents as described. If you decline, you will not be able to use the features that require image and document access.'
                      ,                      style: GoogleFonts.inter(
                    color: ColorResource.colorAG111111,
                    fontSize: FontSize1.thirteen,
                    fontWeight: FontWeight.w400,
                  )),
                  const SizedBox(height: 10,),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.inter(
                        color: ColorResource.colorAG111111,// Replace with your actual color
                        fontSize: FontSize1.thirteen,// Replace with your actual font size
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        const TextSpan(
                          text: "For more details, please review our",
                        ),
                        TextSpan(
                          text: " Privacy Policy.",
                          style: GoogleFonts.inter(
                            color: ColorResource.color003867, // Replace with your actual color
                            fontSize: FontSize1.thirteen, // Replace with your actual font size
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _launchUrl(context);
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[

              TextButton(
                child: CustomText('Decline', style: GoogleFonts.inter(
                  color: ColorResource.color232323,
                  fontSize: FontSize1.thirteen,
                  fontWeight: FontWeight.w600,
                )),
                onPressed: ()async {
                  //  context.read<HomeBloc>().add(const GetHomeData(2));
                  await PreferenceHelper.setPrivacyStatus(false );
                  if(context.mounted){
                    Navigator.of(context).pop();
                  }
                },
              ),
              ElevatedButton(
                child: CustomText('Accept', style: GoogleFonts.inter(
                  color: ColorResource.color003867,
                  fontSize: FontSize1.thirteen,
                  fontWeight: FontWeight.w600,
                )),
                onPressed: ()async {
                  // context.read<HomeBloc>().add(const GetHomeData(1));
                  await PreferenceHelper.setPrivacyStatus(true);
                  if(context.mounted){
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        },
        listener: (BuildContext context, JobBoardState state) {});
  }

  Future<void> _launchUrl(BuildContext context) async {
    final Uri url = Uri.parse('${context.read<JobBoardBloc>().jobBoardModel?.privacyPolicy?.policyUrl}');

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}