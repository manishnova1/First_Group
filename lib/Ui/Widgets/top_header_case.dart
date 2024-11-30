import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

import '../Utils/Colors.dart';
import 'TextWidgets.dart';

class TopHeaderCase extends StatelessWidget {
  TopHeaderCase({Key? key, required this.title, required this.icon})
      : super(key: key);

  String title;
  String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkColor,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.5.h),
      width: 100.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          headingTextTwo(title: title),
          Image.asset(
            icon,
            width: 21.sp,
          )
        ],
      ),
    );
  }
}
class TopHeaderCasenoIcon extends StatelessWidget {
  TopHeaderCasenoIcon({Key? key,  required this.title}) : super(key: key);


  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color:darkColor,
      padding: EdgeInsets.symmetric(horizontal:6.w,vertical:2.5.h),
      width:100.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          headingTextTwo(title: title),

        ],
      ),
    );
  }


}