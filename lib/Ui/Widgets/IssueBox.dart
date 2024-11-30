import 'package:flutter/material.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:sizer/sizer.dart';

import '../Utils/Colors.dart';

class IssueBox extends StatelessWidget {
  IssueBox({Key? key, required this.title, required this.icon})
      : super(key: key);

  String title;
  var icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(5)),
      width: 100.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          subheadingTextBOLD(title: title),
          Image.asset(
            icon,
            width: 21.sp,
          )
        ],
      ),
    );
  }
}
