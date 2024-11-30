import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/Colors.dart';

class navigationBar extends StatelessWidget {
  navigationBar({Key? key, required this.deviceWidth, required this.title})
      : super(key: key);

  final double deviceWidth;
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: primaryColor,
      width: deviceWidth,
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 17,
          ),
          Text(" $title",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600))
        ],
      ),
    );
  }
}
