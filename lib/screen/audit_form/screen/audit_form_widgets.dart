import 'package:task_management_kts/screen/audit_form/bloc/audit_form_bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform;
import '../../../app_utility/app_constant.dart';
import '../../../app_utility/app_util.dart';
import '../../../app_utility/color_resource.dart';
import '../../../app_utility/fonts.dart';
import '../../../widgets/custom_text.dart';
import '../../edit_profile/screen/edit_profile_widget.dart';

void confirmSheet({
  required BuildContext context,
  required String layoutId,
}) {
  final layoutBloc = context.read<AuditFormBloc>();
  showModalBottomSheet(
    enableDrag: true,
    isDismissible: true,
    isScrollControlled: true,
     useSafeArea: true,
    backgroundColor: ColorResource.colorWhite,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0),topRight:  Radius.circular(50.0)),
        side: BorderSide(width: 1.0,color: ColorResource.color003867)
    ),
    context: context,
    builder: (BuildContext context) {
      return  BlocProvider.value(
          value: layoutBloc, child: LayoutConfirmAlertsSheet(layoutId: layoutId,));
    },
  );
}

class LayoutConfirmAlertsSheet extends StatelessWidget {
  final String? layoutId;
  const LayoutConfirmAlertsSheet(
      {super.key, required this.layoutId});

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    AppUtils.getDeviceType();
    return BlocConsumer<AuditFormBloc, AuditFormState>(builder: (context, state){
      return Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppUtils.getDeviceType()=="tablet"?50.0:50),
                Center(
                  child: SizedBox(
                    width:isPortrait==true? MediaQuery.of(context).size.width/1.5:MediaQuery.of(context).size.width/2.3,
                    child: CustomText(
                      "Are you sure to submit the audit answers for ${context.read<AuditFormBloc>().auditFormModel?.data?.layoutName}?",
                      maxLines: 5,
                      style: GoogleFonts.inter( color: ColorResource.color1C1F26,
                        fontWeight: FontWeight.w500,
                        fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.twenty:FontSize1.twelve,),
                    ),
                  ),
                ),
                SizedBox(height:AppUtils.getDeviceType()=="tablet"?50.0:30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                      child: MaterialButton(onPressed: (){
                        //context.read<AllLayoutsBloc>().add(SaveCommentLayout());
                        context.pop();
                      },
                        minWidth: isPortrait==true?MediaQuery.of(context).size.width/3:MediaQuery.of(context).size.width/6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height:AppUtils.getDeviceType()=="tablet"? 40:34,
                        color: ColorResource.color003867,
                        child:  CustomText(
                          StringResource.cancel,
                          style: GoogleFonts.inter(   color: ColorResource.colorWhite,
                            fontWeight: FontWeight.w400,
                            fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                      child: MaterialButton(onPressed: (){
                        context.read<AuditFormBloc>().add(SaveOrSubmitAnswers(layoutId!,"post"));
                        context.pop();
                      },
                        minWidth: isPortrait==true?MediaQuery.of(context).size.width/3:MediaQuery.of(context).size.width/6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height:AppUtils.getDeviceType()=="tablet"? 40:34,
                        color: ColorResource.colorWhite,
                        child:  CustomText(
                          StringResource.confirm,
                          style: GoogleFonts.inter(   color: ColorResource.color5A5C60,
                            fontWeight: FontWeight.w400,
                            fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height:AppUtils.getDeviceType()=="tablet"?50.0:30),

              ],
            ),
          ),
        ],
      );
    }, listener: (context, state){});
  }
}



void confirmationSheet({
  required BuildContext context,
  required String layoutId,
  required String message,
}) {
  final layoutBloc = context.read<AuditFormBloc>();
  showModalBottomSheet(
    enableDrag: true,
    isDismissible: true,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: ColorResource.colorWhite,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0),topRight:  Radius.circular(50.0)),
        side: BorderSide(width: 1.0,color: ColorResource.color003867)
    ),
    context: context,
    builder: (BuildContext context) {
      return  BlocProvider.value(
          value: layoutBloc, child: LayoutConfirmationSheet(layoutId: layoutId, message: message));
    },
  );
}

