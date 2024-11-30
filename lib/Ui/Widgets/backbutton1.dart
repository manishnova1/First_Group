import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Utils/Colors.dart';
import 'TextWidgets.dart';

class backButtondark extends StatelessWidget {
  const backButtondark({
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
          color: darkColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 14.sp,
              ),
              subheadingTextBOLD(title: "  Go Back to Main Menu")
            ],
          ),
        ));
  }
}
