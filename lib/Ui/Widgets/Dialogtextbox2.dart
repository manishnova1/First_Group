import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:sizer/sizer.dart';

class DialogTextbox2 extends StatelessWidget {
  DialogTextbox2({required this.title, required this.subtitle});

  var title;
  var subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontFamily: "railBold"),
            ),
            Text(subtitle,
                style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white60,
                    fontFamily: "railLight"))
          ],
        ),
        Divider(
          color: blueGrey,
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
