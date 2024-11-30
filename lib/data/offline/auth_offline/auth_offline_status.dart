import 'package:shared_preferences/shared_preferences.dart';

class AuthOfflineStatus {
  static const offlineCms = 'offlineCms';
  static const offlineSplash = 'offlineSplash';

  //Cms Variables
  void setCmsVarOfflineStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(offlineCms, value);
  }

  Future<bool> getCmsVarOfflineStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(offlineCms)) {
      bool? value = prefs.getBool(offlineCms);
      return value!;
    } else {
      return false;
    }
  }

  //Splash Variables
  void setSplashStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(offlineSplash, value);
  }

  Future<bool> getSplashStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(offlineSplash)) {
      bool? value = prefs.getBool(offlineSplash);
      return value!;
    } else {
      return false;
    }
  }
}
