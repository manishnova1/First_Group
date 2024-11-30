import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../common/locator/locator.dart';
import '../../../../common/service/common_offline_status.dart';
import 'package:railpaytro/bloc/global_bloc.dart';
import 'package:railpaytro/data/model/auth/cms_variables_model.dart';
import 'package:signature/signature.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/ProgressBox.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/Ui/Widgets/TopBarwithTitle.dart';
import 'package:sizer/sizer.dart';
import 'package:html/dom.dart' as dom;
import 'dart:ui' as ui;
import '../../../../bloc/test_bloc/test_submit_form_bloc.dart';
import '../../../../common/service/toast_service.dart';
import '../../../Utils/DeviceSize.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/PrimaryButton.dart';
import '../../../Widgets/SecondryButton.dart';
import '../../../Widgets/SpaceWidgets.dart';
import '../../../Widgets/progress_bar.dart';
import '../../../Widgets/top_header_case.dart';

class testCustomerConfirmation extends StatefulWidget {
  @override
  _testCustomerConfirmationState createState() =>
      _testCustomerConfirmationState();
}

class _testCustomerConfirmationState extends State<testCustomerConfirmation> {
  int _groupValue = -1;

  List verificationTypeList = ["ewq", "qw", "qwe"];
  String verificationType = "";
  bool emailCopy = true;
  String customerstatus = "2";
  String customerDecline = "0";
  String customerUnable = "1";
  bool showAction = false;
  CMSVARIABLESBean? cmsVariable;
  String Legal_Statement = '';

  @override
  void initState() {
    cmsVariable = BlocProvider.of<GlobalBloc>(context).cmsVariable;
    dynamic legalContent = cmsVariable?.Unpaid_Fair_Notice_Legal_Statement;
    Legal_Statement = legalContent['1']['MESSAGE_ENG'];
    setState(() {
      emailCopy = true;
    });
    super.initState();
  }

