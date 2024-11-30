import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/PrimaryButton.dart';
import 'package:railpaytro/Ui/Widgets/SecondryButton.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/bloc/auth_bloc/verify_otp_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../common/service/common_offline_status.dart';
import '../Utils/Utillities.dart';
import '../Widgets/DrawerLogout.dart';
import '../Widgets/SpaceWidgets.dart';

class VerifyOtpWidget extends StatefulWidget {
  final String tag;

  const VerifyOtpWidget({Key? key, required this.tag}) : super(key: key);

  @override
  _VerifyOtpWidgetState createState() => _VerifyOtpWidgetState();
}

class _VerifyOtpWidgetState extends State<VerifyOtpWidget> {
  String menu = "";
  TextEditingController otpController = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  final textFieldFocusNode = FocusNode();
  StreamController<ErrorAnimationType>? errorController;

  @override
  Widget build(BuildContext context) {
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
                height: 80.h,
                padding: screenPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headingText(
                          title: "Password reset",
                        ),
                        MediumSpace(),
                        subheadingTextBOLD(
                          title: "6-Digit Verification Code",
                        ),
                        LargeSpace(),
                        // boxtextBold(title: "Email"),
                        // SmallSpace(),
                        // TextFormField(
                        //   controller: emailCont,
                        //   validator: (val) {
                        //     if (val != null && val.isNotEmpty) {
                        //       return null;
                        //     } else {
                        //       return 'Enter a valid Email Address ';
                        //     }
                        //   },
                        //   keyboardType: TextInputType.text,
                        //   decoration: InputDecoration(
                        //     hintText: 'Email',
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(5),
                        //       borderSide: const BorderSide(
                        //         width: 0,
                        //         style: BorderStyle.none,
                        //       ),
                        //     ),
                        //     filled: true,
                        //     contentPadding: const EdgeInsets.all(16),
                        //     fillColor: white,
                        //   ),
                        // ),
                        // MediumSpace(),
                        // boxtextBold(title: "One Time Passcode"),
                        SmallSpace(),

                        PinCodeTextField(
                          controller: otpController,
                          appContext: context,
                          length: 6,
                          animationType: AnimationType.fade,
                          validator: (v) {},
                          textStyle: TextStyle(color: Colors.white),
                          pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: Color(0xff012840),
                              inactiveFillColor: Color(0xff012840),
                              selectedColor: Colors.white,
                              activeColor: primaryColor,
                              selectedFillColor: Color(0xff012840),
                              inactiveColor: Colors.white),
                          cursorColor: Colors.white,
                          animationDuration: Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          keyboardType: TextInputType.number,
                          boxShadows: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          onCompleted: (v) {
                            print("Completed");
                          },
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              // pinn = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        ),
                        LargeSpace(),
                        LargeSpace(),
                        PrimaryButton(
                          onAction: () {
                            if (otpController.text.isEmpty) {
                              Dialogs.showValidationMessage(
                                  context, "Enter One Time Passcode");
                            } else if (otpController.text.length != 6) {
                              Dialogs.showValidationMessage(context,
                                  "Invalid One Time Passcode - Please check and try again");
                            } else {
                              BlocProvider.of<VerifyOtpBloc>(context).add(
                                  VerifyOtpRefreshEvent(
                                      email: emailCont.text,
                                      otp: otpController.text,
                                      context: context));
                            }
                          },
                          title: 'Proceed',
                        ),
                        LargeSpace(),
                        SecondryButton(
                            title: "Cancel",
                            onAction: () {
                              Navigator.pop(context);
                            })
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
