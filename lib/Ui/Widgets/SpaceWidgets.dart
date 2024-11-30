import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class MediumSpace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.5.h,
    );
  }
}

class SmallSpace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.h,
    );
  }
}

class LargeSpace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 2.h,
    );
  }
}