  TextEditingController reasonController = TextEditingController();
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
    exportPenColor: Colors.black,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );

  openErrorDialog(BuildContext context) async {
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
            title: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: headingText(
                    title: 'Warning',
                  ),
                )),
            content: subheadingText(
                title:
                    "The customer is required to sign this notice. If they are unable to, select the appropriate reason."),
            actions: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    "Assets/icons/cross.png",
                    width: 4.w,
                  )),
              SizedBox(
                height: 8.h,
              )
            ],
          );
        });
  }

  openAppDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                side: BorderSide(color: primaryColor, width: 3)),
            backgroundColor: Colors.white,
            insetPadding: EdgeInsets.all(20),
            actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
            content: DialogFieldText(
                title:
                    "IT IS AN OFFENCE TO DELIBERATELY AVOID PAYMENT OF THE FARE DUE "),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 45.h,
                      color: blueGrey.withOpacity(.1),
                      child: RawScrollbar(
                        trackVisibility: true,
                        thumbColor: primaryColor,
                        trackColor: Colors.black54,
                        trackRadius: const Radius.circular(20),
                        thumbVisibility: true,
                        //always show scrollbar
                        thickness: 8,
                        //width of scrollbar
                        radius: const Radius.circular(20),
                        //corner radius of scrollbar

                        scrollbarOrientation: ScrollbarOrientation.right,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            child: Html(
                                data: Legal_Statement,
                                onLinkTap: (String? url,
                                    RenderContext context,
                                    Map<String, String> attributes,
                                    dom.Element? element) {},
                                style: {
                                  'body': Style(
                                    textAlign: TextAlign.justify,
                                    color: Colors.black87,
                                    fontFamily: "railLight",
                                    fontSize: FontSize(10.sp),
                                  ),
                                  'a': Style(
                                      color: Colors.blueGrey,
                                      textAlign: TextAlign.justify,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "railLight"),
                                }),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    PrimaryButton(
                        title: "Acknowledge and Close",
                        onAction: () {
                          Navigator.pop(context);
                        }),
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

  @override
  Widget build(BuildContext context) {
    var deviceWidth = getWidth(context);
    var deviceHeight = getHeight(context);
    return Scaffold(
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
              onTap: () async {
                if (_controller.isEmpty && customerstatus == "2") {
                  locator<ToastService>().showValidationMessage(context,
                      'The customer is required to sign this notice. If they are unable to, select the appropriate reason.');
                } else if (_controller.isNotEmpty && customerstatus == "2") {
                  final Uint8List? rawData = await _controller.toPngBytes();
                  print(rawData.toString());
                  final tempDir = await getTemporaryDirectory();
                  final file = await File('${tempDir.path}/image.jpg').create();
                  file.writeAsBytesSync(rawData!);
                  call(file);
                } else {
                  final Uint8List? rawData = await _controller.toPngBytes();
                  print(rawData.toString());
                  final tempDir = await getTemporaryDirectory();
                  final file = await File('${tempDir.path}/image.jpg').create();
                  call(file);
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
              ))
        ],
      ),
      drawer: const DrawerWidget(),
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
              child: Column(children: [
                Padding(
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
                        height: 2.h,
                      ),

                      Row(
                        children: [
                          headingText(title: "Customer Confirmation  "),
                          IconButton(
                            iconSize: 35,
                            icon: const Icon(
                              Icons.info_outlined,
                              color: Colors.white,
                            ),
                            // the method which is called
                            // when button is pressed
                            onPressed: () {
                              openErrorDialog(context);
                            },
                          ),
                        ],
                      ),

                      LargeSpace(),
                      Card(
                        color: Colors.red,
                        child: ListTile(
                          onTap: () {
                            openAppDialog(context);
                          },
                          iconColor: Colors.white,
                          trailing: const Icon(
                            Icons.list_alt_rounded,
                            color: Colors.white,
                          ),
                          title: subheadingTextBOLD(title: "Show Statement"),
                        ),
                      ),
                      LargeSpace(),
                      boxtextBold(title: "Customer Signature"),
                      MediumSpace(),
                      Stack(
                        children: [
                          SizedBox(
                            height: 19.h,
                            width: 100.w,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5)),
                              child: customerstatus == "2"
                                  ? Signature(
                                      controller: _controller,
                                      height: 19.h,
                                      backgroundColor: Colors.white,
                                    )
                                  : Container(
                                      height: 19,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                        ],
                      ),
                      // children: <Widget>[

                      Container(
                        decoration: BoxDecoration(
                          color: blueGrey,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(""),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showAction = !showAction;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.more_horiz,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: showAction,
                        child: Container(
                          decoration: BoxDecoration(
                            color: blueGrey,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10, bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      child: Theme(
                                        data: ThemeData(
                                            unselectedWidgetColor:
                                                Colors.white),
                                        child: Radio(
                                          activeColor: primaryColor,
                                          value: customerDecline,
                                          groupValue: customerstatus,
                                          onChanged: (newValue) {
                                            _controller.clear();
                                            setState(() {
                                              customerstatus =
                                                  newValue.toString();
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    boxtextBold(
                                        title: "Customer declined to sign"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      child: Theme(
                                        data: ThemeData(
                                            unselectedWidgetColor:
                                                Colors.white),
                                        child: Radio(
                                          activeColor: primaryColor,
                                          value: customerUnable,
                                          groupValue: customerstatus,
                                          onChanged: (newValue) {
                                            _controller.clear();

                                            setState(() {
                                              customerstatus =
                                                  newValue.toString();
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    boxtextBold(
                                        title: "Customer unable to sign"),
                                  ],
                                ),
                                MediumSpace(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                            InkWell(
                              onTap: () {
                                _controller.clear();
                                setState(() {
                                  customerstatus = "2";
                                  customerDecline = "0";
                                  customerUnable = "1";
                                });
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(),
                                  width: 40.w,
                                  height: 6.h,
                                  color: primaryColor,
                                  child: Center(
                                      child: subheadingTextBOLD(
                                          title: "Clear Signature"))),
                            ),
                          ])),

                      SizedBox(
                        height: 1.h,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ),
          Positioned(
              top: 0,
              child: TopHeaderCase(
                  title: "Test Notice ", icon: "Assets/icons/warning.png")),
        ],
      ),
    );
  }

  call(file) {
    BlocProvider.of<TestSubmitFormBloc>(context).add(TestCustomerSignEvent(
      context: context,
      image: file,
      refuseSign: customerstatus == '0' ? '1' : '0',
      sendCopyEmail: emailCopy ? '1' : '0',
      unableSign: customerstatus == '1' ? '1' : '0',
      reason: reasonController.text ?? "",
    ));
  }
}
