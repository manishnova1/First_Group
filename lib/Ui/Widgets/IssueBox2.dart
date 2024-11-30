import 'package:flutter/material.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/car_parking_penality/main_car_paring_penality.dart';
import 'package:sizer/sizer.dart';
import '../Utils/Colors.dart';

class IssueBox2 extends StatelessWidget {
  IssueBox2({Key? key, required this.title, required this.icon})
      : super(key: key);

  String title;
  var icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
          color: blueGrey, borderRadius: BorderRadius.circular(5)),
      width: 100.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10.sp),
            textAlign: TextAlign.center,
          ),
          Icon(
            icon,
            color: Colors.white,
            size: 20.sp,
          ),
        ],
      ),
    );
  }
}
