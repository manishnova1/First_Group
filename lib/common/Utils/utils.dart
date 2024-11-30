import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Ui/Utils/Colors.dart';
import '../locator/locator.dart';
import '../router/router.gr.dart';
import '../service/navigation_service.dart';

class Utils {
  static Future openLink({required String url}) => _launchUrl(url);

  static Future _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch : $url';
    }
  }

  //Toast Util
  static showToast(String msg, {Color? color}) {
    Fluttertoast.showToast(msg: msg, backgroundColor: color ?? Colors.black);
  }

  errorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Vehicle Registration Not Recognised",
            style: TextStyle(fontSize: 13.sp),
          ),
          content: Text(
              "Please check the vehicle registration number and re-enter if needed, else please enter the Make /Model and Color manually.",
              style: TextStyle(fontSize: 11.sp)),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Ok",
                    style: TextStyle(fontSize: 13.sp, color: primaryColor))),
          ],
        );
        ;
      },
    );
  }

  static ageDialogMg11(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Age Restrictions",
            style: TextStyle(fontSize: 13.sp),
          ),
          content: Text(
              "The details entered for the customer suggest they are below the minimum age for this type of notice to be issued. Please either cancel this notice or adjust the Date of Birth",
              style: TextStyle(fontSize: 11.sp)),
          actions: [
            TextButton(
                onPressed: () {
                  locator<NavigationService>().pushAndRemoveUntil(
                      UnPaidFareIssueMainRoute(isOfflineApiRequired: false));
                },
                child: Text("Cancel",
                    style: TextStyle(fontSize: 13.sp, color: primaryColor))),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Change DOB",
                    style: TextStyle(fontSize: 13.sp, color: primaryColor))),
          ],
        );
        ;
      },
    );
  }

  static Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
