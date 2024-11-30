import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:sizer/sizer.dart';
import '../../../../bloc/ufn_luno_bloc/submit_form_bloc.dart';
import '../../../../common/locator/locator.dart';
import '../../../../common/service/common_offline_status.dart';
import '../../../../common/service/toast_service.dart';
import '../../../Utils/DeviceSize.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/SpaceWidgets.dart';
import '../../../Widgets/progress_bar.dart';
import '../../../Widgets/top_header_case.dart';

class zeroFareTicketInformation extends StatefulWidget {
  @override
  _zeroFareTicketInformationState createState() =>
      _zeroFareTicketInformationState();
}

class _zeroFareTicketInformationState extends State<zeroFareTicketInformation> {
  String verificationType = "";
  bool zeroFareIssued = false;

  TextEditingController ticketNumber = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  @override
  Widget build(BuildContext context) {
    var deviceWidth = getWidth(context);
    var deviceHeight = getHeight(context);
    return Scaffold(
      drawer: const DrawerWidget(),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(15),
                width: 50.w,
                height: 6.8.h,
                color: secondryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 14.sp,
                    ),
                    subheadingTextBOLD(title: " Go Back")
                  ],
                ),
              )),
          InkWell(
            onTap: () {
              if (zeroFareIssued && ticketNumber.text.length != 5) {
                locator<ToastService>().showValidationMessage(
                    context, "Please enter a valid 5 digit ticket number");
              } else if (zeroFareIssued && ticketNumber.text.length == 5) {
                BlocProvider.of<SubmitFormBloc>(context).add(
                  ZeroFareIssuedEvent(
                      context: context, ticketNumber: ticketNumber.text),
                );
              } else {
                BlocProvider.of<SubmitFormBloc>(context).add(
                  ZeroFareIssuedEvent(
                      context: context, ticketNumber: ticketNumber.text),
                );
              }
            },
            child: Container(
              padding: EdgeInsets.all(15),
              width: 50.w,
              height: 6.8.h,
              color: primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  subheadingTextBOLD(title: "Continue "),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 14.sp,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: [CommonOfflineStatusBar(isOfflineApiRequired: false)],
      ),
      backgroundColor: secondryColor,
      body: Stack(
        children: [
          Container(
            width: 100.w,
            height: 100.h,
            decoration: gradientDecoration,
            child: Padding(
              padding: screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 7.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProgressBar(
                            deviceWidth: 10.w,
                            color: primaryColor.withOpacity(.5)),
                        ProgressBar(
                            deviceWidth: 10.w,
                            color: primaryColor.withOpacity(.5)),
                        ProgressBar(
                            deviceWidth: 10.w,
                            color: primaryColor.withOpacity(.5)),
                        ProgressBar(
                            deviceWidth: 10.w,
                            color: primaryColor.withOpacity(.5)),
                        ProgressBar(
                            deviceWidth: 10.w,
                            color: primaryColor.withOpacity(.5)),
                        ProgressBar(
                            deviceWidth: 10.w,
                            color: primaryColor.withOpacity(.5)),
                        ProgressBar(deviceWidth: 10.w, color: primaryColor),
                        ProgressBar(deviceWidth: 10.w, color: blueGrey),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  headingText(title: "Zero Fare Ticket Information"),
                  LargeSpace(),
                  SmallSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 30,
                        child: Transform.scale(
                          //For Increasing or decreasing Sizes
                          scale: 1.3,
                          child: Theme(
                            // For Color Change,
                            data:
                                ThemeData(unselectedWidgetColor: Colors.white),
                            child: Checkbox(
                              value: zeroFareIssued,
                              shape: RoundedRectangleBorder(
                                  // Making around shape
                                  borderRadius: BorderRadius.circular(2)),
                              onChanged: (bool? newValue) {
                                setState(() {
                                  zeroFareIssued = newValue!;
                                });
                              },
                              activeColor: Colors.white,
                              checkColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      boxtextBold(title: "   Zero Fare Issued"),
                    ],
                  ),
                  Visibility(
                      visible: zeroFareIssued,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MediumSpace(),
                          boxtextBold(title: "5-digit Ticket Number"),
                          SmallSpace(),
                          PinCodeTextField(
                            controller: ticketNumber,
                            appContext: context,
                            length: 5,
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
                                activeColor: blueGrey,
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
                        ],
                      )),
                  SmallSpace(),
                ],
              ),
            ),
          ),
          Positioned(
              top: 0,
              child: TopHeaderCase(
                  title: "Unpaid Fare Notice (LUMO) ",
                  icon: "Assets/icons/bandge.png")),
        ],
      ),
    );
  }
}