//FINAL CONFIRMATION
class LayoutConfirmationSheet extends StatelessWidget {
 final String? layoutId;
  final String? message;
 const  LayoutConfirmationSheet(
      {super.key, required this.layoutId, required this.message});

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    AppUtils.getDeviceType();
    return BlocConsumer<AuditFormBloc, AuditFormState>(builder: (context, state){
      return Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: AppUtils.getDeviceType()=="tablet"?50.0:50
                ),
                Center(
                  child: SizedBox(
                    width:isPortrait==true? MediaQuery.of(context).size.width/1.5:MediaQuery.of(context).size.width/2.3,
                    child: CustomText(
                      message!,
                      maxLines: 5,
                      style: GoogleFonts.inter( color: ColorResource.color1C1F26,
                        fontWeight: FontWeight.w500,
                        fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.twenty:FontSize1.twelve,),
                    ),
                  ),
                ),
                SizedBox(
                  height:AppUtils.getDeviceType()=="tablet"?50.0:30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                      child: MaterialButton(onPressed: (){
                        context.pop();
                      },
                        minWidth: isPortrait==true?MediaQuery.of(context).size.width/3:MediaQuery.of(context).size.width/6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height:AppUtils.getDeviceType()=="tablet"? 40:34,
                        color: ColorResource.color003867,
                        child:  CustomText(
                          StringResource.cancel,
                          style: GoogleFonts.inter(   color: ColorResource.colorWhite,
                            fontWeight: FontWeight.w400,
                            fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                      child: MaterialButton(onPressed: (){
                        context.read<AuditFormBloc>().add(FinalSubmitAnswers(layoutId!));
                         Navigator.pop(context,true);
                      },
                        minWidth: isPortrait==true?MediaQuery.of(context).size.width/3:MediaQuery.of(context).size.width/6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height:AppUtils.getDeviceType()=="tablet"? 40:34,
                        color: ColorResource.colorWhite,
                        child:  CustomText(
                          StringResource.confirm,
                          style: GoogleFonts.inter(   color: ColorResource.color5A5C60,
                            fontWeight: FontWeight.w400,
                            fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height:AppUtils.getDeviceType()=="tablet"?50.0:30,
                ),

              ],
            ),
          ),
        ],
      );
    }, listener: (context, state){});
  }
}



void alertSheet({
  required BuildContext context,
  required String message,
}) {
  final layoutBloc = context.read<AuditFormBloc>();
  showModalBottomSheet(
    enableDrag: true,
    isDismissible: true,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: ColorResource.colorWhite,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0),topRight:  Radius.circular(50.0)),
        side: BorderSide(width: 1.0,color: ColorResource.color003867)
    ),
    context: context,
    builder: (BuildContext context) {
      return  BlocProvider.value(
          value: layoutBloc, child: AlertSheet(message: message));
    },
  );
}

//FINAL Alert
class AlertSheet extends StatelessWidget {
 final String? message;
  const AlertSheet(
      {super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    AppUtils.getDeviceType();
    return BlocConsumer<AuditFormBloc, AuditFormState>(builder: (context, state){
      return Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: AppUtils.getDeviceType()=="tablet"?50.0:50
                ),
                Center(
                  child: SizedBox(
                    width:isPortrait==true? MediaQuery.of(context).size.width/1.5:MediaQuery.of(context).size.width/2.3,
                    child: Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        message!,
                        maxLines: 5,
                        style: GoogleFonts.inter( color: ColorResource.color1C1F26,
                          fontWeight: FontWeight.w500,
                          fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.twenty:FontSize1.twelve,),
                      ),
                    ),
                  ),
                ),
                SizedBox(height:AppUtils.getDeviceType()=="tablet"?50.0:30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                      child: MaterialButton(onPressed: (){
                        //context.read<AllLayoutsBloc>().add(SaveCommentLayout());
                        context.pop();
                      },
                        minWidth: isPortrait==true?MediaQuery.of(context).size.width/3:MediaQuery.of(context).size.width/6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height:AppUtils.getDeviceType()=="tablet"? 40:34,
                        color: ColorResource.color003867,
                        child:  CustomText(
                          StringResource.ok,
                          style: GoogleFonts.inter(   color: ColorResource.colorWhite,
                            fontWeight: FontWeight.w400,
                            fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height:AppUtils.getDeviceType()=="tablet"?50.0:30),
              ],
            ),
          ),
        ],
      );
    }, listener: (context, state){});
  }
}

