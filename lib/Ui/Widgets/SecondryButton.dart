import 'package:flutter/material.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:sizer/sizer.dart';

class SecondryButton extends StatelessWidget {
  SecondryButton({required this.title, required this.onAction});

  String title;
  var onAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.h,
      width: 100.w,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: blueGrey),
        onPressed: onAction,
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "railLight"),
        ),
      ),
    );
  }
}
