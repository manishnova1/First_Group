import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../Utils/DeviceSize.dart';

class ServiceListItemWidget extends StatelessWidget {
  final String? startLocation;
  final String? endLocation;
  final String? trainidenity;
  final String? serviceid;
  final dynamic time;
  final String? toc;

  const ServiceListItemWidget(
      {Key? key,
      required this.startLocation,
      required this.endLocation,
      required this.trainidenity,
      required this.serviceid,
      this.time,
      required this.toc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceWidth = getWidth(context);
    var deviceHeight = getHeight(context);

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: Image.asset(
              "Assets/toclogo$toc.png",
              height: 6.h,
              fit: BoxFit.cover,
            )),
        minLeadingWidth: 4,
        title: Text(
          "$startLocation - $endLocation",
          style: TextStyle(fontSize: 12.sp, color: Colors.black),
        ),
        trailing: Text(getTime(time),
            style: TextStyle(
                fontSize: 11.sp,
                color: Colors.black87,
                fontWeight: FontWeight.bold)),
        subtitle: Text("Head Code -$trainidenity  Train Uid- $serviceid",
            style: TextStyle(fontSize: 9.sp, color: Colors.black54)),
      ),
    );
  }

  getTime(time) {
    DateTime date = DateTime.parse(time);
    var timeShort =
        "${date.hour.toString().padLeft(2, "0")} : ${date.minute.toString().padLeft(2, "0")}";

    return timeShort;
  }
}
