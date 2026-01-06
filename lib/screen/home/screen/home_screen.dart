import 'dart:async';
import 'package:task_management_kts/app_utility/app_util.dart';
import 'package:task_management_kts/app_utility/singleton.dart';
import 'package:task_management_kts/screen/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_utility/app_constant.dart';
import '../../../app_utility/color_resource.dart';
import '../../../app_utility/constant.dart';
import '../../../app_utility/fonts.dart';
import '../../../router/router_names.dart';
import '../../../widgets/custom_text.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    AppUtils.greeting();
    AppUtils.getDeviceType();
    data();

    super.initState();
  }

  data()  {
    context.read<HomeBloc>().add(GetHomeData(DateTime.now()));
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        builder: (context, state) {
          return PopScope(
            canPop: context.read<HomeBloc>().popCan,
            onPopInvokedWithResult: (bool didPop, Object? result) async {
              if (!didPop) {
                AppUtils.showToast("Press back again to exit");
                context.read<HomeBloc>().add(PopScopeEvent(true));
              }
            },
            child: Container(
              color: Colors.white,
              child: SafeArea(
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(80.0),
                    child: AppBar(
                        toolbarHeight: 80,
                        scrolledUnderElevation: 0.0,
                        leadingWidth: MediaQuery.sizeOf(context).width,
                        backgroundColor: ColorResource.colorF6F6F6,
                        leading:GestureDetector(
                          onTap: () {

                            context.pushNamed(RouterNames.myProfileScreenRouter).then((value){
                              if (value != null && value == true) {
                                data();
                              }
                            });
                          },

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 16.0, bottom: 5.0),
                                child: Container(
                                  height:AppUtils.getDeviceType()=="tablet"? 52:40,
                                  width: AppUtils.getDeviceType()=="tablet"? 52:40,
                                  decoration: const BoxDecoration(
                                      color: ColorResource.color003867,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40))),
                                  child: const Icon(
                                    Icons.person,
                                    color: ColorResource.colorWhite,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:MediaQuery.sizeOf(context).width/1.3,
                                    child: Text(
                                      "${Singleton().userFirstName} ${Singleton().userLastName}",
                                      style: GoogleFonts.readexPro(
                                        color: ColorResource.color232323,
                                        fontSize: AppUtils.getDeviceType() == "tablet"
                                            ? FontSize1.twentyTwo
                                            : FontSize1.ninteen,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1, // Set the maximum number of lines before overflow
                                      overflow: TextOverflow.ellipsis, // Specify how overflow should be handled
                                    ),
                                  ),

                                  CustomText(
                                    "${AppUtils.greeting()} ${Singleton().userFirstName}",
                                    color: ColorResource.color232323,
                                    fontSize:AppUtils.getDeviceType() == "tablet"
                                        ? FontSize1.fifteen
                                        : FontSize1.twelve,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                  body: Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    color: ColorResource.colorF6F6F6,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        if (state is HomeLoaded)
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  CustomText(
                                    StringResource.home,
                                    style: GoogleFonts.inter(
                                        color: ColorResource.color232323,
                                        fontSize:AppUtils.getDeviceType() == "tablet"
                                            ? FontSize1.twentyEight
                                            : FontSize1.twentyFour,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        const Divider(
                                          thickness: 1.0,
                                          color: ColorResource.color707070,
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  StringResource.tasks,
                                                  style: GoogleFonts.inter(
                                                      color: ColorResource
                                                          .color232323,
                                                      fontSize: AppUtils.getDeviceType() ==
                                                              "tablet"
                                                          ? FontSize1.twentyFive
                                                          : FontSize1.twentyOne,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                CustomText(
                                                  context.read<HomeBloc>().homeLength == true ? "" : AppUtils.homeDateTimeFormat(DateTime.now()),
                                                  style: GoogleFonts.inter(
                                                      color: ColorResource
                                                          .color232323,
                                                      fontSize: AppUtils.getDeviceType() ==
                                                              "tablet"
                                                          ? FontSize1.fifteen
                                                          : FontSize1.thirteen,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                context.pushNamed(RouterNames.jobBoardRouter).then((value){
                                                  if (value != null && value == true) {
                                                    data();
                                                  }
                                                });
                                              },
                                              child: Container(
                                                height: 35,
                                                width: 35,
                                                decoration: const BoxDecoration(
                                                    color:
                                                        ColorResource.color003867,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(20))),
                                                child: const Icon(
                                                  Icons.keyboard_arrow_right,
                                                  color: ColorResource.colorWhite,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        context.read<HomeBloc>().homeLength == false ? ListView.builder(
                                        shrinkWrap: true,
                                          physics:const  NeverScrollableScrollPhysics(),
                                          itemCount: context.read<HomeBloc>().homeModel?.data?.tasks?.length??0,
                                          itemBuilder: (BuildContext context, int index){
                                        return   Padding(
                                          padding: EdgeInsets.only(
                                            top: 4,
                                            bottom: 4,
                                            left:AppUtils.getDeviceType() == "tablet"
                                                ? 60.0
                                                : 0,
                                            right:AppUtils.getDeviceType() == "tablet"
                                                ? 60
                                                : 0,
                                          ),
                                          child: GestureDetector(
                                            onTap: (){

                                              if(context.read<HomeBloc>().homeModel?.data?.tasks?[index].siteName==""){
                                              }
                                              else{
                                                context.pushNamed(RouterNames.jobBoardRouter).then((value){
                                                  if (value != null && value == true) {
                                                    data();
                                                  }
                                                });
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                                  color: ColorResource.colorWhite,
                                                  border: Border.all(
                                                      width: 2.0,
                                                      color: ColorResource
                                                          .colorE0E3E7)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(15.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CustomText(
                                                          "${context.read<HomeBloc>().homeModel?.data?.tasks?[index].clientName?? "_"} : ",
                                                          style: GoogleFonts.inter(
                                                              color: ColorResource
                                                                  .color232323,
                                                              fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.twelve,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                        ),
                                                        Expanded(
                                                          child: CustomText(
                                                            "${context.read<HomeBloc>().homeModel?.data?.tasks?[index].siteName}",
                                                            style:
                                                            GoogleFonts.inter(
                                                              color: ColorResource
                                                                  .color003867,
                                                              fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.twelve,
                                                              fontWeight:
                                                              FontWeight.w500,
                                                            ),
                                                            isSingleLine: true,
                                                            // Specify the overflow behavior
                                                            maxLines:
                                                            1, // Specify the maximum number of lines before truncating
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                    /*
                                                    CustomText(
                                                      "${context.read<HomeBloc>().homeModel?.data?.tasks?[index].siteName}",
                                                      style: GoogleFonts.inter(
                                                        color: ColorResource
                                                            .color232323,
                                                        fontSize:AppUtils.getDeviceType()=="tablet"? FontSize1.thirteen:FontSize1.eleven,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      isSingleLine: true,
                                                      // Specify the overflow behavior
                                                      maxLines:
                                                      1, // Specify the maximum number of lines before truncating
                                                    ),
                                                    */
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 2.0,
                                                              color: ColorResource
                                                                  .colorE0E3E7),
                                                          borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  10))),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                        child: CustomText(
                                                          "${context.read<HomeBloc>().homeModel?.data?.tasks?[index].noOfTasks} ${context.read<HomeBloc>().homeModel?.data?.tasks?[index].noOfTasks == 1 ? "Layout" : "Layouts"}",
                                                          style: GoogleFonts.inter(
                                                              color: ColorResource
                                                                  .color232323,
                                                              fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1
                                                                  .thirteen:FontSize1.eleven,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }): Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: ColorResource.colorWhite,
                                              border: Border.all(
                                                  width: 2.0,
                                                  color: ColorResource
                                                      .colorE0E3E7)),
                                          child: Center(child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("No Records Found", style: GoogleFonts.inter(
                                                color: ColorResource
                                                    .color232323,
                                                fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,
                                                fontWeight:
                                                FontWeight.w400)),
                                          ))

                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () async {

                                           context.pushNamed(RouterNames.jobBoardRouter).then((value){
                                             if (value != null && value == true) {
                                         data();
                                             }
                                           });

                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CustomText(
                                                StringResource.showAllTasks,
                                                style: GoogleFonts.inter(
                                                    color:
                                                        ColorResource.color5B5D61,
                                                    fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1
                                                        .thirteen:FontSize1.eleven,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              const Icon(
                                                Icons.keyboard_arrow_right,
                                                color: ColorResource.color5B5D61,
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2.0,
                                        ),
                                        const Divider(
                                          thickness: 1.0,
                                          color: ColorResource.color707070,
                                        ),

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        Positioned(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (state is HomeLoading)
                              SizedBox(child: AppUtils().buildLoading()),
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if(state is HomeError){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 4),
                backgroundColor: Colors.red,
                content: Text(state.message!),
              ),
            );
          }
          if(state is HomeException){
            AppUtils.showInternetDialog(context,onPressed: () {
              data();
              context.pop();
            });
          }
          if(state is HomeAuthorization){
            AppUtils.showAuthDialog(context,onPressed: () {
              SharedPreferences.getInstance().then((value) {
                value.setBool(SharedPrefKeys.isLogin, false).then((value) {
              if(context.mounted)
              {
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
