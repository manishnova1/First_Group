import 'package:flutter/material.dart';

import '../../common/locator/locator.dart';
import '../../common/service/navigation_service.dart';
import '../Utils/Colors.dart';

class CrossButton extends StatelessWidget {
  const CrossButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        locator<NavigationService>().pop();
      },
      child: Container(
          decoration:
              BoxDecoration(color: primaryColor, shape: BoxShape.circle),
          child: const Padding(
            padding: EdgeInsets.all(2.0),
            child: Icon(
              Icons.clear,
              color: Colors.white,
            ),
          )),
    );
  }
}
