import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../common/locator/locator.dart';
import '../../common/router/router.gr.dart';
import '../../common/service/navigation_service.dart';
import '../Utils/Colors.dart';
import 'TextWidgets.dart';

class backButton extends StatelessWidget {
  const backButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: 100.w,
          padding: EdgeInsets.all(15),
          color: secondryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 14.sp,
              ),
              subheadingTextBOLD(title: "  Go Back")
            ],
          ),
        ));
  }
}

class backButtonloginScreen extends StatelessWidget {
  const backButtonloginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          locator<NavigationService>().push(const LoginScreenRoute());
        },
        child: Container(
          width: 100.w,
          padding: EdgeInsets.all(15),
          color: secondryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 14.sp,
              ),
              subheadingTextBOLD(title: "  Go Back")
            ],
          ),
        ));
  }
}
