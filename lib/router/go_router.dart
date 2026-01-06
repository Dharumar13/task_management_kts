import 'package:task_management_kts/router/router_names.dart';
import 'package:task_management_kts/screen/add_employee_task/bloc/add_layout_member_bloc.dart';
import 'package:task_management_kts/screen/add_task/screen/add_task_screen.dart';
import 'package:task_management_kts/screen/audit_form/bloc/audit_form_bloc.dart';
import 'package:task_management_kts/screen/audit_form/screen/audit_form_screen_first.dart';
import 'package:task_management_kts/screen/audit_form_webview/screen/audit_form_webview_screen.dart';
import 'package:task_management_kts/screen/change_password/bloc/change_password_bloc.dart';
import 'package:task_management_kts/screen/change_password/screen/change_password_screen.dart';
import 'package:task_management_kts/screen/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:task_management_kts/screen/edit_profile/screen/edit_profile_screen.dart';
import 'package:task_management_kts/screen/forgot_passowrd/bloc/forgot_bloc.dart';
import 'package:task_management_kts/screen/forgot_passowrd/screen/forgot_password_screen.dart';
import 'package:task_management_kts/screen/home/screen/home_screen.dart';
import 'package:task_management_kts/screen/job_board/bloc/job_board_bloc.dart';
import 'package:task_management_kts/screen/job_board/screen/job_board_screen.dart';
import 'package:task_management_kts/screen/login/screen/login_screen.dart';
import 'package:task_management_kts/screen/my_profile/bloc/my_profile_bloc.dart';
import 'package:task_management_kts/screen/my_profile/screen/my_profile_screen.dart';
import 'package:task_management_kts/screen/registration/bloc/registration_bloc.dart';
import 'package:task_management_kts/screen/registration/screen/registration_screen.dart';
import 'package:task_management_kts/screen/splash/bloc/splash_bloc.dart';
import 'package:task_management_kts/screen/splash/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../screen/add_employee_task/screen/add_task_employee_screen.dart';
import '../screen/add_task/bloc/layout_list_bloc.dart';
import '../screen/audit_form/model/audit_form_model.dart';
import '../screen/audit_form/screen/image_preview.dart';
import '../screen/home/bloc/home_bloc.dart';
import '../screen/layout_summary/bloc/layout_summary_bloc.dart';
import '../screen/layout_summary/screen/task_summary_screen.dart';
import '../screen/login/bloc/login_bloc.dart';
import '../screen/register_sucess_screen/register_complete_screen.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    name: RouterNames.splashRouter,
    path: "/",
    builder: (context, state) {
      return BlocProvider(
        create: (_) => SplashBloc(),
        child: const SplashScreen(),
      );
    },
  ),
  GoRoute(
    name: RouterNames.loginRouter,
    path: "/login_screen",
    builder: (context, state) {
      return BlocProvider(
        create: (_) => LoginBloc(),
        child: const LoginScreen(),
      );
    },
  ),
  GoRoute(
    name: RouterNames.registerRouter,
    path: "/register_screen",
    builder: (context, state) {
      return BlocProvider(
        create: (_) => RegistrationBloc(),
        child: const RegistrationScreen(),
      );
    },
  ),
  GoRoute(
    name: RouterNames.mainRouter,
    path: "/main_screen",
    builder: (context, state) {
      return BlocProvider(
        create: (_) => HomeBloc(),
        child: const HomeScreen(),
      );
    },
  ),
  GoRoute(
    name: RouterNames.jobBoardRouter,
    path: "/job_board_screen",
    builder: (context, state) {
      return BlocProvider(
        create: (_) => JobBoardBloc(),
        child: const JobBoardScreen(),
      );
    },
  ),

  GoRoute(
    name: RouterNames.myProfileScreenRouter,
    path:"/myProfile_screen",
    builder: (context, state) {
      return BlocProvider(
        create: (_) => MyProfileBloc(),
        child: const MyProfileScreen(),
      );
    },
  ),
  GoRoute(
    name: RouterNames.addTaskScreenRouter,
    path: "/addTask_screen",
    builder: (context, state) {
      return BlocProvider(
        create: (_) => LayoutListBloc(),
        child: AddTaskScreen(
            date: state.uri.queryParameters["date"], siteId:state.uri.queryParameters["siteId"]),
        );
    },
  ),
  GoRoute(
      name: RouterNames.addTaskEmployeeScreenRouter,
      path: "/addTaskEmployee_screen",
      builder: (context, state) {
        return BlocProvider(
          create: (_) => AddLayoutMemberBloc(),
          child: AddTaskEmployeeScreen(
              layoutId: state.uri.queryParameters["layout_id"], layoutName: state.uri.queryParameters["layout_name"]),
        );
      }),
  GoRoute(
    name: RouterNames.auditFormScreenRouter,
    path: "/auditForm_screen",
      builder: (context, state) {
        return BlocProvider(
          create: (_) => AuditFormBloc(),
          child: AuditFormScreen(
              layoutId: state.uri.queryParameters["layout_id"], date: state.uri.queryParameters["date"]),
        );
      }
   // builder: (context, state) => const AuditFormScreen(),
  ),
  GoRoute(
    name: RouterNames.auditFormWebViewScreen,
    path: "/audit_form_webview_screen",
    builder: (context, state) => AuditFormWebViewScreen(taskUrl: state.uri.queryParameters["task_url"]),
  ),
  GoRoute(
    name: RouterNames.forgotPasswordScreenRouter,
    path: "/forgotPassword_screen",
    builder: (context, state) {
      return BlocProvider(
        create: (_) => ForgotBloc(),
        child: const ForgotPasswordScreen(),
      );
    },
  ),

  GoRoute(
    name: RouterNames.changePasswordScreenRouter,
    path: "/changePassword_screen",
    builder: (context, state) {
      return BlocProvider(
        create: (_) => ChangePasswordBloc(),
        child: const ChangePasswordScreen(),
      );
    },
  ),
  GoRoute(
    name: RouterNames.editProfileScreenRouter,
    path: "/editProfile_screen",
    builder: (context, state) {
      return BlocProvider(
        create: (_) => EditProfileBloc(),
        child: const EditProfileScreen(),
      );
    },
  ),
  GoRoute(
    name: RouterNames.registerSuccessScreenRouter,
    path: "/register_success_screen",
    builder: (context, state) => const RegisterSuccessScreen(),
  ),
  GoRoute(
      name: RouterNames.layoutScreenRouter,
      path: "/layout_screen",
      builder: (context, state) {
        return BlocProvider(
          create: (_) => LayoutSummaryBloc(),
          child: TaskSummaryRootScreen(layoutDate:state.uri.queryParameters["layoutDate"], siteId:state.uri.queryParameters["siteId"],
              inLocation:state.uri.queryParameters["inLocation"])
        );
      }
    // builder: (context, state) => const AuditFormScreen(),
  ),

  GoRoute(
    name: RouterNames.imagePreviewScreen,
    path: "/image",
    builder: (context, state) {
      return BlocProvider(create:(_) =>AuditFormBloc(),
        child: ImagePreviewScreen(imageList:state.extra as Question,selectIndex:state.uri.queryParameters["index"]),);
    },
    // builder: (context, state) => PhotoPreviewScreen(title: state.uri.queryParameters["url"],imageList:state.extra as DatumImage,selectIndex:state.uri.queryParameters["index"]),
  ),
]);
