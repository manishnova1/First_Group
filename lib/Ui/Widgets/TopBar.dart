import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:railpaytro/Ui/Widgets/LocationBar.dart';

import '../../data/constantes/constants.dart';
import '../Utils/Colors.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
    required this.deviceHeight,
    required this.deviceWidth,
  }) : super(key: key);

  final double deviceHeight;
  final double deviceWidth;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: OvalBottomBorderClipper(),
        child: Container(
            height: deviceHeight * 0.18,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 0, left: 10),
                    child: Image.asset(
                      logoURl,
                      color: secondryColor,
                      height: deviceHeight * 0.15,
                      width: deviceWidth * 0.3,
                    ),
                  ),
                  const LocationBar()
                ],
              ),
            )));
  }
}
