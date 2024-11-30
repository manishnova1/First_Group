import 'package:flutter/material.dart';

import '../Utils/Colors.dart';
import 'package:sizer/sizer.dart';

class ProgressBox extends StatelessWidget {
  ProgressBox({Key? key, required this.deviceWidth, required this.color})
      : super(key: key);

  final double deviceWidth;

  // ignore: prefer_typing_uninitialized_variables
  var color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 9.w,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
    );
  }
}