void showImagePicker({
  required BuildContext context,required int index
}) {
  final examplecubit = context.read<AuditFormBloc>();
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0),topRight:  Radius.circular(50.0)),
        side: BorderSide(width: 1.0,color: ColorResource.color003867)
    ),
    builder: (BuildContext context) {
      return BlocProvider.value(
          value: examplecubit, child:  CustomDialog( indexValue:index,));
    },
  );
}
class CustomDialog extends StatelessWidget {
 final int indexValue;
  const CustomDialog({
    required this.indexValue, super.key,
  });

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AuditFormBloc, AuditFormState>(
        builder: (context, state) {
          return SafeArea(
            child: Wrap(
            //  crossAxisAlignment:WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: <Widget>[
                Padding(

                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    "Select source",
                    style: GoogleFonts.inter(   color: ColorResource.color232323,
                      fontWeight: FontWeight.w600,
                      fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.twenty:FontSize1.seventeen,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10,left: 30),
                  child: ListTile(
                    leading:  Icon(Icons.photo_library,size:AppUtils.getDeviceType()=="tablet"? 30:25,color: ColorResource.color003867),
                    title:CustomText(
                    "Photo Library",
                    style: GoogleFonts.inter(   color: ColorResource.color003867,
                      fontWeight: FontWeight.w500,
                      fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,),
                  ),
                    onTap: () async {
                      if (Platform.isAndroid) {
                        final androidInfo = await DeviceInfoPlugin().androidInfo;
                        if (androidInfo.version.sdkInt <= 32) {
                          if (context.mounted) {
                            context.read<AuditFormBloc>().add(
                                 MultipleImageEvent(indexValue));
                            context.pop();
                          }
                        }  else {
                        }
                        var status = await Permission.photos.status;
                        if (status.isDenied) {
                          if(context.mounted) {
                            _requestPhotosPermission(context);
                          }
                        } else if (status
                            .isGranted) {
                          if (context.mounted) {
                            context
                                .read<
                                AuditFormBloc>()
                                .add(
                             MultipleImageEvent(indexValue));
                            context.pop();
                          }
                        } else if (status
                            .isPermanentlyDenied) {
                          if (context.mounted) {
                            Permission.photos
                                .request();
                            showCustomCameraPermission(
                                context, "Allow access to gallery and photos");
                          }
                        } else if (status
                            .isRestricted) {}
                      }
                      if (Platform.isIOS) {
                        var status =
                        await Permission
                            .photos.status;
                        if (status.isDenied) {
                        if(context.mounted){
                          _requestPhotosPermission(context);
                        }
                        } else if (status
                            .isLimited) {

                           if(context.mounted){
                             context.read<AuditFormBloc>().add( MultipleImageEvent(indexValue));
                             context.pop();
                           }

                        } else if (status
                            .isGranted) {
                          if (context.mounted) {
                            context
                                .read<
                                AuditFormBloc>()
                                .add(
                                 MultipleImageEvent(indexValue));
                            context.pop();
                          }
                        } else if (status
                            .isPermanentlyDenied) {
                          if (context.mounted) {
                            showAlertDialogCameraPermission(context, 'Allow access to gallery and photos');
                          }
                        } else if (status
                            .isRestricted) {}
                      }

                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,bottom: 30),
                  child: ListTile(
                    leading:  Icon(Icons.photo_camera,size:AppUtils.getDeviceType()=="tablet"? 30:25,color: ColorResource.color003867,),
                    title:CustomText(
                      "Camera",
                      style: GoogleFonts.inter(   color: ColorResource.color003867,
                        fontWeight: FontWeight.w500,
                        fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen),
                    ),
                    onTap: () async {
                      if (Platform.isAndroid) {
                        var status = await Permission.camera.status;
                        if (status.isDenied) {
                        if(context.mounted){
                          _requestCameraPermission(context);
                        }
                        } else if (status
                            .isGranted) {
                          if (context.mounted) {
                            context
                                .read<
                                AuditFormBloc>()
                                .add(
                                MultipleCameraEvent(indexValue));
                            context.pop();
                          }
                        } else if (status
                            .isPermanentlyDenied) {
                          if (context.mounted) {

                            showCustomCameraPermission(
                                context, "Allow access to camera");
                          }
                        } else if (status
                            .isRestricted) {}
                      }
                      if (Platform.isIOS) {
                        var status =
                        await Permission
                            .camera.status;
                        if (status.isDenied) {
                          if(context.mounted){
                            _requestCameraPermission(context);
                          }
                        } else if (status
                            .isLimited) {
                          if (context.mounted) {
                            context
                                .read<
                                AuditFormBloc>()
                                .add(
                               MultipleCameraEvent(indexValue));

                            context.pop();
                          }
                        } else if (status
                            .isGranted) {
                          if (context.mounted) {
                            context
                                .read<
                                AuditFormBloc>()
                                .add(
                               MultipleCameraEvent(indexValue));
                            context.pop();
                          }
                        } else if (status
                            .isPermanentlyDenied) {
                          if (context.mounted) {
                            showAlertDialogCameraPermission(
                                context, 'Allow access to camera');
                          }
                        } else if (status
                            .isRestricted) {}
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
        listener: (BuildContext context, state) {});
  }
  Future<bool> _requestPhotosPermission(BuildContext context) async {
    var status = await Permission.photos.request();
    if (status.isGranted) {
      if(context.mounted) {
        context.read<AuditFormBloc>().add( MultipleImageEvent(indexValue));
        context.pop();
      }
    }
    return status.isGranted;
  }

  Future<bool> _requestCameraPermission(BuildContext context) async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      if(context.mounted) {
        context.read<AuditFormBloc>().add( MultipleCameraEvent(indexValue));
        context.pop();
      }
    }
    return status.isGranted;
  }
}


void deleteImageConfirmSheet({
  required BuildContext context,
  required String imageId,
}) {
  final layoutBloc = context.read<AuditFormBloc>();
  showModalBottomSheet(
    enableDrag: true,
    isDismissible: true,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: ColorResource.colorWhite,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0),topRight:  Radius.circular(50.0)),
        side: BorderSide(width: 1.0,color: ColorResource.color003867)
    ),
    context: context,
    builder: (BuildContext context) {
      return  BlocProvider.value(
          value: layoutBloc, child: DeleteConfirmAlertsSheet(imageId: imageId));
    },
  );
}

class DeleteConfirmAlertsSheet extends StatelessWidget {
 final String? imageId;
  const DeleteConfirmAlertsSheet(
      {super.key, required this.imageId});

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    AppUtils.getDeviceType();
    return BlocConsumer<AuditFormBloc, AuditFormState>(builder: (context, state){
      return Wrap(
        children: [Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: AppUtils.getDeviceType()=="tablet"?50.0:50
              ),
              Center(
                child: SizedBox(
                  width:isPortrait==true? MediaQuery.of(context).size.width/1.5:MediaQuery.of(context).size.width/2.3,
                  child: Center(
                    child: CustomText(
                      "Are you sure to delete image?",
                      maxLines: 5,
                      style: GoogleFonts.inter( color: ColorResource.color1C1F26,
                        fontWeight: FontWeight.w500,
                        fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.twenty:FontSize1.twelve,),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height:AppUtils.getDeviceType()=="tablet"?50.0:30,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                    child: MaterialButton(onPressed: (){
                      context.pop();
                    },
                      minWidth: isPortrait==true?MediaQuery.of(context).size.width/3:MediaQuery.of(context).size.width/6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      height:AppUtils.getDeviceType()=="tablet"? 40:34,
                      color: ColorResource.color003867,
                      child:  CustomText(
                        StringResource.cancel,
                        style: GoogleFonts.inter(   color: ColorResource.colorWhite,
                          fontWeight: FontWeight.w400,
                          fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                    child: MaterialButton(onPressed: (){
                      context.read<AuditFormBloc>().add( DeleteAuditImage(imageId!));
                      context.pop();
                    },
                      minWidth: isPortrait==true?MediaQuery.of(context).size.width/3:MediaQuery.of(context).size.width/6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      height:AppUtils.getDeviceType()=="tablet"? 40:34,
                      color: ColorResource.colorWhite,
                      child:  CustomText(
                        StringResource.confirm,
                        style: GoogleFonts.inter(   color: ColorResource.color5A5C60,
                          fontWeight: FontWeight.w400,
                          fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height:AppUtils.getDeviceType()=="tablet"?50.0:30,
              ),

            ],
          ),
        )],
      );
    }, listener: (context, state){});
  }
}


void alertSheetAllField({
  required BuildContext context,
  required String message,
}) {
  final layoutBloc = context.read<AuditFormBloc>();
  showModalBottomSheet(
    enableDrag: true,
    isDismissible: true,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: ColorResource.colorWhite,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0),topRight:  Radius.circular(50.0)),
        side: BorderSide(width: 1.0,color: ColorResource.color003867)
    ),
    context: context,
    builder: (BuildContext context) {
      return  BlocProvider.value(
          value: layoutBloc, child: AlertSheetAllField(message: message));
    },
  );
}

//FINAL Alert
class AlertSheetAllField extends StatelessWidget {
 final String? message;
  const AlertSheetAllField(
      {super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    AppUtils.getDeviceType();
    return BlocConsumer<AuditFormBloc, AuditFormState>(builder: (context, state){
      return Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: AppUtils.getDeviceType()=="tablet"?50.0:50
                ),
                Center(
                  child: SizedBox(
                    width:isPortrait==true? MediaQuery.of(context).size.width/1.5:MediaQuery.of(context).size.width/2.3,
                    child: Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        message!,
                        maxLines: 5,
                        style: GoogleFonts.inter( color: ColorResource.color1C1F26,
                          fontWeight: FontWeight.w500,
                          fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.twenty:FontSize1.twelve,),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height: AppUtils.getDeviceType()=="tablet"?50.0:50
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                  child: MaterialButton(onPressed: (){

                    context.pop();
                  },
                    minWidth: isPortrait==true?MediaQuery.of(context).size.width/3:MediaQuery.of(context).size.width/6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height:AppUtils.getDeviceType()=="tablet"? 40:34,
                    color: ColorResource.colorWhite,
                    child:  CustomText(
                     "Ok",
                      style: GoogleFonts.inter(   color: ColorResource.color5A5C60,
                        fontWeight: FontWeight.w400,
                        fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ],
      );
    }, listener: (context, state){});
  }
}