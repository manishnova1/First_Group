import 'dart:ui';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:sizer/sizer.dart';
import '../../../../bloc/ufn_luno_bloc/submit_form_bloc.dart';
import '../../../../common/locator/locator.dart';
import '../../../../common/service/common_offline_status.dart';
import '../../../../bloc/ufn_luno_bloc/address_screen_bloc.dart';
import '../../../../common/service/toast_service.dart';
import '../../../Utils/DeviceSize.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/SpaceWidgets.dart';
import '../../../Widgets/progress_bar.dart';
import '../../../Widgets/top_header_case.dart';

class Unpaid_PaymentDetails extends StatefulWidget {
  @override
  _Unpaid_PaymentDetailsState createState() => _Unpaid_PaymentDetailsState();
}

class _Unpaid_PaymentDetailsState extends State<Unpaid_PaymentDetails> {
  TextEditingController dueController = TextEditingController();
  TextEditingController oustandingController = TextEditingController();

  TextEditingController recievedController = TextEditingController();

  String menu = "";

  @override
  void initState() {
    // TODO: implement initState

    var submitAddressMap =
        BlocProvider.of<AddressUfnBloc>(context).submitAddressMap;
    oustandingController.text =
        "${submitAddressMap["outstanding_pound"] ?? ""}";
    recievedController.text =
        "${submitAddressMap["amt_recieved_pound"] ?? "0.00"}";
    dueController.text = "${submitAddressMap["total_due_pound"] ?? ""}";

    super.initState();
  }

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
              if (dueController.text.isEmpty) {
                locator<ToastService>()
                    .showValidationMessage(context, "Please enter total due");
              } else if (recievedController.text.isEmpty) {
                locator<ToastService>()
                    .showValidationMessage(context, "Please enter received");
              } else if (oustandingController.text.isEmpty) {
                locator<ToastService>()
                    .showValidationMessage(context, "Please enter outstanding");
              } else if (double.parse(oustandingController.text) < 0) {
                locator<ToastService>().showValidationMessage(context,
                    "The Amount Outstanding is negative. Please rectify the figures you have input");
              } else {
                BlocProvider.of<SubmitFormBloc>(context).add(PaymentFormEvent(
                    context: context,
                    outstanding: oustandingController.text,
                    received: recievedController.text,
                    total: dueController.text));
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
            child: SingleChildScrollView(
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
                          ProgressBar(deviceWidth: 10.w, color: primaryColor),
                          ProgressBar(deviceWidth: 10.w, color: blueGrey),
                          ProgressBar(deviceWidth: 10.w, color: blueGrey),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    headingText(title: "Payment "),
                    MediumSpace(),
                    LargeSpace(),
                    boxtextBold(title: "Total Due"),
                    MediumSpace(),
                    Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: secondryColor,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(0)),
                              ),
                              height: 8.h,
                              padding: EdgeInsets.all(10),
                              width: 17.w,
                              child: Center(
                                child: Text("£",
                                    style: TextStyle(
                                        fontSize: 27.sp,
                                        color: Colors.white,
                                        fontFamily: "railBold")),
                              ),
                            ),
                            Container(
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: blueGrey,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(5)),
                              ),
                              width: 70.w,
                              child: TextField(
                                style: TextStyle(
                                    fontSize: 27.sp,
                                    color: Colors.white,
                                    fontFamily: "railBold"),
                                onChanged: (v) {
                                  var _data = double.parse(v.isEmpty
                                          ? '0.00'
                                          : v.replaceAll(",", "")) -
                                      double.parse(
                                          recievedController.text.isEmpty
                                              ? '0.00'
                                              : recievedController.text);
                                  setState(() {
                                    //  recievedController.text='0.00';
                                    oustandingController.text =
                                        _data.toStringAsFixed(2);
                                  });
                                },

                                inputFormatters: <TextInputFormatter>[
                                  CurrencyTextInputFormatter(symbol: "")
                                ],
                                // onChanged: (string) {
                                //   string = '${_formatNumber(string.replaceAll(',', ''))}';
                                //   dueController.value = TextEditingValue(
                                //     text: string,
                                //     selection: TextSelection.collapsed(offset: string.length),
                                //   );
                                // },
                                controller: dueController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.end,
                                decoration: InputDecoration(
                                  hintText: '0.00',
                                  hintStyle: TextStyle(
                                      fontSize: 27.sp,
                                      color: Colors.white,
                                      fontFamily: "railBold"),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  filled: true,
                                  contentPadding: EdgeInsets.all(10),
                                  fillColor: blueGrey,
                                ),
                              ),
                            )
                          ],
                        )),
                    LargeSpace(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        boxtextBold(title: "Amount Received"),
                        SmallSpace(),
                        Container(
                            width: 100.w,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: secondryColor,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(0)),
                                  ),
                                  height: 8.h,
                                  padding: EdgeInsets.all(10),
                                  width: 17.w,
                                  child: Center(
                                    child: Text("£",
                                        style: TextStyle(
                                            fontSize: 27.sp,
                                            color: Colors.white,
                                            fontFamily: "railBold")),
                                  ),
                                ),
                                Container(
                                  height: 8.h,
                                  decoration: BoxDecoration(
                                    color: blueGrey,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(5)),
                                  ),
                                  width: 70.w,
                                  child: TextField(
                                    style: TextStyle(
                                        fontSize: 27.sp,
                                        color: Colors.white,
                                        fontFamily: "railBold"),
                                    onChanged: (v) {
                                      if (dueController.text.isNotEmpty) {
                                        var _data = double.parse(
                                                dueController.text.isEmpty
                                                    ? "0.00"
                                                    : dueController.text
                                                        .replaceAll(",", "")) -
                                            double.parse(v.isEmpty
                                                ? '0.00'
                                                : v.replaceAll(",", ""));
                                        setState(() {
                                          oustandingController.text =
                                              _data.toStringAsFixed(2);
                                        });
                                      }
                                    },
                                    controller: recievedController,
                                    keyboardType: TextInputType.number,

                                    inputFormatters: <TextInputFormatter>[
                                      CurrencyTextInputFormatter(symbol: "")
                                    ],
                                    // onChanged: (string) {
                                    //   string = '${_formatNumber(string.replaceAll(',', ''))}';
                                    //   dueController.value = TextEditingValue(
                                    //     text: string,
                                    //     selection: TextSelection.collapsed(offset: string.length),
                                    //   );
                                    // },

                                    textAlign: TextAlign.end,
                                    decoration: InputDecoration(
                                      hintText: '0.00',
                                      hintStyle: TextStyle(
                                          fontSize: 27.sp,
                                          color: Colors.white,
                                          fontFamily: "railBold"),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      filled: true,
                                      contentPadding: EdgeInsets.all(10),
                                      fillColor: blueGrey,
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                    LargeSpace(),
                    LargeSpace(),
                    LargeSpace(),
                    boxtextBold(title: "Amount Outstanding"),
                    SmallSpace(),
                    Container(
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                      width: 2.0, color: primaryColor),
                                  top: BorderSide(
                                      width: 2.0, color: primaryColor),
                                  bottom: BorderSide(
                                      width: 2.0, color: primaryColor),
                                ),
                              ),
                              height: 8.h,
                              padding: EdgeInsets.all(10),
                              width: 17.w,
                              child: Center(
                                child: Text("£",
                                    style: TextStyle(
                                        fontSize: 27.sp,
                                        color: Colors.white,
                                        fontFamily: "railBold")),
                              ),
                            ),
                            Container(
                              height: 8.h,
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                      width: 2.0, color: primaryColor),
                                  top: BorderSide(
                                      width: 2.0, color: primaryColor),
                                  bottom: BorderSide(
                                      width: 2.0, color: primaryColor),
                                ),
                              ),
                              width: 70.w,
                              child: TextField(
                                controller: oustandingController,
                                readOnly: true,
                                style: TextStyle(
                                    fontSize: 27.sp,
                                    color: Colors.white,
                                    fontFamily: "railBold"),

                                keyboardType: TextInputType.number,

                                inputFormatters: <TextInputFormatter>[
                                  CurrencyTextInputFormatter(symbol: "")
                                ],
                                // onChanged: (string) {
                                //   string = '${_formatNumber(string.replaceAll(',', ''))}';
                                //   dueController.value = TextEditingValue(
                                //     text: string,
                                //     selection: TextSelection.collapsed(offset: string.length),
                                //   );
                                // },

                                textAlign: TextAlign.end,
                                decoration: InputDecoration(
                                  hintText: '0.00',
                                  hintStyle: TextStyle(
                                      fontSize: 27.sp,
                                      color: Colors.white,
                                      fontFamily: "railBold"),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                            )
                          ],
                        )),
                    LargeSpace(),
                    LargeSpace(),
                    LargeSpace(),
                    LargeSpace(),
                    LargeSpace(),
                    LargeSpace(),
                  ],
                ),
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
