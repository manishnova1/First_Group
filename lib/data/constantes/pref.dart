// ignore_for_file: constant_identifier_names

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREF_CASE_REFRENCE = 'caseRefLocal';

@lazySingleton
class Pref {
  // For one time login
  void setUserLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('user_logged_in', value);
  }

  Future<bool> getLoginValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user_logged_in')) {
      bool value = prefs.getBool('user_logged_in') ?? false;
      return value;
    } else {
      return false;
    }
  }

  // For one time case Refrence
  static setCaseRefLocal(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(PREF_CASE_REFRENCE, value);
  }

  static Future<bool> getCaseRefLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(PREF_CASE_REFRENCE)) {
      bool value = prefs.getBool(PREF_CASE_REFRENCE) ?? false;
      return value;
    } else {
      return false;
    }
  }
}
