import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:railpaytro/Ui/Widgets/LocationBar.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import '../../bloc/printer_bloc/printer_bloc.dart';
import '../../common/locator/locator.dart';
import '../../common/service/navigation_service.dart';
import '../../data/constantes/constants.dart';
import '../Pages/PrinterSetting/PrinterSettings.dart';
import '../Utils/Colors.dart';
import 'package:sizer/sizer.dart';

class TopBarwithTitle extends StatelessWidget {
  TopBarwithTitle({Key? key, required this.title, this.isPrinterVisible})
      : super(key: key);

  bool? isPrinterVisible = false;
  String title;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: OvalBottomBorderClipper(),
        child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 10.0, top: 4.5.h, right: 10, bottom: 4.h),
              child: Column(
                children: [
                  SizedBox(
                    height: 8.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () => locator<NavigationService>().pop(),
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 18.sp,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 0),
                              child: Image.asset(
                                logoURl,
                                color: secondryColor,
                                width: 25.w,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const LocationBar(),
                            const SizedBox(
                              width: 10.0,
                            ),
                            if (isPrinterVisible ?? false)
                              BlocBuilder<PrinterBloc, PrinterState>(
                                builder: (context, state) {
                                  if (state is PrinterStatusUpdateState) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const PrinterSetting()));
                                      },
                                      child: Row(
                                        children: const [
                                          Icon(Icons.print,
                                              color: Colors.lightGreen),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Printer',
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const PrinterSetting()));
                                      },
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.print,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Printer',
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  superheadingText(title: title),
                ],
              ),
            )));
  }
}
