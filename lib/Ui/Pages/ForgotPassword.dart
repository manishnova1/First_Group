import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import '../../common/service/common_offline_status.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/DrawerLogout.dart';
import 'package:railpaytro/Ui/Widgets/PrimaryButton.dart';
import 'package:railpaytro/Ui/Widgets/SecondryButton.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/bloc/auth_bloc/forgot_pass_bloc.dart';
import 'package:railpaytro/common/router/router.gr.dart';
import 'package:sizer/sizer.dart';
import '../../common/locator/locator.dart';
import '../../common/service/navigation_service.dart';
import '../Utils/DeviceSize.dart';
import '../Utils/HelpfullMethods.dart';
import '../Utils/Utillities.dart';
import '../Widgets/SpaceWidgets.dart';
import '../Widgets/backButton.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String menu = "";
  TextEditingController emailCOnt = TextEditingController();
  final textFieldFocusNode = FocusNode();

  ///dialog
  openAlertDialog(BuildContext context) async {
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
                title: 'Password reset request',
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    subheadingText(
                        title:
                            "If an account was found matching the details entered you will receive an email with your 6-Digit Verification Code, please follow the instructions in the email to reset your password, you only have a limited time to complete this process."),
                    SizedBox(
                      height: 4.h,
                    ),
                    PrimaryButton(
                        title: "Proceed",
                        onAction: () {
                          Navigator.pop(context, true);
                        }),
                    SizedBox(
                      height: 4.h,
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context, false);
                          },
                          child: Icon(
                            Icons.clear,
                            color: primaryColor,
                          ),
                        )),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = getWidth(context);
    var deviceHeight = getHeight(context);
    return Scaffold(
      drawer: drawerLogout(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: [CommonOfflineStatusBar(isOfflineApiRequired: false)],
      ),
      backgroundColor: secondryColor,
      body: Container(
        width: 100.w,
        height: 100.h,
        decoration: gradientDecoration,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: deviceHeight * 0.81,
                padding: screenPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headingText(title: "Password reset"),
                        MediumSpace(),
                        subheadingText(
                            title:
                                "To reset your password, please enter the email address associated with your RailPay® account. You will then receive a 6-Digit Verification Code by email with which you will need to proceed.\nIf you can't access your email account or are unsure which email address to use, please contact your manager or IT department for assistance."),
                        LargeSpace(),
                        LargeSpace(),
                        boxtextBold(
                          title: "Email Address",
                        ),
                        SmallSpace(),
                        TextFormField(
                          controller: emailCOnt,
                          validator: (email) {
                            if (isEmail(email.toString())) {
                              return null;
                            } else {
                              return 'Enter a valid email address';
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                width: 2,
                                color: primaryColor,
                                style: BorderStyle.solid,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                width: 2,
                                color: primaryColor,
                                style: BorderStyle.solid,
                              ),
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.all(16),
                            fillColor: white,
                          ),
                        ),
                        LargeSpace(),
                        MediumSpace(),
                        LargeSpace(),
                        PrimaryButton(
                          onAction: () async {
                            FocusScope.of(context).unfocus();

                            if (emailCOnt.text.isEmpty) {
                              Dialogs.showValidationMessage(
                                  context, "Enter Email Address");
                            } else if (!emailCOnt.text.contains('@')) {
                              Dialogs.showValidationMessage(
                                  context, "Please enter valid email address");
                            } else {
                              var status = await openAlertDialog(context);
                              if (status) {
                                BlocProvider.of<ForgotPassBloc>(context).add(
                                    ForgotPassRefreshEvent(
                                        emailCOnt.text, context));
                              }
                            }
                          },
                          title: 'Send Verification Code',
                        ),
                        LargeSpace(),
                        SecondryButton(
                            title: "Already have your Verification Code",
                            onAction: () {
                              locator<NavigationService>()
                                  .push(VerifyOtpWidgetRoute(tag: ''));
                            }),
                      ],
                    ),
                  ],
                ),
              ),
              backButton()
            ],
          ),
        ),
      ),
    );
  }
}
