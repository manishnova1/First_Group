import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class AppUtils {
  Future<bool> getUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('user_logged_in') ?? false;
    return isLoggedIn;
  }
  Future<bool> getoffline() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool ShowEmail = prefs.getBool('offline_status') ?? false;
    return ShowEmail;
  }

  void setoffline(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('offline_status', status);
  }
  void setUserLoggedIn(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('user_logged_in', status);
  }

  void setUserSessionIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String sessionStarttime =
        DateFormat("d MMM yyyy  kk:mm").format(DateTime.now());
    prefs.setString('user_session_start', sessionStarttime);
  }

  void setPrinterId(String userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('printermac', userID);
  }

  getPrinterId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('printermac') ?? "";
  }

  ///
  setCaseCreatedCount(int case_created) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('case_created', case_created);
  }

  getCreatedCaseCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('case_created') ?? 0;
  }

  ///
  Future<bool> Getnotice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('notice') ?? false;
    return isLoggedIn;
  }

  void Setnotice(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notice', status);
  }

  ///
  getUserSessionIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('user_session_start') ?? "";
  }

  Future<bool> getOfflineDataStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool getOfflineDataStatus = prefs.getBool('is_offline_data_get') ?? false;
    return getOfflineDataStatus;
  }

  void setOfflineDataGet(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_offline_data_get', status);
  }

  void setLanguage(String selectedLanguage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selected_language', selectedLanguage);
  }

  Future<String> getSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String selectedLanguage = prefs.getString('selected_language') ?? "en";
    return selectedLanguage;
  }

  void setUserPassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_password', password);
  }

  getUserPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_password') ?? "";
  }

  Future<bool> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('user_logged_in', false);
    prefs.setString('user_token', '');
    prefs.setString('user_data', '');
    prefs.setString('userName', '');
    prefs.setString('barCode', '');
    prefs.setString('user_session_start', '');
    prefs.setString('user_password', '');

    prefs.setInt('user_id', 0);
    return true;
  }

  Future<String> createFileFromString(String base64Encoded) async {
    Uint8List bytes = base64.decode(base64Encoded);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File("$dir/${DateTime.now().millisecondsSinceEpoch}.PNG");
    await file.writeAsBytes(bytes);
    return file.path;
  }
}
