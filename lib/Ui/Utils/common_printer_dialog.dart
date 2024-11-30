import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart' as colorMain;
import '../../bloc/printer_bloc/printer_bloc.dart';
import '../../constants/colors.dart';
import '../Pages/PrinterSetting/PrinterSettings.dart';
import '../Widgets/PrimaryButton.dart';
import '../Widgets/whiteButton.dart';
import 'Colors.dart';

class CommonPrinterDialog {
  showPrinterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              side: BorderSide(color: colorMain.primaryColor, width: 2)),
          backgroundColor: blackColor,
          title: Text(
            "Printer not connected",
            style: TextStyle(fontSize: 13.sp, color: Colors.white),
          ),
          content: Text("Before you can print, you must connect a printer.",
              style: TextStyle(fontSize: 11.sp, color: Colors.white)),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel",
                        style: TextStyle(
                            fontSize: 13.sp, color: colorMain.primaryColor))),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PrinterSetting()));
                    },
                    child: Text("Pair a Printer",
                        style: TextStyle(
                            fontSize: 13.sp, color: colorMain.primaryColor))),
              ],
            )
          ],
        );
      },
    );
  }

  showPrinterStatusDialog(BuildContext context, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              side: BorderSide(color: colorMain.primaryColor, width: 2)),
          backgroundColor: blackColor,
          title: Text(
            "Printer Error",
            style: TextStyle(fontSize: 13.sp, color: Colors.white),
          ),
          content: Text(
              content == 'Printer Media Open'
                  ? 'Please check that the printer cover is closed properly before proceeding.'
                  : content == 'Printer Media Out'
                      ? 'The printer may be out of paper. Please check before proceeding.'
                      : 'There is a problem with the printer. Please check it is switched on and correctly set up before proceeding.\nIf the problem persists, contact support.',
              style: TextStyle(fontSize: 11.sp, color: Colors.white)),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel",
                    style: TextStyle(
                        fontSize: 13.sp, color: colorMain.primaryColor))),
          ],
        );
      },
    );
  }

  cancelPrinterDialog(BuildContext context,
      {required void Function() onPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              side: BorderSide(color: colorMain.primaryColor, width: 2)),
          backgroundColor: blackColor,
          title: Text(
            "Printing failed, Please check printer settings and try again.",
            style: TextStyle(fontSize: 13.sp, color: Colors.white),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                            title: "Cancel",
                            onAction: () {
                              Navigator.pop(context, true);
                            }),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: whiteButton(
                            title: "Try Again", onAction: onPressed),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  startPrintingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              side: BorderSide(color: colorMain.primaryColor, width: 2)),
          backgroundColor: blackColor,
          title: Text(
            "Printing in progress",
            style: TextStyle(fontSize: 13.sp, color: Colors.white),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel",
                    style: TextStyle(
                        fontSize: 13.sp, color: colorMain.primaryColor))),
          ],
        );
      },
    );
  }
}
