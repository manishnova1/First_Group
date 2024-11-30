import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Utils/Colors.dart';

class DividerShadow extends StatelessWidget {
  const DividerShadow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: .5,
      decoration: BoxDecoration(
        color: blueGrey,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: .5,
            blurRadius: .5,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
