import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Widgets/LocationBar.dart';
import 'package:railpaytro/bloc/global_bloc.dart';
import '../../common/locator/locator.dart';
import '../../common/service/navigation_service.dart';
import '../../data/constantes/constants.dart';

class TopBarBack extends StatelessWidget {
  const TopBarBack({
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
            height: deviceHeight * 0.17,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            locator<NavigationService>().pop();
                          },
                          child: const Icon(Icons.arrow_back)),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 0),
                        child: Image.asset(
                          logoURl,
                          color: secondryColor,
                          height: deviceHeight * 0.15,
                          width: deviceWidth * 0.23,
                        ),
                      ),
                    ],
                  ),
                  const LocationBar()
                ],
              ),
            )));
  }
}
