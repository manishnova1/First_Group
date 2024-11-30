import 'dart:developer';
import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Pages/Lookup/intelligent_report_lookup_tocs.dart';
import '../../../../common/service/common_offline_status.dart';
import 'package:intl/intl.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:sizer/sizer.dart';
import '../../../../bloc/global_bloc.dart';
import '../../../../common/locator/locator.dart';
import '../../../../common/service/toast_service.dart';
import '../../../../data/model/Affected_toc_Model.dart';
import '../../../../data/model/revpirDetailMode.dart';
import '../../../../data/model/toc_selected_model.dart';
import '../../../Utils/DeviceSize.dart';
import '../../../Utils/UpperCaseformater.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/SpaceWidgets.dart';
import '../../../Widgets/dropdownFIeldWidget.dart';
import '../../../Widgets/progress_bar.dart';
import '../../../Widgets/top_header_case.dart';
import '../../../trainselect2.dart';
import 'intellgence_report_attachments.dart';

class IntelligenceReportDetail extends StatefulWidget {
  @override
  _IntelligenceReportDetailState createState() =>
      _IntelligenceReportDetailState();
}

class _IntelligenceReportDetailState extends State<IntelligenceReportDetail> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController report = TextEditingController();
  TextEditingController headcode = TextEditingController();

  TextEditingController policeNo = TextEditingController();
  List<REVPIRDETAILSARRAY?> revirDetail = [];
  String menu = "";
  List stations = ["Bermingham", "Indian", "aasdsa"];
  String selectStation = "";
  String incidentDateTime = "";
  bool trainActive = false;
  bool stationActive = true;
  String current = "At Station";
  String Legal_Statement = '';
  List<REVPTOCLISTARRAY?> tocslList = [];
  String tocsSelected = "";
  List<TocSelectedModel> tocsSelectedList = [];
  List<String> tocsSelectedNamesList = [];
  TocSelectedModel whenEmptyTOC =
      TocSelectedModel(toc_name: "Select affected TOCs");
  String location = "";
  List<TocSelectedModel> affectedList = [];
  List<String> newTocsSelectedNamesList = [];

  int atStation = 1;
  int onTrain = 0;
  String incidentDateString = "";

  DateTime? incidentDate;

  Future<void> getTocData(BuildContext context, String reason) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                IntelligentReportTocList(tocsSelectedNamesList)));
    setState(() {
      if (result.toString() != "null") {
        tocsSelectedNamesList = result;
        newTocsSelectedNamesList.clear();
        for (var i = 0; i < tocsSelectedNamesList.length; i++) {
          if (!RegExp(r'\d').hasMatch(tocsSelectedNamesList[i]) ||
              RegExp(r'[a-zA-Z]').hasMatch(tocsSelectedNamesList[i])) {
            newTocsSelectedNamesList.add(tocsSelectedNamesList[i]);
          }
        }
      } else {}
      for (var j = 0; j < affectedList.length; j++) {
        if (affectedList[j].isSelectedIr == true) {
          affectedList[j].isSelectedIr = false;
        }
      }
    });
  }

  setSectionWiseTOCList() async {
    affectedList.add(TocSelectedModel(toc_heading: "Our TOCs"));
    affectedList.add(TocSelectedModel(toc_name: "East Midlands Railway"));
    affectedList.add(TocSelectedModel(toc_heading: "Other TOCs"));
    await Future.forEach(tocslList, (element) {
      REVPTOCLISTARRAY revptoclistarray = element as REVPTOCLISTARRAY;
      if (revptoclistarray.tocName.toString() != "East Midlands Railway") {
        affectedList.add(
            TocSelectedModel(toc_name: revptoclistarray.tocName.toString()));
      }
    });
    affectedList.add(TocSelectedModel(toc_controls: true));
  }

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
                    title: '',
                  ),
                )),
            content: subheadingText(
                title:
                    "You can use this form to report any observations or intelligence you have relating to fare evasion, fraud or breaches of Railway Bylaws."),
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

  @override
  void initState() {
    incidentDate = DateTime.now();
    incidentDateTime = DateFormat("d MMMM yyyy  HH:mm").format(incidentDate!);

    tocslList = BlocProvider.of<GlobalBloc>(context).revpAffectedTOCLIST;

    super.initState();
    setSectionWiseTOCList();
  }

  Future<void> getLocation(BuildContext context) async {
    /// Check  Auto route data receving
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StationsListScreen2("")),
    );
    setState(() {
      if (result.toString() != "null") {
        location = result.toString();
      } else {
        location = '';
      }
    });
  }

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
                      subheadingTextBOLD(title: "Go Back")
                    ],
                  ),
                )),
            InkWell(
                onTap: () {
                  if (report.text.isEmpty) {
                    locator<ToastService>().showValidationMessage(
                        context, "Report details is required");
                  } else if (newTocsSelectedNamesList.isEmpty) {
                    locator<ToastService>()
                        .showValidationMessage(context, "Select Affected TOCs");
                  } else {
                    for (var data in tocsSelectedList) {
                      newTocsSelectedNamesList.add(data.toc_name.toString());
                    }

                    Map<String, dynamic> mapData = {
                      "headcode": headcode.text ?? "",
                      "intelligenceLocation": location,
                      "intelligencereportDate": DateFormat('dd MMM yyyy')
                          .format(DateFormat("yyyy-MM-dd")
                              .parse(incidentDate.toString())),
                      "intelligencereporttime":
                          '${incidentDate?.hour.toString()}:${incidentDate?.minute.toString().padLeft(2, '0')}',
                      "reportintelligencereport": report.text ?? '',
                      "optionalpolicereference": policeNo.text ?? '',
                      "intelligenceontrain": onTrain,
                      "intelligenceonstation": atStation,
                      "affectedTOC": newTocsSelectedNamesList.toString()
                    };
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                IntelligenceAttachments(mapData, current)));
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ProgressBar(
                                    deviceWidth: 20.w, color: primaryColor),
                                ProgressBar(deviceWidth: 20.w, color: blueGrey),
                                ProgressBar(deviceWidth: 20.w, color: blueGrey),
                                ProgressBar(deviceWidth: 20.w, color: blueGrey),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              Container(
                                child: Text(
                                  "Observations and intelligence  ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: white,
                                      fontFamily: "railBold",
                                      fontSize: 13.sp,
                                      letterSpacing: 1),
                                  maxLines: 2,
                                ),
                              ),
                              IconButton(
                                iconSize: 22.sp,
                                icon: const Icon(
                                  Icons.info_outlined,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  openErrorDialog(context);
                                },
                              ),
                            ],
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                boxtextBold(title: "Date & Time"),
                                SmallSpace(),
                                Container(
                                    height: 12.h,
                                    child: CupertinoTheme(
                                        data: CupertinoThemeData(
                                          textTheme: CupertinoTextThemeData(
                                            dateTimePickerTextStyle: TextStyle(
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                          brightness: Brightness.dark,
                                        ),
                                        child: CupertinoDatePicker(
                                            mode: CupertinoDatePickerMode
                                                .dateAndTime,
                                            use24hFormat: true,
                                            initialDateTime: DateTime(
                                                DateTime.now().year,
                                                DateTime.now().month,
                                                DateTime.now().day,
                                                DateTime.now().hour,
                                                DateTime.now().minute),
                                            maximumDate: DateTime(
                                                DateTime.now().year,
                                                DateTime.now().month,
                                                DateTime.now().day + 8),
                                            maximumYear:
                                                DateTime.now().year - 1,
                                            onDateTimeChanged: (newDateTime) {
                                              setState(() {
                                                incidentDateTime = DateFormat(
                                                        "d MMMM yyyy  HH:mm")
                                                    .format(newDateTime);
                                                incidentDate = newDateTime!;
                                              });
                                            }))),
                                MediumSpace(),
                                boxtextBold(title: "Location"),
                                SmallSpace(),
                                DropdownField(
                                  onTap: () {
                                    getLocation(context);
                                  },
                                  title: location == ""
                                      ? "Select Station..."
                                      : location.toString(),
                                ),
                                MediumSpace(),
                                boxtextBold(title: "Headcode"),
                                SmallSpace(),
                                SizedBox(
                                    width: 100.w,
                                    height: 5.5.h,
                                    child: TextField(
                                      controller: headcode,
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.black,
                                          fontFamily: "railLight"),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(RegExp(
                                            r'^\d{1}(?:[a-zA-Z]\d{0,2})?$')),
                                        UpperCaseTextFormatter()
                                      ],
                                      decoration: InputDecoration(
                                        hintText: 'Enter Headcode',
                                        hintStyle: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.black,
                                            fontFamily: "railLight"),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        fillColor: white,
                                      ),
                                    )),
                                MediumSpace(),
                                boxtextBold(title: "Report"),
                                SmallSpace(),
                                Container(
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: Scrollbar(
                                      controller: _scrollController,
                                      child: TextField(
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.black,
                                            fontFamily: "railLight"),
                                        controller: report,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 5,
                                        decoration: InputDecoration(
                                          hintText: 'Enter report',
                                          hintStyle: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.black,
                                              fontFamily: "railLight"),
                                          isDense: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          filled: true,
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          fillColor: white,
                                        ),
                                      ),
                                    )),
                                MediumSpace(),
                                boxtextBold(title: "Select affected TOCs "),
                                SmallSpace(),
                                DropdownField(
                                  onTap: () {
                                    getTocData(context, " reason");
                                  },
                                  title: newTocsSelectedNamesList.length == 0
                                      ? "Select TOCs"
                                      : newTocsSelectedNamesList
                                          .toString()
                                          .replaceAll("[", "")
                                          .replaceAll("]", ""),
                                ),
                                MediumSpace(),
                                boxtextBold(title: "Optional Police Reference"),
                                SmallSpace(),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.white)),
                                  height: 5.5.h,
                                  child: TextField(
                                    enabled: true,
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.black,
                                        fontFamily: "railLight"),
                                    controller: policeNo,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Reference',
                                      hintStyle: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.black,
                                          fontFamily: "railLight"),
                                      filled: true,
                                      contentPadding: const EdgeInsets.all(10),
                                      fillColor: white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SmallSpace(),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomCheckBox(
                                        value: stationActive,
                                        checkedIconColor: Colors.black,
                                        checkedFillColor: Colors.white,
                                        shouldShowBorder: true,
                                        borderColor: Colors.white,
                                        borderWidth: 1,
                                        checkBoxSize: 22,
                                        onChanged: (val) {
                                          setState(() {
                                            stationActive = true;
                                            trainActive = false;

                                            current = "At Station";
                                            atStation = 1;
                                            onTrain = 0;
                                          });
                                        },
                                      ),
                                      boxtextBold(title: "At Station"),
                                      const SizedBox(width: 6),
                                      CustomCheckBox(
                                        value: trainActive,
                                        shouldShowBorder: true,
                                        borderColor: Colors.white,
                                        checkedIconColor: Colors.black,
                                        checkedFillColor: Colors.white,
                                        borderWidth: 1,
                                        checkBoxSize: 22,
                                        onChanged: (value) {
                                          setState(() {
                                            trainActive = true;
                                            stationActive = false;
                                            current = "On Train";
                                            atStation = 0;
                                            onTrain = 1;
                                          });
                                        },
                                      ),
                                      boxtextBold(title: "On Train"),
                                    ]),
                              ])
                        ]))),
          ),
          Positioned(
              top: 0,
              child: TopHeaderCase(
                  title: "Intelligence Report ",
                  icon: "Assets/icons/warning.png")),
        ]));
  }
}
