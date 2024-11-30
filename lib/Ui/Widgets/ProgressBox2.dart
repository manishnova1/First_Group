import 'package:flutter/material.dart';

class ProgressBox2 extends StatelessWidget {
  ProgressBox2({Key? key, required this.deviceWidth, required this.color})
      : super(key: key);

  final double deviceWidth;
  var color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: deviceWidth * 0.07,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
    );
  }
}
