import 'dart:core';
import 'package:task_management_kts/app_utility/singleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_text.dart';
import 'color_resource.dart';
import 'package:intl/intl.dart';
import 'fonts.dart';

class AppUtils {
  static void showErrorToast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static void showToast(String text,
      {ToastGravity gravity = ToastGravity.CENTER}) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: gravity,
        backgroundColor:ColorResource.color003867,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static void showSnackBar(BuildContext context, String value) async {
    final snackbar = SnackBar(
      duration: const Duration(milliseconds:700),
      width: 710,
      content: Text(
        value,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.white),
      ),
      backgroundColor: Colors.green,
      action: SnackBarAction(
        label: '',
        textColor: Colors.white,
        onPressed: () {},
      ),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static void showCustomDialog(BuildContext context,
      {required void Function()? onPressed, String? data, String? title}) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    showGeneralDialog(
        context: context,
        barrierLabel: "Barrier",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (_, __, ___) {
          return Center(
            child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                width: isPortrait
                    ? MediaQuery.of(context).size.width / 1.5
                    : MediaQuery.of(context).size.width / 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Colors.white),
                      child: Center(
                          child: CustomText(
                        title!,
                        color: Colors.white,
                        fontSize: FontSize1.medium,
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            data!,
                            color: ColorResource.colorBlack,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MaterialButton(
                                  onPressed: () {
                                    context.pop();
                                    //context.pop();
                                  },
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  elevation: 5.0,
                                  height: 30,
                                  minWidth: 50,
                                  color: ColorResource.colorE65454,
                                  child: CustomText(
                                    "No",
                                    fontSize: FontSize1.fifteen,
                                    fontWeight: FontWeight.normal,
                                    color: ColorResource.colorWhite,
                                  )),
                              MaterialButton(
                                  onPressed: onPressed,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  elevation: 5.0,
                                  height: 30,
                                  minWidth: 50,
                                  color: Colors.green,
                                  child: CustomText(
                                    "Yes",
                                    fontSize: FontSize1.fifteen,
                                    fontWeight: FontWeight.normal,
                                    color: ColorResource.colorWhite,
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          );
        });
  }
 /*static  String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 550 ? 'phone' :'tablet';
  }*/
  static  String getDeviceType() {
    final data = MediaQueryData.fromView(WidgetsBinding.instance.window);
    return data.size.shortestSide < 550 ? 'phone' :'tablet';
  }
  static void showCustomDialogCancel(BuildContext context,
      {required void Function()? onPressed, String? data, String? type}) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    showGeneralDialog(
        context: context,
        barrierLabel: "Barrier",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (_, __, ___) {
          return Center(
            child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: ColorResource.colorWhite),
                width: isPortrait
                    ? MediaQuery.of(context).size.width / 1.5
                    : MediaQuery.of(context).size.width / 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: ColorResource.color232323),
                      child: Center(
                          child: CustomText(
                        type!,
                        color: ColorResource.colorWhite,
                        fontSize: FontSize1.medium,
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            data!,
                            color: ColorResource.color232323,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          MaterialButton(
                              onPressed: onPressed,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                              elevation: 5.0,
                              height: 30,
                              minWidth: 50,
                              color: ColorResource.colorE65454,
                              child: CustomText(
                                "Ok",
                                fontSize: FontSize1.fifteen,
                                fontWeight: FontWeight.normal,
                                color: ColorResource.colorWhite,
                              ))
                        ],
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  static void showErrorSnackBar(BuildContext context, String value) async {
    final snackbar = SnackBar(

      duration: const Duration(seconds: 5), // Set duration to 5 seconds
      width: 710,
      content: Text(
        value,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: ColorResource.colorWhite),
      ),
      backgroundColor: ColorResource.colorE65454,
      action: SnackBarAction(
        label: '',
        textColor: Colors.white,
        onPressed: () {},
      ),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static void hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  Widget buildLoading() => const Center(
        child: CircularProgressIndicator(
          color: ColorResource.color003867,
        ),
      );

  Future<DateTime?> showCalendar({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    initialDate ??= DateTime.now();
    firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
    lastDate ??= firstDate.add(const Duration(days: 365 * 200));
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate == null) return null;

    if (!context.mounted) return selectedDate;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    );

    return selectedTime == null
        ? selectedDate
        : DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
  }

  static String dateTimeFormat(DateTime data) {
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(data);
    return outputDate;
  }

  static String homeDateTimeFormat(DateTime data) {
    var outputFormat = DateFormat('MMMM d, yyyy');
    var outputDate = outputFormat.format(data);
    return outputDate;
  }

  static String customDateToFormat(String data, String outPutFormat) {
    DateTime tempDate = DateFormat("yyyy-MM-dd").parse(data);
    var outputFormat = DateFormat(outPutFormat);
    var outputDate = outputFormat.format(tempDate);
    return outputDate;
  }

  static String currentFullDateTimeFormat(DateTime data) {
    var outputFormat = DateFormat('yyy-MM-dd HH:mm:ss');
    var outputDate = outputFormat.format(data);
    return outputDate;
  }

  static String currentTimeFormat(DateTime data) {
    var outputFormat = DateFormat('HH:mm');
    var outputDate = outputFormat.format(data);
    return outputDate;
  }

  static String currentDateTimeFormat(DateTime data) {
    var outputFormat = DateFormat('yyy-MM-dd HH:mm:ss');
    var outputDate = outputFormat.format(data);
    return outputDate;
  }

  static String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }
  static void showInternetDialog(BuildContext context,
      {required void Function()? onPressed}) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title:  Column(
          children: [
            Singleton().isConnection == false
                ?const Icon(
              Icons.network_check,
              size: 25,color: ColorResource.colorE65454
            ):const Icon(
              Icons.cancel,color: ColorResource.colorE65454,
              size: 25,
            ),
            const SizedBox(height: 10,),
            Text(Singleton().isConnection == false
                ?"No Internet Connection":"Request Failed")
          ],
        ),
        content:  Text(Singleton().isConnection == false
            ?'Please make sure Wi-Fi or mobile data is turned on and try again.':"We were unable to get the requested information, please try again in 5 minutes."),
        actions: <Widget>[
          Singleton().isConnection == false
              ?   TextButton(
            onPressed: onPressed,
            child:const CustomText('OK',color: ColorResource.color003867,fontWeight:FontWeight.bold),
          ): TextButton(
            onPressed: (){
              context.pop();
            },
            child:  const CustomText('OK',color: ColorResource.color003867,fontWeight:FontWeight.bold,),
          ),
        ],
      ),
    );
  }


  static void showLocationMismatchDialog(BuildContext context, String message,
      {required void Function()? onPressed}) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title:  const Column(
          children: [
            Icon(
                Icons.location_pin,
                size: 25,color: ColorResource.colorE65454
            ),
            SizedBox(height: 10,),
            Text("Location")
          ],
        ),
        content:  Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: onPressed,
            child:const CustomText('Ok',color: ColorResource.color003867,fontWeight:FontWeight.bold),
          ), TextButton(
            onPressed: (){
              context.pop();
            },
            child:  const CustomText('Cancel',color: ColorResource.color003867,fontWeight:FontWeight.bold,),
          ),
        ],
      ),
    );
  }

  static void showAuthDialog(BuildContext context,
      {required void Function()? onPressed}) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title:  const Column(
          children: [
            Icon(
              Icons.cancel,
              size: 25,
              color: ColorResource.colorE65454,
            ),
            Text("Session Expired"),
          ],
        ),
        content:  const Text("Please login again"),
        actions: <Widget>[
          TextButton(
            onPressed: onPressed,
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<bool> handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    /* if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      permission = await Geolocator.requestPermission();
      return false;
    }*/
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
        permission = await Geolocator.requestPermission();
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Location permissions are permanently denied. You can enable them in app settings.'),

          action: SnackBarAction(
            label: 'Open Settings',
            onPressed: () {
              Geolocator.openAppSettings();
            },
          ),
        ),
      );
      // You might want to return false here or handle the case appropriately
      return false;
    }
    return true;
  }
}
