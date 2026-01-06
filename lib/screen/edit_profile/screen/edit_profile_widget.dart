import 'package:task_management_kts/app_utility/app_util.dart';
import 'package:task_management_kts/app_utility/fonts.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../app_utility/color_resource.dart';
import '../../../widgets/custom_text.dart';
import '../../audit_form/screen/catch_network_image.dart';
import '../bloc/edit_profile_bloc.dart';
import '../bloc/edit_profile_state.dart';
import 'dart:io' show Platform;

Widget profileImage(BuildContext context) {
  return Stack(
    children: <Widget>[
      InkWell(
        onTap: () {

          _showPicker(context: context);
        },
        splashColor: ColorResource.color003867,
        child:context.read<EditProfileBloc>().imageFileList!.isEmpty?GalleryProfileCircle(
          photo: "${context.read<EditProfileBloc>().profileInformation?.data?.profilePic}",
        ):ClipRRect(
          borderRadius: BorderRadius.circular(75), // Half of the width or height to make it circular
          child: SizedBox(
            height:AppUtils.getDeviceType()=="tablet"? 122:105,
            width:AppUtils.getDeviceType()=="tablet"? 122:105,
            child: Image.file(
              context.read<EditProfileBloc>().imageFileList!.last,
              fit: BoxFit.cover,
            ),
          ),
        ),
      )

    ],
  );
}


void _showPicker({
  required BuildContext context,
}) {
  final examplecubit = context.read<EditProfileBloc>();
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return BlocProvider.value(
          value: examplecubit, child: const CustomDialog());
    },
  );
}



class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileBloc, EditProfileState>(
        builder: (context, state) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Photo Library'),
                  onTap: () async {
                    if (Platform.isAndroid) {
                      final androidInfo = await DeviceInfoPlugin().androidInfo;
                      if (androidInfo.version.sdkInt <= 32) {

                        if (context.mounted) {
                          context
                              .read<EditProfileBloc>()
                              .add(ImageUpdateEvent(ImageSource.gallery));
                          context.pop();
                        }
                      }  else {
                      var status = await Permission.photos.status;
                      if (status.isDenied) {
                      if(context.mounted) {
                        _requestPhotosPermission(context);
                      }
                      } else if (status
                          .isGranted) {
                        if (context.mounted) {
                          context
                              .read<EditProfileBloc>()
                              .add(ImageUpdateEvent(ImageSource.gallery));
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
                          .isRestricted) {
                      }
                    }
                   }
                    if (Platform.isIOS) {
                      var status =
                      await Permission
                          .photos.status;
                      if (status.isDenied) {
                        /*await Permission.photos
                            .request();*/
                        if(context.mounted) {
                          _requestPhotosPermission(context);
                        }
                      } else if (status
                          .isLimited) {

                       if(context.mounted){
                         context
                             .read<EditProfileBloc>()
                             .add(ImageUpdateEvent(ImageSource.gallery));
                         context.pop();
                       }

                      } else if (status
                          .isGranted) {
                        if (context.mounted) {
                          context
                              .read<EditProfileBloc>()
                              .add(ImageUpdateEvent(ImageSource.gallery));
                          context.pop();
                        }
                      } else if (status
                          .isPermanentlyDenied) {
                        if (context.mounted) {
                          showAlertDialogCameraPermission(context, 'Allow access to gallery and photos');
                        }
                      } else if (status
                          .isRestricted) {}}

                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () async {
                    if (Platform.isAndroid) {
                      var status = await Permission.camera.status;
                      if (status.isDenied) {
                       if(context.mounted){
                         _requestCameraPermission(context);
                       }
                      } else if (status.isGranted) {
                        if (context.mounted) {
                          context
                              .read<EditProfileBloc>()
                              .add(ImageUpdateEvent(ImageSource.camera));
                          context.pop();
                        }
                      } else if (status.isPermanentlyDenied) {
                        if (context.mounted) {

                          showCustomCameraPermission(
                              context, "Allow access to camera");
                        }
                      } else if (status.isRestricted) {}
                    } else if (Platform.isIOS) {
                      var status = await Permission.camera.status;
                      if (status.isDenied) {
                        if(context.mounted){
                          _requestCameraPermission(context);
                        }
                      } else if (status.isGranted) {
                        if (context.mounted) {
                          context
                              .read<EditProfileBloc>()
                              .add(ImageUpdateEvent(ImageSource.camera));
                          context.pop();
                        }
                      } else if (status.isPermanentlyDenied) {
                        if (context.mounted) {
                          showAlertDialogCameraPermission(
                              context, 'Allow access to camera');
                        }
                      } else if (status.isRestricted) {}
                    }
                  },
                ),
              ],
            ),
          );
        },
        listener: (BuildContext context, state) {});
  }
}
Future<bool> _requestPhotosPermission(BuildContext context) async {
  var status = await Permission.photos.request();
  if (status.isGranted) {
    if(context.mounted) {
      context.read<EditProfileBloc>().add(ImageUpdateEvent(ImageSource.gallery));
      context.pop();
    }
  }
  return status.isGranted;
}

Future<bool> _requestCameraPermission(BuildContext context) async {
  var status = await Permission.camera.request();
  if (status.isGranted) {
    if(context.mounted) {
      context.read<EditProfileBloc>().add(ImageUpdateEvent(ImageSource.camera));
      context.pop();
    }
  }
  return status.isGranted;
}


showAlertDialogCameraPermission(context, String msg) => showCupertinoDialog<void>(
  context: context,
  barrierDismissible: false,
  builder: (BuildContext context) => CupertinoAlertDialog(
    title: Center(
        child: CustomText(
          "Permission Denied",
          color: Colors.black,
          fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,
        )),
    content:
    Center(child: CustomText(msg, fontSize: 14, color: Colors.grey)),
    actions: <CupertinoDialogAction>[
      CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          child: CustomText(
            "Cancel",
            color: ColorResource.color003867,
            fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,
          )),
      CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => openAppSettings(),
          child: CustomText(
            "Settings",
            color: ColorResource.color003867,
            fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,
          )),
    ],
  ),
);

void showCustomCameraPermission(BuildContext context, String? data) {
  var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
  showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.5),
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
                       color: ColorResource.color003867,),
                    child: Center(
                        child: CustomText(
                          "Permission Denied",
                          color: ColorResource.colorWhite,
                          fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,
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
                          color: ColorResource.color003867,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MaterialButton(
                                onPressed: () {
                                  context.pop();
                                },
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                                elevation: 5.0,
                                height: 30,
                                minWidth: 50,
                                color: ColorResource.color003867,
                                child: CustomText(
                                  "Cancel",
                                  fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,
                                  fontWeight: FontWeight.normal,
                                  color: ColorResource.colorWhite,
                                )),
                            MaterialButton(
                                onPressed: () {
                                  openAppSettings();
                                  context.pop();
                                },
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                                elevation: 5.0,
                                height: 30,
                                minWidth: 50,
                                color: ColorResource.color003867,
                                child: CustomText(
                                  "Settings",
                                  fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,
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