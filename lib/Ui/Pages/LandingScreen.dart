import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Widgets/PrimaryButton.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:sizer/sizer.dart';
import '../../common/locator/locator.dart';
import '../../common/router/router.gr.dart';
import '../../common/service/navigation_service.dart';
import '../../data/constantes/constants.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondryColor,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                secondryColor,
                Color(0xff010326),
              ],
            )),
            child: Column(
              children: [],
            ),
          ),
          Positioned(
              bottom: 50.h,
              left: 10,
              right: 10,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Container(
                    width: 100.w,
                    child: Text(
                      "Intelligence Reporting and Revenue Protection Suite",
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
              )),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
                clipper: OvalTopBorderClipper(),
                child: Container(
                    color: secondryColor,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 7.h,
                        ),
                        Container(
                            width: 90.w,
                            child: PrimaryButton(
                                title: "LOGIN",
                                onAction: () async {
                                  locator<NavigationService>()
                                      .popAndPush(const LoginScreenRoute());
                                })),
                        SizedBox(
                          height: 4.h,
                        ),
                        subheadingText(title: "Powered By:"),
                        SizedBox(
                          height: 1.h,
                        ),
                        Image.asset(
                          logoURl,
                          color: Colors.white,
                          height: 3.h,
                          width: 100.h,
                          fit: BoxFit.scaleDown,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                      ],
                    ))),
          ),
        ],
      ),
    );
  }
}
