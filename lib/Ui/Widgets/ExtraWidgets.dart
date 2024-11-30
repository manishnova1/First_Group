import 'package:flutter/cupertino.dart';

import '../Utils/Colors.dart';

class LineDivider extends StatelessWidget {
  LineDivider({
    required this.deviceWidth,
  });

  final double deviceWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth,
      height: 1,
      color: lightWhite,
    );
  }
}

var RoundBox = BoxDecoration(
  borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(40), topRight: Radius.circular(40)),
  color: secondryColor,
);
