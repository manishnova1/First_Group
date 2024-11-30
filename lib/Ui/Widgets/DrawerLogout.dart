import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';

import '../../common/Utils/utils.dart';
import '../../common/locator/locator.dart';
import '../../common/router/router.gr.dart';
import '../../common/service/navigation_service.dart';
import '../../data/constantes/constants.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/auth/login_model.dart';
import '../Utils/Colors.dart';
import 'Dialogtextbox2.dart';
import 'PrimaryButton.dart';
import 'SecondryButton.dart';
import 'TextWidgets.dart';

class drawerLogout extends StatelessWidget {
  const drawerLogout({
    Key? key,
  }) : super(key: key);

  openAppInfoDialog(BuildContext context) async {
    bool checkInternet = await Utils.checkInternet();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;

    LoginModel user = await SqliteDB.instance.getLoginModelData();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                side: BorderSide(color: primaryColor, width: 2)),
            backgroundColor: blackColor,
            insetPadding: EdgeInsets.all(20),
            actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
            title: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Text(
                    "App Information",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15.sp,
                        color: Colors.white),
                  ),
                )),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DialogTextbox2(title: "User:", subtitle: "Not Logged In"),
                    DialogTextbox2(title: "App Version:", subtitle: "$version"),
                    DialogTextbox2(
                        title: "Current Status:",
                        subtitle: checkInternet ? "Online" : "Offline"),
                    // DialogTextbox2(
                    //     title: "Last Checked for Updates:", subtitle: "N/A"),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                              title: "Close",
                              onAction: () {
                                Navigator.pop(context, true);
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: blueGrey,
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 6.h,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: 2.h,
                  ),
                  ListTile(
                    title: subheadingTextBOLD(title: "Forgot Password"),
                    onTap: () {
                      locator<NavigationService>()
                          .push(const ForgotPasswordRoute());
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  Divider(
                    color: secondryColor,
                  )
                ],
              ),
              Column(
                children: [
                  Divider(
                    color: secondryColor,
                  ),
                  ListTile(
                    title: subheadingTextBOLD(title: "App Information"),
                    onTap: () {
                      openAppInfoDialog(context);
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  Divider(
                    color: secondryColor,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  boxtextSmall(title: "Powered By:"),
                  SizedBox(
                    height: 1.h,
                  ),
                  Image.asset(
                    logoURl,
                    color: Colors.white,
                    height: 2.5.h,
                    width: 100.h,
                    fit: BoxFit.scaleDown,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  boxtextSmall(title: "® Tracsis plc"),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              )
            ],
          )),
    );
  }
}
