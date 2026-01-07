import 'package:task_management_kts/app_utility/color_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:task_management_kts/router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  checkPermissions();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]).then((_) {
    runApp(const MyApp());
  });

}
void checkPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.storage,
    Permission.photos,
    Permission.location,
  ].request();
  // perform custom action

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: ColorResource.color003867),
            useMaterial3:true ,
          ),
          routerConfig: router,
        );
      },
    );
  }
}






