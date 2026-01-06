import 'package:shared_preferences/shared_preferences.dart';

import 'constant.dart';


class PreferenceHelper {

  static setLoginStatus(bool? isLogin) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isLogin is bool) {
      await prefs.setBool(SharedPrefKeys.isLogin, isLogin);
    }
  }

  static setUserId(String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is String) {
      await prefs.setString(SharedPrefKeys.userId, value);
    }
  }
  static setPrivacyStatus(bool? value) async {
    final SharedPreferences prefsLogin = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefsLogin.setBool(SharedPrefKeys.privacyStatus, value);
    }
  }
  static Future<bool> getPrivacyStatus() async {
    final SharedPreferences prefsPass = await SharedPreferences.getInstance();
    return prefsPass.getBool(SharedPrefKeys.privacyStatus) ?? false;
  }
  static Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefKeys.userId) ?? '';
  }
  static setUserImage(String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is String) {
      await prefs.setString(SharedPrefKeys.image, value);
    }
  }

  static Future<String> getUserImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefKeys.image) ?? '';
  }


  static setToken(String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is String) {
      await prefs.setString(SharedPrefKeys.userToken, value);
    }
  }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefKeys.userToken) ?? '';
  }
  static setUserType(String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is String) {
      await prefs.setString(SharedPrefKeys.userRole, value);
    }
  }

  static Future<String> getUserType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefKeys.userRole) ?? '';
  }

  static setUserName(String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is String) {
      await prefs.setString(SharedPrefKeys.userName, value);
    }
  }

  static setGreetings(String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is String) {
      await prefs.setString(SharedPrefKeys.greeting, value);
    }
  }
  static Future<String> getGreetings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefKeys.greeting) ?? '';
  }


  static Future<String> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefKeys.userName) ?? '';
  }

  static setLastName(String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is String) {
      await prefs.setString(SharedPrefKeys.lastName, value);
    }
  }

  static Future<String> getLastName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefKeys.lastName) ?? '';
  }

  static setEmailId(String? value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is String) {
      await prefs.setString(SharedPrefKeys.emailId, value);
    }
  }

  static Future<String> getEmailId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefKeys.emailId) ?? '';
  }


  static setLoginId(String? value) async {
    final SharedPreferences prefsLogin = await SharedPreferences.getInstance();
    if (value is String) {
      await prefsLogin.setString(SharedPrefKeys.loginID, value);
    }
  }

  static Future<String> getLoginId() async {
    final SharedPreferences prefsLogin = await SharedPreferences.getInstance();
    return prefsLogin.getString(SharedPrefKeys.loginID) ?? '';
  }


  static setPassword(String? value) async {
    final SharedPreferences prefsLogin = await SharedPreferences.getInstance();
    if (value is String) {
      await prefsLogin.setString(SharedPrefKeys.password, value);
    }
  }

  static Future<String> getPassword() async {
    final SharedPreferences prefsLogin = await SharedPreferences.getInstance();
    return prefsLogin.getString(SharedPrefKeys.password) ?? '';
  }

  static Future<bool> getLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPrefKeys.isLogin) ?? false;
  }




}

clearPreference() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
