import 'package:task_management_kts/router/router_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_utility/app_constant.dart';
import '../../../app_utility/app_util.dart';
import '../../../app_utility/color_resource.dart';
import '../../../app_utility/constant.dart';
import '../../../app_utility/fonts.dart';
import '../../../app_utility/singleton.dart';
import '../../../widgets/custom_text.dart';
import '../bloc/layout_summary_bloc.dart';

//NOTE:
// AUDIT STATUS = PENDING:- DARK BLUE, SAVED":- YELLOW, COMPLETED:- COMPLETED

class TaskSummaryRootScreen extends StatefulWidget {
 final String? layoutDate;
  final String? siteId;
  final String? inLocation;
  const TaskSummaryRootScreen({super.key, required this.layoutDate,  required this.siteId, required this.inLocation});

  @override
  State<TaskSummaryRootScreen> createState() => _TaskSummaryRootScreenState();
}

class _TaskSummaryRootScreenState extends State<TaskSummaryRootScreen> {


  bool isSelectedTap=false;


  @override
  void initState() {

    AppUtils.getDeviceType();
    context.read<LayoutSummaryBloc>().add(GetLayoutSummaryList("all", widget.layoutDate!, widget.siteId!));
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return BlocConsumer<LayoutSummaryBloc, LayoutSummaryState>(
      builder: (context, state) {
        return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: AppBar(
                toolbarHeight: 80,
                scrolledUnderElevation: 0.0,
                leadingWidth: MediaQuery.of(context).size.width,
                backgroundColor: ColorResource.colorWhite,
                leading: Padding(
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
                        iconSize: 30,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                         Navigator.pop(context,true);
                        //  context.pushReplacementNamed(RouterNames.jobBoardRouter);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0, bottom: 4.0),
                        child: CustomText(
                         "Actions",
                          style: GoogleFonts.readexPro(
                            color: ColorResource.color232323,
                            fontSize: AppUtils.getDeviceType() == "tablet" ? FontSize1.twentyEight : FontSize1.twentyFour,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /*
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center align the action icons
                    children: [
                      widget.inLocation == "true" ?
                      Padding(
                          padding: const EdgeInsets.only(right: 22.0,top: 30),
                          child: GestureDetector(
                            onTap: () {

                              context.pushNamed(RouterNames.addTaskScreenRouter, queryParameters: {"date": widget.layoutDate, "siteId": widget.siteId!});
                            },
                            child: SizedBox(
                              height: AppUtils.getDeviceType() == "tablet" ? 35 : 30,
                              width: AppUtils.getDeviceType() == "tablet" ? 35 : 30,
                              child: Image.asset(
                                ImageResource.addLayout,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ) : const SizedBox(),


                    ],
                  ),
                ],
                */
              ),
            ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            color: ColorResource.colorWhite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height:40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 14.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${Singleton().site} ",
                          style: GoogleFonts.inter(
                            color: ColorResource.color1C1F26, // Set color for the text
                              fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen: FontSize1.thirteen,
                              fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: ": ${Singleton().agency}",
                          style: TextStyle(
                            color: ColorResource.color003867, // Set color for the asterisk
                              fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen: FontSize1.thirteen,
                              fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                      ],

                    ),
                  ),
                ),

                const SizedBox(
                  height:40,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left:  18.0, right: 14.0),
                  child: Container(
                    height:AppUtils.getDeviceType()=="tablet"?50:40,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.0,
                            color: ColorResource.colorF6F6F6),
                        color: ColorResource.colorF6F6F6,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(12.0))),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: AppUtils.getDeviceType()=="tablet"?15.0: 14.0, right: AppUtils.getDeviceType()=="tablet"?64.0: 14.0),
                      child:AppUtils.getDeviceType()=="tablet"? Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            StringResource.taskName,
                            style: GoogleFonts.inter(
                                color: ColorResource.color5A5C60,
                                fontSize: FontSize1.fifteen,
                                fontWeight: FontWeight.w500),
                          ),


                        ],
                      ): Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            StringResource.taskName,
                            style: GoogleFonts.inter(
                                color: ColorResource.color5A5C60,
                                fontSize: FontSize1.eleven,
                                fontWeight: FontWeight.w500),
                          ),


                        ],
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14.0,right: 14.0),
                    child: Stack(
                      children: [
                        if(state is LayoutSummaryLoaded)
                          Column(
                            children: [
                              AppUtils.getDeviceType()=="tablet"?
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,bottom: 10,),
                                  child: context.read<LayoutSummaryBloc>().layoutSummaryModelIsEmpty==false ? ListView.builder(
                                    itemCount:context.read<LayoutSummaryBloc>().layoutSummaryModel?.data?.length??0,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Container(
                                        decoration:BoxDecoration(
                                          border: Border(
                                            left: BorderSide(width: 1.0, color: ColorResource.colorF6F6F7.withValues(alpha: 0.8)),
                                            right: BorderSide(width: 1.0, color: ColorResource.colorF6F6F7.withValues(alpha: 0.8)),
                                            bottom: BorderSide(width: 1.0, color: ColorResource.colorF6F6F7.withValues(alpha: 0.8)),
                                            top: BorderSide(width: 1.0, color: ColorResource.colorF6F6F7.withValues(alpha: 0.8)),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 9.0,right:14.0,top: 20,bottom: 20.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(

                                                width:isPortrait==true && widget.inLocation=="true"?MediaQuery.of(context).size.width/1.7:isPortrait==true && widget.inLocation=="false"?MediaQuery.of(context).size.width/1.7:isPortrait==false && widget.inLocation=="true"?MediaQuery.of(context).size.width/1.5:MediaQuery.of(context).size.width/1.5,

                                                child: CustomText(
                                                  "${context.read<LayoutSummaryBloc>().layoutSummaryModel!.data![index].layoutName}",

                                                  style: GoogleFonts.inter(
                                                      color: ColorResource.color12151C,
                                                      fontSize: FontSize1.fifteen,
                                                      fontWeight: FontWeight.w400),
                                                ),
                                              ),

                                              InkWell(
                                                onTap:(){

                                                  context.pushNamed(RouterNames.auditFormWebViewScreen, queryParameters: {"task_url": "${context.read<LayoutSummaryBloc>().layoutSummaryModel!.data![index].typeFormUrl}"}).then((value) {
                                                    if (value != null && value == true) {
                                                if(context.mounted){
                                                  context.read<LayoutSummaryBloc>().add(GetLayoutSummaryList("all", widget.layoutDate!, widget.siteId!));
                                                }
                                                    }
                                                  });

                                                },
                                                child: Container(
                                                  height:30,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(width:1.0,color: context.read<LayoutSummaryBloc>().layoutSummaryModel!.data![index].auditStatus=="pending"&& widget.inLocation=="true" ?
                                                    ColorResource.color8AC7FF : context.read<LayoutSummaryBloc>().layoutSummaryModel!.data![index].auditStatus=="saved" && widget.inLocation=="true"? ColorResource.color8F6E19 : widget.inLocation=="false"?ColorResource.colorWhite:ColorResource.color003867),
                                                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                                    color: context.read<LayoutSummaryBloc>().layoutSummaryModel!.data![index].auditStatus=="pending" && widget.inLocation=="true" ?
                                                    ColorResource.color003867 : context.read<LayoutSummaryBloc>().layoutSummaryModel!.data![index].auditStatus=="saved"&& widget.inLocation=="true" ? ColorResource.colorF4D272 :widget.inLocation=="false"?ColorResource.colorADAFB3:ColorResource.color8AC7FF,
                                                  ),
                                                  child:Padding(
                                                    padding:  const EdgeInsets.only(left: 6.0,right: 6.0),
                                                    child: Center(
                                                      child: CustomText(
                                                        context.read<LayoutSummaryBloc>().layoutSummaryModel!.data![index].auditStatus=="pending" || context.read<LayoutSummaryBloc>().layoutSummaryModel!.data![index].auditStatus=="saved" ? StringResource.await : StringResource.completed,
                                                        style: GoogleFonts.inter(
                                                            color: context.read<LayoutSummaryBloc>().layoutSummaryModel!.data![index].auditStatus=="pending" && widget.inLocation=="true"?
                                                            ColorResource.color8AC7FF : context.read<LayoutSummaryBloc>().layoutSummaryModel!.data![index].auditStatus=="saved" && widget.inLocation=="true" ? ColorResource.color8F6E19 : widget.inLocation=="false"?ColorResource.colorWhite:ColorResource.color003867,
                                                            fontSize:FontSize1.fifteen,
                                                            fontWeight: FontWeight.w400),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      );
                                    },

                                  ) : Center(child: CustomText("No Records Found.",style: GoogleFonts.inter(
                                      color: ColorResource.color5A5C60,
                                      fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,
                                      fontWeight: FontWeight.w400),)),
                                ),
                              ):
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left:6.0,right: 0.0,top: 10.0,bottom: 10,),
                                  child: context.read<LayoutSummaryBloc>().layoutSummaryModelIsEmpty==false ? ListView.builder(
                                    itemCount:context.read<LayoutSummaryBloc>().layoutSummaryModel?.data?.length??0,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Container(
                                        decoration:BoxDecoration(
                                          border: Border(
                                            left: BorderSide(width: 1.0, color: ColorResource.colorF6F6F7.withValues(alpha: 0.8)),
                                            right: BorderSide(width: 1.0, color: ColorResource.colorF6F6F7.withValues(alpha: 0.8)),
                                            bottom: BorderSide(width: 1.0, color: ColorResource.colorF6F6F7.withValues(alpha: 0.8)),
                                            top: BorderSide(width: 1.0, color: ColorResource.colorF6F6F7.withValues(alpha: 0.8)),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 9.0,right:4.0,top: 20,bottom: 20.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width:isPortrait==true && widget.inLocation=="true"?MediaQuery.of(context).size.width/2.2:isPortrait==true && widget.inLocation=="false"?MediaQuery.of(context).size.width/2.2:isPortrait==false && widget.inLocation=="true"?MediaQuery.of(context).size.width/1.5:MediaQuery.of(context).size.width/1.5,
                                                child: CustomText(
                                                  "${context.read<LayoutSummaryBloc>().layoutSummaryModel!.data![index].layoutName}",
                                                  style: GoogleFonts.inter(
                                                      color: ColorResource.color12151C,
                                                      fontSize: FontSize1.twelve,
                                                      fontWeight: FontWeight.w400),
                                                ),
                                              ),

                                              SizedBox(
                                                width:140,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap:(){
                                                        context.pushNamed(RouterNames.auditFormWebViewScreen, queryParameters: {"task_url": "${context.read<LayoutSummaryBloc>().layoutSummaryModel!.data![index].typeFormUrl}"}).then((value) {
                                                          if (value != null && value == true) {
                                                           if(context.mounted){
                                                             context.read<LayoutSummaryBloc>().add(GetLayoutSummaryList("all", widget.layoutDate!, widget.siteId!));
                                                           }


                                                          }
                                                        });


                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(width:1.0,color: context.read<LayoutSummaryBloc>().layoutSummaryModel!.data![index].auditStatus=="pending" && widget.inLocation=="true"?
                                                          ColorResource.color8AC7FF : context.read<LayoutSummaryBloc>().layoutSummaryModel!.data![index].auditStatus=="saved"&& widget.inLocation=="true" ? ColorResource.color8F6E19 : widget.inLocation=="false"?ColorResource.colorWhite:ColorResource.color003867),
                                                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                                          color: context.read<LayoutSummaryBloc>().layoutSummaryModel!.data![index].auditStatus=="pending" && widget.inLocation=="true"?ColorResource.color003867 : context.read<LayoutSummaryBloc>().layoutSummaryModel!.data![index].auditStatus=="saved" && widget.inLocation=="true"? ColorResource.colorF4D272 :widget.inLocation=="false"?ColorResource.colorADAFB3:ColorResource.color8AC7FF,
                                                        ),
                                                        child:Padding(
                                                          padding:  const EdgeInsets.only(left: 6.0,right: 6.0,top: 6.0,bottom: 6.0),
                                                          child: Center(
                                                            child: CustomText(
                                                              context.read<LayoutSummaryBloc>().layoutSummaryModel!.data![index].auditStatus=="pending" || context.read<LayoutSummaryBloc>().layoutSummaryModel!.data![index].auditStatus=="saved" ? StringResource.await :"Tasks Completed",
                                                              style: GoogleFonts.inter(
                                                                  color: context.read<LayoutSummaryBloc>().layoutSummaryModel!.data![index].auditStatus=="pending"&& widget.inLocation=="true" ?
                                                                  ColorResource.color8AC7FF : context.read<LayoutSummaryBloc>().layoutSummaryModel!.data![index].auditStatus=="saved"&& widget.inLocation=="true" ? ColorResource.color8F6E19 :widget.inLocation=="false"?ColorResource.colorWhite:ColorResource.color003867,
                                                                  fontSize:FontSize1.thirteen,
                                                                  fontWeight: FontWeight.w400),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },

                                  ) : Center(child: CustomText("No Records Found.",style: GoogleFonts.inter(
                                      color: ColorResource.color5A5C60,
                                      fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,
                                      fontWeight: FontWeight.w400),)),
                                ),
                              )
                            ],
                          ),
                        isPortrait==true? Positioned(
                            child: Container(
                              height:MediaQuery.of(context).size.height /2,
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  if (state is LayoutSummaryLoading)
                                    SizedBox(
                                        child: AppUtils().buildLoading()),
                                ],
                              ),
                            )):Positioned(
                            child: Container(
                              height:MediaQuery.of(context).size.height /2,
                              color: Colors.white,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    if (state is LayoutSummaryLoading)
                                      SizedBox(
                                          child: AppUtils().buildLoading()),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          )
        );
      }, listener: (BuildContext context, state) {

      if (state is LayoutSummaryError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 4),
            backgroundColor: Colors.red,
            content: Center(child: Text(state.message.toString())),
          ),
        );
      }
      if(state is LayoutSummaryException){
        AppUtils.showInternetDialog(context,onPressed: () {

          context.pop();
        });
      }
      if(state is LayoutSummaryAuthorization){
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
