import 'dart:async';
import 'package:task_management_kts/app_utility/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_utility/app_constant.dart';
import '../../../app_utility/color_resource.dart';
import '../../../app_utility/constant.dart';
import '../../../app_utility/fonts.dart';
import '../../../app_utility/preference_helper.dart';
import '../../../app_utility/singleton.dart';
import '../../../router/router_names.dart';
import '../../../widgets/custom_text.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../bloc/job_board_bloc.dart';
import 'job_board_privacy policy_widget.dart';

class JobBoardScreen extends StatefulWidget {
  const JobBoardScreen({super.key});

  @override
  State<JobBoardScreen> createState() => _JobBoardScreenState();
}

class _JobBoardScreenState extends State<JobBoardScreen> {

  Timer timer = Timer(const Duration(milliseconds: 1), () {});
  String? matchDate;
  @override
  void initState() {

   data();

    context.read<JobBoardBloc>().selectedDay = DateTime.now();
    context.read<JobBoardBloc>().focusedDay = DateTime.now();
    AppUtils.getDeviceType();
checkPrivacyStatus(context);
    super.initState();
  }
  checkPrivacyStatus(BuildContext context)async{
    bool value=   await PreferenceHelper.getPrivacyStatus();
    if(context.mounted){
      if(value==false )
      {
        showPrivacyPolicyDialog(context);
      }
    }
  }
  data()  {
    context.read<JobBoardBloc>().add(GetJobBoardData(AppUtils.dateTimeFormat(DateTime.now()),DateTime.now(),DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobBoardBloc, JobBoardState>(
      builder: (context, state) {
        return   Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
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
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 7.0, bottom: 4.0),
                            child: CustomText(
                              StringResource.tasks,
                              style: GoogleFonts.readexPro(
                                  color: ColorResource.color232323,
                                  fontSize: AppUtils.getDeviceType() == "tablet"
                                      ? FontSize1.twentyFive
                                      : FontSize1.twentyOne,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),

                actions: [GestureDetector(
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
                          left: 20.0, right: 16.0, top: 20),
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

                  ],
                ),
              )],
                ),
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                color: ColorResource.colorWhite,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: TableCalendar(
                              firstDay: DateTime(2020),
                              lastDay: DateTime(2500),
                              focusedDay: context.read<JobBoardBloc>().focusedDay,
                              daysOfWeekHeight: 40,
                              rowHeight: 45,
                              selectedDayPredicate: (day) {
                                return isSameDay(
                                    context.read<JobBoardBloc>().selectedDay,
                                    day);
                              },
                              availableGestures: AvailableGestures.none,
                              calendarStyle: CalendarStyle(
                                selectedDecoration: const BoxDecoration(
                                  color: ColorResource.color003867,
                                  shape: BoxShape.circle,
                                ),
                                todayDecoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2.0,
                                      color: ColorResource.color02CA79),
                                  shape: BoxShape.circle,
                                ),
                                todayTextStyle: GoogleFonts.inter(
                                  fontSize: AppUtils.getDeviceType() == "tablet"
                                      ? FontSize1.fifteen
                                      : FontSize1.thirteen,
                                  fontWeight: FontWeight.w400,
                                ),
                                weekendTextStyle: GoogleFonts.inter(
                                  fontSize: AppUtils.getDeviceType() == "tablet"
                                      ? FontSize1.fifteen
                                      : FontSize1.thirteen,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              daysOfWeekStyle: DaysOfWeekStyle(
                                weekdayStyle: GoogleFonts.inter(
                                  fontSize: AppUtils.getDeviceType() == "tablet"
                                      ? FontSize1.fifteen
                                      : FontSize1.thirteen,
                                  fontWeight: FontWeight.w400,
                                ),
                                weekendStyle: GoogleFonts.inter(
                                  fontSize: AppUtils.getDeviceType() == "tablet"
                                      ? FontSize1.fifteen
                                      : FontSize1.thirteen,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              calendarFormat: CalendarFormat.week,
                              headerStyle: HeaderStyle(
                                leftChevronVisible: false,
                                rightChevronVisible: false,
                                leftChevronPadding: EdgeInsets.zero,
                                rightChevronPadding: EdgeInsets.zero,
                                rightChevronMargin: EdgeInsets.zero,
                                leftChevronMargin: EdgeInsets.zero,
                                headerMargin:
                                    const EdgeInsets.only(bottom: 10.0),
                                headerPadding: const EdgeInsets.only(left: 10),
                                titleTextStyle: GoogleFonts.readexPro(
                                  fontSize: AppUtils.getDeviceType() == "tablet"
                                      ? FontSize1.twenty
                                      : FontSize1.seventeen,
                                  fontWeight: FontWeight.bold,
                                ),
                                formatButtonVisible: false,
                              ),
                              calendarBuilders: CalendarBuilders(
                                headerTitleBuilder: (context, day) {
                                  final formattedDate = DateFormat.yMMMM()
                                      .format(context
                                          .read<JobBoardBloc>()
                                          .focusedDay);
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        formattedDate,
                                        style: GoogleFonts.readexPro(
                                          fontSize: AppUtils.getDeviceType() ==
                                                  "tablet"
                                              ? FontSize1.twenty
                                              : FontSize1.seventeen,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.calendar_today,
                                              color: ColorResource.color5A5C60,
                                              size: 25,
                                            ),
                                            onPressed: () {
                                              context.read<JobBoardBloc>().add(GetCurrentDateTime(DateTime.now()));
                                              data();

                                            },
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.keyboard_arrow_left,
                                              color: ColorResource.color5A5C60,
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              context.read<JobBoardBloc>().add(ChangeWeekTime(context.read<JobBoardBloc>().focusedDay.subtract(const Duration(days: 7))));

                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.keyboard_arrow_right,
                                              color: ColorResource.color5A5C60,
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              context.read<JobBoardBloc>().add(ChangeWeekTime( context
                                                  .read<JobBoardBloc>()
                                                  .focusedDay
                                                  .add(const Duration(
                                                  days: 7))));

                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                                defaultBuilder: (context, day, focusedDay) {
                                  var data1= context.read<JobBoardBloc>().calenderData?.data?.layoutStatus;
                                  if(data1!=null){
                                    var data = data1.where((element) => element.date == AppUtils.dateTimeFormat(day));
                                    for(var item in data){
                                      matchDate=item.date;
                                    }
                                  }

                                  BoxDecoration defaultDecoration;
                                  switch (day.weekday) {
                                    case DateTime.sunday:
                                      defaultDecoration =  BoxDecoration(
                                        color:AppUtils.dateTimeFormat(day)==matchDate?ColorResource.colorF4D272:ColorResource.colorWhite, // Decoration color for Sunday
                                        shape: BoxShape.circle,
                                      );
                                      break;
                                    case DateTime.monday:
                                      defaultDecoration =  BoxDecoration(
                                        color:AppUtils.dateTimeFormat(day)==matchDate? ColorResource.colorF4D272:ColorResource.colorWhite, // Decoration color for Monday
                                        shape: BoxShape.circle,
                                      );
                                      break;
                                    case DateTime.tuesday:
                                      defaultDecoration =  BoxDecoration(
                                        color:AppUtils.dateTimeFormat(day)==matchDate? ColorResource.colorF4D272:ColorResource.colorWhite, // Decoration color for Tuesday
                                        shape: BoxShape.circle,
                                      );
                                      break;
                                    case DateTime.wednesday:
                                      defaultDecoration = BoxDecoration(
                                        color: AppUtils.dateTimeFormat(day)==matchDate?ColorResource.colorF4D272:ColorResource.colorWhite, // Decoration color for Wednesday
                                        shape: BoxShape.circle,
                                      );
                                      break;
                                    case DateTime.thursday:
                                      defaultDecoration =  BoxDecoration(
                                        color: AppUtils.dateTimeFormat(day)==matchDate? ColorResource.colorF4D272:ColorResource.colorWhite, // Decoration color for Thursday
                                        shape: BoxShape.circle,
                                      );
                                      break;
                                    case DateTime.friday:
                                      defaultDecoration = BoxDecoration(
                                        color:AppUtils.dateTimeFormat(day)==matchDate? ColorResource.colorF4D272:ColorResource.colorWhite, // Decoration color for Friday
                                        shape: BoxShape.circle,
                                      );
                                      break;
                                    case DateTime.saturday:
                                      defaultDecoration =  BoxDecoration(
                                        color: AppUtils.dateTimeFormat(day)==matchDate? ColorResource.colorF4D272:ColorResource.colorWhite, // Decoration color for Saturday
                                        shape: BoxShape.circle,
                                      );
                                      break;
                                    default:
                                      defaultDecoration = const BoxDecoration(
                                        color: Colors.grey, // Default color if not matched
                                        shape: BoxShape.circle,
                                      );
                                  }

                                  return Container(
                                 margin: const EdgeInsets.all(5),
                                    decoration: defaultDecoration,
                                    child: Center(
                                      child: CustomText(
                                        '${day.day}',
                                        style: GoogleFonts.readexPro(
                                            color: ColorResource.color232323,
                                            fontSize:
                                            AppUtils.getDeviceType() == "tablet"
                                                ? FontSize1.fifteen
                                                : FontSize1.twelve,
                                            fontWeight: FontWeight.w400), // Text color
                                      ),
                                    ),
                                  );
                                },
                              ),
                              onDaySelected: (selectedDay, focusedDay) {
                                context.read<JobBoardBloc>().updateSelectedDay=selectedDay;
                                context.read<JobBoardBloc>().updateFocusDay=focusedDay;
                                context.read<JobBoardBloc>().add(GetJobBoardData(AppUtils.dateTimeFormat(selectedDay),selectedDay,focusedDay));

                              },
                            ),
                          ),

                          if (state is JobBoardLoaded)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 18.0),
                                      child: CustomText(
                                        StringResource.assigned,
                                        style: GoogleFonts.readexPro(
                                            color: ColorResource.color232323,
                                            fontSize:
                                                AppUtils.getDeviceType() ==
                                                        "tablet"
                                                    ? FontSize1.twentyFive
                                                    : FontSize1.twenty,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 18.0),
                                      child: CustomText(
                                        StringResource.allocatedTasksForYou,
                                        style: GoogleFonts.readexPro(
                                            color: ColorResource.color232323,
                                            fontSize:
                                                AppUtils.getDeviceType() ==
                                                        "tablet"
                                                    ? FontSize1.fifteen
                                                    : FontSize1.thirteen,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: context
                                            .read<JobBoardBloc>()
                                            .jobBoardModel
                                            ?.data
                                            ?.length ??
                                        0,
                                    itemBuilder:
                                        (BuildContext context, int index) {

                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: GestureDetector(
                                          onTap: () async {

                                            bool isInCurrentWeek = isSelectedDateInCurrentWeek(context.read<JobBoardBloc>().selectedDay);
                                            if(isInCurrentWeek==true) {
                                          final hasPermission = await AppUtils().handleLocationPermission(context);
                                            if (!hasPermission) return;
                                            if(context.mounted){
                                              context.read<JobBoardBloc>().add( JobBoardLocationFetching("${context.read<JobBoardBloc>().jobBoardModel?.data![index].siteId.toString()}"));
                                              Singleton().site = context.read<JobBoardBloc>().jobBoardModel?.data?[index].clientName;
                                              Singleton().agency = context.read<JobBoardBloc>().jobBoardModel?.data?[index].siteName;
                                            }
                                                }
                                            },
                                          child: Container(
                                            margin: EdgeInsets.only(left: AppUtils.getDeviceType() == "tablet" ? 60.0 : 15.0,
                                                right: AppUtils.getDeviceType() == "tablet"? 60.0 : 15.0),
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
                                                        "${context.read<JobBoardBloc>().jobBoardModel?.data?[index].clientName} :",
                                                        style: GoogleFonts.inter(
                                                            color: ColorResource
                                                                .color232323,
                                                            fontSize:
                                                                AppUtils.getDeviceType() ==
                                                                        "tablet"
                                                                    ? FontSize1
                                                                        .fifteen
                                                                    : FontSize1
                                                                        .twelve,
                                                            fontWeight:
                                                                FontWeight.w500),
                                                      ),
                                                      Expanded(
                                                        child: CustomText(
                                                          "${context.read<JobBoardBloc>().jobBoardModel?.data?[index].siteName}",
                                                          style:
                                                              GoogleFonts.inter(
                                                            color: ColorResource
                                                                .color003867,
                                                            fontSize:
                                                                AppUtils.getDeviceType() ==
                                                                        "tablet"
                                                                    ? FontSize1
                                                                        .fifteen
                                                                    : FontSize1
                                                                        .twelve,
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

                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(width: 2.0, color: ColorResource.colorE0E3E7),
                                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                          color: Colors.grey

                                                        ),

                                                        child: Center(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 6.0,right: 6.0),
                                                            child: CustomText(
                                                              "${context.read<JobBoardBloc>().jobBoardModel?.data?[index].notCompleted} Pending",
                                                              style: GoogleFonts.inter(
                                                                  color: ColorResource
                                                                      .colorWhite,
                                                                  fontSize:
                                                                      AppUtils.getDeviceType() ==
                                                                              "tablet"
                                                                          ? FontSize1
                                                                              .thirteen
                                                                          : FontSize1
                                                                              .eleven,
                                                                  fontWeight:
                                                                      FontWeight.w500),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10,),
                                                      Container(
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(width: 2.0, color: ColorResource.colorE0E3E7),
                                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                            color:ColorResource.color008B55

                                                        ),

                                                        child: Center(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 6.0,right: 6.0),
                                                            child: CustomText(
                                                              "${context.read<JobBoardBloc>().jobBoardModel?.data?[index].completed} Completed",
                                                              style: GoogleFonts.inter(
                                                                  color: ColorResource
                                                                      .colorWhite,
                                                                  fontSize:
                                                                  AppUtils.getDeviceType() ==
                                                                      "tablet"
                                                                      ? FontSize1
                                                                      .thirteen
                                                                      : FontSize1
                                                                      .eleven,
                                                                  fontWeight:
                                                                  FontWeight.w500),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          if (state is JobBoardEmpty)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: CustomText(
                                    StringResource.assigned,
                                    style: GoogleFonts.readexPro(
                                        color: ColorResource.color232323,
                                        fontSize:
                                        AppUtils.getDeviceType() == "tablet"
                                            ? FontSize1.twentyFive
                                            : FontSize1.twentyOne,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: CustomText(
                                    StringResource.allocatedTasksForYou,
                                    style: GoogleFonts.readexPro(
                                        color: ColorResource.color232323,
                                        fontSize:
                                        AppUtils.getDeviceType() == "tablet"
                                            ? FontSize1.fifteen
                                            : FontSize1.twelve,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: AppUtils.getDeviceType() == "tablet"
                                          ? 60.0
                                          : 15.0,
                                      right:
                                      AppUtils.getDeviceType() == "tablet"
                                          ? 60.0
                                          : 15.0),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      color: ColorResource.colorWhite,
                                      border: Border.all(
                                          width: 2.0,
                                          color: ColorResource.colorE0E3E7)),
                                  child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("No Records Found",
                                            style: GoogleFonts.inter(
                                                color: ColorResource.color232323,
                                                fontSize:
                                                AppUtils.getDeviceType() ==
                                                    "tablet"
                                                    ? FontSize1.fifteen
                                                    : FontSize1.twelve,
                                                fontWeight: FontWeight.w400)),
                                      )),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    Positioned(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state is JobBoardLoading)
                          SizedBox(child: AppUtils().buildLoading()),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ),
        );
        },
      listener: (BuildContext context, state)  {
        if (state is JobBoardException) {
          AppUtils.showInternetDialog(context, onPressed: () {
            data();
            context.pop();
          });
        }
        if (state is JobBoarLocationAlert) {
          Singleton().siteID=state.siteId;
          Singleton().layoutDate= AppUtils.dateTimeFormat(
              context.read<JobBoardBloc>().selectedDay);
          if (state.inLocation == true) {

          context.pushNamed(RouterNames.layoutScreenRouter, queryParameters: {
              "layoutDate": AppUtils.dateTimeFormat(
                  context.read<JobBoardBloc>().selectedDay),
              "siteId": state.siteId,
              "inLocation":"true"
            }).then((value){
            if (value != null && value == true) {
              data();
            }
          });




          } else if (state.inLocation == false){
            Singleton().siteID=state.siteId;
            Singleton().layoutDate= AppUtils.dateTimeFormat(
                context.read<JobBoardBloc>().selectedDay);
            AppUtils.showLocationMismatchDialog(context, "${state.message}", onPressed: ()  {
              context.pop();
           context.pushNamed(RouterNames.layoutScreenRouter, queryParameters: {
                "layoutDate": AppUtils.dateTimeFormat(context.read<JobBoardBloc>().selectedDay),
                "siteId": state.siteId,
                "inLocation":"false"
              }).then((value) {
             if (value != null && value == true) {

               data();
             }
           });

            });



          }
        }
        if (state is JobBoardAuthorization) {
     if(context.mounted){
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
        }
        if(state is JobBoardLocationDisable){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.red,
              content: Center(child: Text(state.message!)),
            ),
          );
          context.read<JobBoardBloc>().add(GetJobBoardData(AppUtils.dateTimeFormat(context.read<JobBoardBloc>().updateSelectedDay!),context.read<JobBoardBloc>().updateSelectedDay!,context.read<JobBoardBloc>().updateFocusDay!));

        }
      },
    );
  }
  bool isSelectedDateInCurrentWeek(DateTime selectedDate) {
    // Get the current date
    DateTime currentDate = DateTime.now();

    // Get the year and week number for the current date and the selected date
    int currentYear = currentDate.year;
    int selectedYear = selectedDate.year;

    int currentWeek = getIsoWeekNumber(currentDate);
    int selectedWeek = getIsoWeekNumber(selectedDate);

    // Compare year and week numbers to check if the selected date is in the current week
    return currentYear == selectedYear && currentWeek == selectedWeek;
  }

  int getIsoWeekNumber(DateTime date) {
    // Calculate ISO week number according to the ISO 8601 standard

    // Adjust the date to start from Monday (ISO 8601 standard)
    DateTime adjustedDate = date.subtract(Duration(days: (date.weekday - 0) % 7));

    // Calculate the year of the adjusted date
    int year = adjustedDate.year;

    // Find the first Thursday of the year
    DateTime firstThursday = DateTime(year, 1, 4);
    if (firstThursday.weekday != DateTime.thursday) {
      firstThursday = firstThursday.add(Duration(days: (7 + DateTime.thursday - firstThursday.weekday) % 7));
    }

    // Calculate the week number

    int weekNumber = ((adjustedDate.difference(firstThursday).inDays) ~/ 7) + 1;

    // Handle special case where the week number spans two years
    if (weekNumber == 0) {
      weekNumber = getIsoWeekNumber(DateTime(year - 1, 12, 31));
    } else if (weekNumber == 53 && getIsoWeekNumber(DateTime(year, 12, 31)) == 1) {
      weekNumber = 1;
    }

    return weekNumber;
  }


}

