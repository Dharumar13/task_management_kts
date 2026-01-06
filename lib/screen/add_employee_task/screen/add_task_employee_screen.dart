import 'package:task_management_kts/app_utility/app_util.dart';
import 'package:task_management_kts/router/router_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_utility/app_constant.dart';
import '../../../app_utility/color_resource.dart';
import '../../../app_utility/constant.dart';
import '../../../app_utility/fonts.dart';
import '../../../widgets/custom_text.dart';
import '../bloc/add_layout_member_bloc.dart';
import 'add_layout_member_widgets.dart';

class AddTaskEmployeeScreen extends StatefulWidget {
 final String? layoutId;
  final String? layoutName;
  const AddTaskEmployeeScreen(
      {super.key, required this.layoutId, required this.layoutName});

  @override
  State<AddTaskEmployeeScreen> createState() => _AddTaskEmployeeScreenState();
}

class _AddTaskEmployeeScreenState extends State<AddTaskEmployeeScreen> {

  @override
  void initState() {
    data();
    AppUtils.getDeviceType();
    super.initState();
  }

  data() async {
    context.read<AddLayoutMemberBloc>().layoutId = widget.layoutId!;
    context.read<AddLayoutMemberBloc>().layoutName = widget.layoutName!;
    debugPrint(widget.layoutId.toString());
    context.read<AddLayoutMemberBloc>().add(GetLayoutMemberList(widget.layoutId!));
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddLayoutMemberBloc, AddLayoutMemberState>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: SafeArea(
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(70.0),
                  child:AppBar(
                    toolbarHeight: 80,
                    scrolledUnderElevation:0.0,
                    leadingWidth: MediaQuery.of(context).size.width,
                    backgroundColor: ColorResource.colorWhite,
                    leading:Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
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
                              context.pop();
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:10.0,bottom: 4.0),
                            child: CustomText(
                              StringResource.addTask,
                              style: GoogleFonts.readexPro(
                                  color: ColorResource.color232323,
                                  fontSize: FontSize1.twentyEight,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ),
                body:  Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: ColorResource.colorWhite,
                  child: Stack(
                    children: [
                      if (state is AddLayoutMemberLoaded)
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Row(
                                  children: [
                                    CustomText(
                                      StringResource.selectedTaskDetails,
                                      style: GoogleFonts.inter(
                                        color: ColorResource.color1C1F26,
                                        fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.twelve,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              const SizedBox(height:10.0),
                              // if (state is AddLayoutMemberLoaded)
                              Padding(
                                padding:  EdgeInsets.only(left:AppUtils.getDeviceType()=="tablet"? 10.0:10.0,right:AppUtils.getDeviceType()=="tablet"?60.0:16.0,top:14),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 13.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomText(
                                          widget.layoutName!,
                                          isSingleLine: true,
                                          //"DOG FOOD - WET",
                                          style: GoogleFonts.inter(
                                              color: ColorResource.color747474,
                                              fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.twelve,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    //  const Spacer(),
                               /*       Container(
                                        height:AppUtils.getDeviceType()=="tablet"? 30:22,
                                        width:45,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.0,
                                                color: ColorResource.color003867),
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(AppUtils.getDeviceType()=="tablet"?6.0:6.0)),
                                            color: ColorResource.color8AC7FF),
                                        child: Center(
                                          child: CustomText(
                                            "${context.read<AddLayoutMemberBloc>().addLayoutMembersModel?.data?.duration}",
                                            style: GoogleFonts.inter(
                                                color: ColorResource.color003867,
                                                fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.fourteen:FontSize1.twelve,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 17),
                                      Container(
                                        height:AppUtils.getDeviceType()=="tablet"? 30:22,
                                        width:45,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.0,
                                                color: ColorResource.color5F5F5F),
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(AppUtils.getDeviceType()=="tablet"?6.0:6.0)),
                                            color: ColorResource.colorCCCCCC),
                                        child: Center(
                                          child: CustomText(
                                            "${context.read<AddLayoutMemberBloc>().addLayoutMembersModel?.data!.day?.toUpperCase()}",
                                            style: GoogleFonts.inter(
                                                color: ColorResource.color5A5C60,
                                            fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.fourteen:FontSize1.twelve,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),*/
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height:8.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0,right:15.0),
                                child: Divider(
                                  thickness: 1.0,
                                  color: ColorResource.colorF6F6F7.withValues(alpha: 0.8),
                                ),
                              ),
                           const Spacer(),

                              GestureDetector(
                                onTap: (){
                                  if(widget.layoutName!.isNotEmpty && widget.layoutId!.isNotEmpty) {
                                    addLayoutSheet(context: context);
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(seconds: 3),
                                        backgroundColor: Colors.red,
                                        content: Text(StringResource.selectLayout),
                                      ),
                                    );
                                  }

                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left:AppUtils.getDeviceType()=="tablet"?50:54.0, right: AppUtils.getDeviceType()=="tablet"?50.0:54.0),
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        border: Border.all(
                                            width: 1.0, color: ColorResource.color003867),
                                        color: ColorResource.color003867),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CustomText(
                                          StringResource.submit,
                                          style: GoogleFonts.inter(
                                              color: ColorResource.colorWhite,
                                              fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen: FontSize1.fourteen,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      Positioned(
                          child: Column(

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (state is AddLayoutMemberLoading)
                                SizedBox(child: AppUtils().buildLoading()),
                            ],
                          )),
                    ],
                  ),
                ),
              )
          ),
        );
      }, listener: (BuildContext context, state) {

      if (state is AddLayoutMemberError) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 4),
            backgroundColor: Colors.red,
            content: Center(child: Text(state.message!)),
          ),
        );
        data();
      }
      if(state is AddLayoutMemberException){
  AppUtils.showInternetDialog(context,onPressed: () {
    data();
    context.pop();
  });
      }
      if(state is AddLayoutAuthorization){
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
