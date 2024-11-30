import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import 'TextWidgets.dart';

class summaryBox extends StatelessWidget {
  summaryBox({required this.title, required this.value});

  String title;
  String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 40.w,
          child: boxtextMediumBold(title: title),
        ),
        Container(
          width: 45.w,
          child: boxtextMedium(
            title: value,
          ),
        ),
      ],
    );
  }
}
