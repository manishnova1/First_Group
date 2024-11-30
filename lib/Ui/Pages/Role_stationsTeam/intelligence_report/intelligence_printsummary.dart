import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/car_parking_penality/print_summary_car_parking.dart';

import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/SecondryButton.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/Ui/Widgets/TopBarwithTitle.dart';
import 'package:railpaytro/bloc/intelligent_bloc/bloc_IR_submit.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/DeviceSize.dart';
import '../../../Widgets/DividerShadow.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/PrimaryButton.dart';
import '../../../Widgets/ProgressBox.dart';
import '../../../Widgets/SpaceWidgets.dart';
import '../../../Widgets/progress_bar.dart';
import '../../../Widgets/summaryBox.dart';
import '../../../Widgets/top_header_case.dart';
import 'intellgence_report_attachments.dart';
import '../../../../common/service/common_offline_status.dart';

class IntelligenceReportSummaryPrint extends StatefulWidget {
  var data;
  var imagesList;
  String caseNum;
  String current;

  IntelligenceReportSummaryPrint(
      this.data, this.imagesList, this.caseNum, this.current);

  @override
  _IntelligenceReportSummaryPrintState createState() =>
      _IntelligenceReportSummaryPrintState();
}

class _IntelligenceReportSummaryPrintState
    extends State<IntelligenceReportSummaryPrint> {
  @override
  Widget build(BuildContext context) {
    var deviceWidth = getWidth(context);
    var deviceHeight = getHeight(context);
    return Scaffold(
        backgroundColor: secondryColor,
        drawer: const DrawerWidget(),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            IntelligenceAttachments(context, widget.current)),
                  );
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
                  BlocProvider.of<IRSubmitBloc>(context).add(
                      IRSubmitSubmitEvent(
                          data: widget.data,
                          imageCount: widget.imagesList.length.toString(),
                          context: context,
                          caseNum: widget.caseNum));
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
        appBar: AppBar(
          backgroundColor: primaryColor,
          actions: [CommonOfflineStatusBar(isOfflineApiRequired: false)],
        ),
        body: Stack(children: [
          Container(
              width: 100.w,
              height: 100.h,
              decoration: gradientDecoration,
              child: SingleChildScrollView(
                  child: Column(children: [
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ProgressBar(
                                        deviceWidth: 20.w,
                                        color: primaryColor.withOpacity(.5)),
                                    ProgressBar(
                                        deviceWidth: 20.w,
                                        color: primaryColor.withOpacity(.5)),
                                    ProgressBar(
                                        deviceWidth: 20.w, color: primaryColor),
                                    ProgressBar(
                                        deviceWidth: 20.w, color: blueGrey),

                                    /* const SizedBox(
                                        width: 10,
                                      ),
                                      ProgressBox(deviceWidth: deviceWidth, color: primaryColor),*/
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  headingTextOne(title: "Summary"),
                                  LargeSpace(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1.w, vertical: 10),
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          CupertinoIcons.flag_fill,
                                          color: primaryColor,
                                        ),
                                        Container(
                                          width: 77.w,
                                          child: Text(
                                              "Please check the information is correct and then either Submit or Go back to ammend the data.",
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "railLight")),
                                        )
                                      ],
                                    ),
                                  ),
                                  LargeSpace(),
                                  SizedBox(
                                    height: 2.h,
                                  ),

                                  // headingText(title: "Ref Case ID: ${widget.caseNum}"),
                                  // LargeSpace(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      summaryBox(
                                        title: "Date & Time of Incident:",
                                        value:
                                            "${widget.data['intelligencereportDate']}  ${widget.data['intelligencereporttime']}",
                                      ),
                                    ],
                                  ),
                                  SmallSpace(),
                                  DividerShadow(),
                                  LargeSpace(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      summaryBox(
                                          title: "Location:",
                                          value: widget
                                              .data['intelligenceLocation']),
                                    ],
                                  ),
                                  SmallSpace(),
                                  DividerShadow(),
                                  LargeSpace(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      summaryBox(
                                          title: "Headcode:",
                                          value: widget.data['headcode']),
                                    ],
                                  ),
                                  SmallSpace(),
                                  DividerShadow(),
                                  LargeSpace(),

                                  boxtextBold(title: "Report:"),
                                  SizedBox(
                                    height: 4,
                                  ),

                                  boxtextsumary(
                                      title: widget
                                          .data['reportintelligencereport']),
                                  SmallSpace(),
                                  DividerShadow(),
                                  LargeSpace(),

                                  boxtextBold(title: "Affected TOCs:"),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  boxtextsumary(
                                      title: widget.data['affectedTOC']
                                          .toString()
                                          .substring(
                                              1,
                                              widget.data['affectedTOC']
                                                      .toString()
                                                      .length -
                                                  1)
                                          .toString()),
                                  SmallSpace(),
                                  DividerShadow(),
                                  LargeSpace(),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      summaryBox(
                                          title: "Police Reference:",
                                          value: widget
                                              .data['optionalpolicereference']),
                                    ],
                                  ),
                                  SmallSpace(),
                                  DividerShadow(),
                                  LargeSpace(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      summaryBox(
                                        title: "Photos:",
                                        value:
                                            widget.imagesList.length.toString(),
                                      )
                                    ],
                                  ),
                                  LargeSpace(),
                                  DividerShadow(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: 20,
                                          child: Checkbox(
                                              activeColor: primaryColor,
                                              value: true,
                                              onChanged: (onChanged) {})),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(widget.current,
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                  LargeSpace(),
                                ],
                              )
                            ]))),
              ]))),
          Positioned(
              top: 0,
              child: TopHeaderCase(
                  title: "Intelligence Report ",
                  icon: "Assets/icons/warning.png")),
        ]));
  }
}
