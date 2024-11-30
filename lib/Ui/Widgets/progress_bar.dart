import 'package:flutter/material.dart';

import '../Utils/Colors.dart';
import 'package:sizer/sizer.dart';

class ProgressBar extends StatelessWidget {
  ProgressBar({Key? key, required this.deviceWidth, required this.color})
      : super(key: key);

  final double deviceWidth;

  // ignore: prefer_typing_uninitialized_variables
  var color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: .5.h,
      width: deviceWidth,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(1), color: color),
    );
  }
}

class ProgressBarThin extends StatelessWidget {
  ProgressBarThin({Key? key, required this.deviceWidth, required this.color})
      : super(key: key);

  final double deviceWidth;

  // ignore: prefer_typing_uninitialized_variables
  var color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: .3.h,
      width: deviceWidth,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(1), color: color),
    );
  }
}
