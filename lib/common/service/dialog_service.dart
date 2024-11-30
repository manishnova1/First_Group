import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:injectable/injectable.dart';
import 'package:ndialog/ndialog.dart';
import 'package:sizer/sizer.dart';
import '../../Ui/Utils/Colors.dart';
import '../../Ui/Widgets/PrimaryButton.dart';
import '../../Ui/Widgets/SecondryButton.dart';
import '../../Ui/Widgets/TextWidgets.dart';
import '../../Ui/Widgets/app_progress_indicator.dart';
import '../router/router.gr.dart';

@lazySingleton
class DialogService {
  final AppRouter _router;

  DialogService(this._router);

  ProgressDialog? _pr;
  CustomProgressDialog? _cpr;

  BuildContext _getSafeContext() {
    final context = _router.navigatorKey.currentContext;
    return context != null
        ? context
        : throw ('Have you forgot to setup routes?');
  }

  void successCustom(
      {BuildContext? context,
      String? msg,
      String? title,
      required Function() onTap}) {
    AwesomeDialog(
      dialogBackgroundColor: blackColor,
      btnOkColor: primaryColor,
      context: context!,
      width: 400,
      borderSide: BorderSide(
        color: primaryColor,
        width: 2,
      ),
      dialogType: DialogType.NO_HEADER,
      animType: AnimType.BOTTOMSLIDE,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      body: Column(
        children: [
          Text(
            title ?? "",
            style: Theme.of(context)
                .primaryTextTheme
                .headline1!
                .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(msg ?? "",
              style: Theme.of(context)
                  .primaryTextTheme
                  .headline1!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center),
        ],
      ),
      btnOkOnPress: onTap,
    ).show();
  }

  //
  void backConfirmCustom(
      {BuildContext? context,
      String? msg,
      String? warning,
      VoidCallback? btnOkOnPress}) {
    AwesomeDialog(
      context: context!,
      width: 400,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: warning,

      // desc: msg,
      body: Column(
        children: [
          Text(
            warning ?? "",
            style: Theme.of(context)
                .primaryTextTheme
                .headline1!
                .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            msg ?? "",
            style: Theme.of(context)
                .primaryTextTheme
                .headline1!
                .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      btnOkOnPress: btnOkOnPress,
      btnCancelOnPress: () {},
    ).show();
  }

  void customError(
      {BuildContext? context, String? msg, VoidCallback? btnOkOnPress}) {
    AwesomeDialog(
      btnOkColor: Colors.grey,
      context: context!,
      width: 400,
      animType: AnimType.SCALE,
      dialogType: DialogType.WARNING,
      body: Center(
        child: Text(
          msg!,
          style: TextStyle(
            color: Theme.of(context).disabledColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      // title: 'This is Ignored',
      // desc:   'This is also Ignored',
      btnOkOnPress: btnOkOnPress ?? () {},
    ).show();
  }
  void showLoaderwithHide({String? message, bool dismissable = true}) {
    // hide loader if shown previously
    hideLoader();

    if (message == null) {
      _cpr = CustomProgressDialog(
        _getSafeContext(),
        loadingWidget: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: primaryColor, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: blackColor,
            shape: BoxShape.rectangle,
          ),
          child: AppProgressIndicator(),
        ),
        dismissable: dismissable,
      );
    } else {
      _cpr = CustomProgressDialog(
        _getSafeContext(),
        loadingWidget: Container(
          height: 17.h,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: primaryColor, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: blackColor,
            shape: BoxShape.rectangle,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppProgressIndicator(),
                SizedBox(height: 2.h),
                Text(
                  message,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        dismissable: dismissable,
      );
    }

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _cpr!.show();
      Timer(const Duration(seconds: 15), () {
        hideLoader();
      });

    });
  }
  void showLoader({String? message, bool? dismissable}) {
    // hide loader if shown previously
    hideLoader();
    if (message == null) {
      _cpr = CustomProgressDialog(_getSafeContext(),
          loadingWidget: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor, width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                color: blackColor,
                shape: BoxShape.rectangle,
              ),
              child: AppProgressIndicator()),
          dismissable: dismissable ?? true);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _cpr!.show();
      });
    } else {
      _cpr = CustomProgressDialog(_getSafeContext(),
          loadingWidget: Container(
              height: 17.h,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor, width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                color: blackColor,
                shape: BoxShape.rectangle,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppProgressIndicator(),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      message,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )),
          dismissable: dismissable ?? true);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _cpr!.show();
      });
    }
  }

  void hideLoader() {
    if (_pr?.isShowed ?? false) {
      _pr?.dismiss();
    }
    if (_cpr?.isShowed ?? false) {
      _cpr?.dismiss();
    }
  }

  commonAlertDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                side: BorderSide(color: primaryColor, width: 2)),
            backgroundColor: blackColor,
            actionsPadding: const EdgeInsets.symmetric(horizontal: 20),
            title: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: headingText(
                title: 'Success',
              ),
            ),
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  subheadingText(title: "Uploaded Successfully"),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PrimaryButton(
                          title: "OK",
                          onAction: () {
                            Navigator.pop(context);
                          }),
                    ),
                  )
                ],
              )
            ],
          );
        });
  }

  OfflineSuccessAlertDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                side: BorderSide(color: primaryColor, width: 2)),
            backgroundColor: blackColor,
            actionsPadding: const EdgeInsets.symmetric(horizontal: 20),
            title: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: headingText(
                title: 'Success',
              ),
            ),
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  subheadingText(title: "Case Details Added Successfully"),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PrimaryButton(
                          title: "OK",
                          onAction: () {
                            Navigator.pop(context);
                          }),
                    ),
                  )
                ],
              )
            ],
          );
        });
  }

  commonSuccessDialog(BuildContext context,
      {VoidCallback? continueAction, VoidCallback? rePrintAction}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                side: BorderSide(color: primaryColor, width: 2)),
            backgroundColor: blackColor,
            insetPadding: EdgeInsets.all(20),
            actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: headingText(
                    title: 'Print Successful',
                  ),
                )),
                Image.asset(
                  "Assets/icons/success.png",
                  width: 10.w,
                  fit: BoxFit.cover,
                )
              ],
            ),
            content: Text(
              'Please check the print was successful before proceeding',
              style: TextStyle(color: Colors.white),
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
                          child: SecondryButton(
                              title: "Reprint", onAction: rePrintAction),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                              title: "Continue", onAction: continueAction),
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
        });
  }
}
