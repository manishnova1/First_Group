// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/ProgressBox.dart';
import 'package:railpaytro/Ui/Widgets/SecondryButton.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/Ui/Widgets/TopBarwithTitle.dart';
import 'package:sizer/sizer.dart';

import '../../../../bloc/global_bloc.dart';
import '../../../../bloc/test_bloc/test_address_bloc.dart';
import '../../../../bloc/test_bloc/test_journy_info_bloc.dart';
import '../../../../bloc/ufn_luno_bloc/address_screen_bloc.dart';
import '../../../../common/locator/locator.dart';
import '../../../../common/router/router.gr.dart';
import '../../../../common/service/navigation_service.dart';
import '../../../../common/service/toast_service.dart';
import '../../../../data/model/lookup_model.dart';
import '../../../../data/model/ufn/RevpCardType.dart';
import '../../../../data/model/ufn/revp_card_type.dart';
import '../../../Utils/DeviceSize.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/PrimaryButton.dart';
import '../../../Widgets/SpaceWidgets.dart';
import '../../../Widgets/dropdownFIeldWidget.dart';
import '../../../Widgets/progress_bar.dart';
import '../../../Widgets/top_header_case.dart';
import '../../../travelclass.dart';
import '../../Lookup/test_lookup_list.dart';
import '../../Lookup/ufn_lookup_list.dart';
import '../../../../common/service/common_offline_status.dart';

class TestJourneyDetails extends StatefulWidget {
  @override
  _TestJourneyDetailsState createState() => _TestJourneyDetailsState();
}

class _TestJourneyDetailsState extends State<TestJourneyDetails> {
  TextEditingController date = TextEditingController();
  TextEditingController otherReason = TextEditingController();

  // String menu = "";
  // List stations = ["Bermingham", "Indian", "aasdsa"];
  String selectStation = "";
  String issueDateTime = "";
  List<String> issueList = ["At Station", "On Train"];

  List<CASE_CLASSESBean> travelclassList = [];
  CASE_CLASSESBean? selectTravelClass;

  List<CASE_REASON_FOR_ISSUEBean> reassonIssueList = [];
  CASE_REASON_FOR_ISSUEBean? reasonIssue;
  List<REVPRAILCARDTYPEARRAYBean?> tempCardTypeList2 = [];
  String travelTo = "";

  // String reasonIssue = "";
  String travelFrom = "";
  String selectIssueAt = "At Station";

  LookupModel? lookupModel;
  RevpCardType? revpCardType;
  List<REVPRAILCARDTYPEARRAYBean?> cardTypeList = [];
  REVPRAILCARDTYPEARRAYBean? selectedCard;
  String formatedTime = "";
  String formatedDate = "";
  DateTime? timeData;
  var subMap;

  Future<void> getIssueData(BuildContext context, String reason) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                TestUfnLookupList("TEST", "Issuing Reason", "")));
    setState(() {
      if (result.toString() != "null") {
        reasonIssue = result as CASE_REASON_FOR_ISSUEBean;
      } else {
        reasonIssue = null;
      }
    });
  }

  Future<void> gettravelClass(BuildContext context, String reason) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                travelClass("Test", " Select Travel Class", "")));
    setState(() {
      if (result.toString() != "null") {
        selectTravelClass = result as CASE_CLASSESBean;
      } else {
        selectTravelClass = null;
      }
    });
  }

  @override
  void initState() {
    timeData = DateTime.now();

    issueDateTime = DateFormat("d MMMM yyyy  HH:mm").format(timeData!);
    formatedTime = DateFormat('HH:mm').format(DateTime.now());

    formatedDate = DateFormat.MMMEd().format(timeData!);
    lookupModel = BlocProvider.of<GlobalBloc>(context).lookupModel;
    createSectionDropDown();
    if (lookupModel != null && lookupModel!.CASE_CLASSES!.isNotEmpty) {
      travelclassList.addAll(lookupModel!.CASE_CLASSES!);
      reassonIssueList.addAll(lookupModel!.CASE_REASON_FOR_ISSUE!);
    }

    saveState();
    setState(() {
      selectIssueAt = "At Station";
    });
    super.initState();
  }

  createSectionDropDown() async {
    List<REVPRAILCARDTYPEARRAYBean?> cardTypeListFilterData =
        BlocProvider.of<GlobalBloc>(context).revpCardTypeList;

    String filterType = "";
    Map<String, List<REVPRAILCARDTYPEARRAYBean?>> cardTypeFilterList = {};

    await Future.forEach(cardTypeListFilterData, (element) {
      REVPRAILCARDTYPEARRAYBean revprailcardtypearrayBean =
          element as REVPRAILCARDTYPEARRAYBean;

      filterType = revprailcardtypearrayBean.revpRailCardType ?? "";

      List outputList = cardTypeListFilterData
          .where((dynamic filterElement) =>
              filterElement.revpRailCardType == filterType)
          .toList();

      cardTypeFilterList.addAll({
        "${revprailcardtypearrayBean.revpRailCardType}":
            outputList as List<REVPRAILCARDTYPEARRAYBean?>
      });
    });
    List<REVPRAILCARDTYPEARRAYBean?> tempCardTypeList = [];
    List<REVPRAILCARDTYPEARRAYBean?> cardTypeList = [];

    await Future.forEach(cardTypeFilterList.entries, (mapElement) {
      MapEntry mapEntry = mapElement as MapEntry;
      if (mapEntry.key == "Other Railcards") {
        tempCardTypeList
            .add(REVPRAILCARDTYPEARRAYBean(revpSection: mapEntry.key));
        tempCardTypeList
            .addAll(mapEntry.value as List<REVPRAILCARDTYPEARRAYBean?>);
      } else {
        cardTypeList.add(REVPRAILCARDTYPEARRAYBean(revpSection: mapEntry.key));
        cardTypeList.addAll(mapEntry.value as List<REVPRAILCARDTYPEARRAYBean?>);
      }
    });
    tempCardTypeList2.insertAll(0, cardTypeList);
    tempCardTypeList2.addAll(tempCardTypeList);
  }

  saveState() {
    setState(() {
      subMap = BlocProvider.of<AddressUfnBloc>(context).submitAddressMap;
      travelFrom = subMap['boarded_at'] ?? "";
      travelTo = subMap['alighted_at'] ?? "";

      selectIssueAt = subMap['issued_at'] ?? "";
      reasonIssue?.lookup_data_value = subMap['issued_at'] ?? "";
    });
  }

  Future<void> getTravelledTo(BuildContext context) async {
    final result = await locator<NavigationService>()
        .push(StationsListScreenRoute(caseType: ""));
    setState(() {
      if (result.toString() != "null") {
        travelTo = result.toString();
        if (result.toString() == travelFrom) {
          Fluttertoast.showToast(
            msg: 'Please change destination',
            toastLength: Toast.LENGTH_LONG,
          );
        }
      } else {
        travelTo = "";
      }
    });
  }

  Future<void> getTravelledFrom(BuildContext context) async {
    final result = await locator<NavigationService>()
        .push(StationsListScreenRoute(caseType: ""));
    setState(() {
      if (result.toString() != "null") {
        travelFrom = result.toString();
      } else {
        travelFrom = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
              if (travelFrom.isEmpty) {
                locator<ToastService>()
                    .showValidationMessage(context, 'Select Travelled From');
              } else if (travelTo.isEmpty) {
                locator<ToastService>()
                    .showValidationMessage(context, 'Select Travelled To');
              } else if (selectTravelClass == null) {
                locator<ToastService>()
                    .showValidationMessage(context, 'Select Travel Class');
              } else if (timeData == null) {
                locator<ToastService>().showValidationMessage(
                    context, 'Please select Date of Issue');
              } else if (reasonIssue == null) {
                locator<ToastService>()
                    .showValidationMessage(context, 'Select Issuing Reason');
              } else if (travelTo.toString() == travelFrom.toString()) {
                locator<ToastService>().showValidationMessage(context,
                    'Travelled From and Travelled To stations should not be same');
              } else if (reasonIssue?.lookup_data_value.toString() == "Other" &&
                  otherReason.text.isEmpty) {
                locator<ToastService>()
                    .showValidationMessage(context, 'Select other reason');
              } else if ((reasonIssue?.lookup_data_id ?? '') ==
                      'e3d550e4-e0b2-11eb-8ac7-068868ba27e2' &&
                  selectedCard == null) {
                locator<ToastService>().showValidationMessage(
                    context, 'Please select Railcard type');
              } else {
                BlocProvider.of<TestJournyInfoBloc>(context).add(
                    TestInfoJournyButtonEvent(
                        context: context,
                        otherReason: otherReason.text ?? '',
                        issueAt: selectIssueAt,
                        travelClass: selectTravelClass?.lookup_data_value ?? '',
                        travelClassId: selectTravelClass?.lookup_data_id ?? '',
                        origin: travelFrom,
                        destination: travelTo,
                        issueDateTime: timeData!,
                        reasonId: reasonIssue?.lookup_data_id ?? '',
                        reason: reasonIssue?.lookup_data_value ?? '',
                        cardType: selectedCard?.revpRailcardID ?? ''));
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
              child: Column(
                children: [
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
                                  deviceWidth: 10.w, color: primaryColor),
                              ProgressBar(deviceWidth: 10.w, color: blueGrey),
                              ProgressBar(deviceWidth: 10.w, color: blueGrey),
                              ProgressBar(deviceWidth: 10.w, color: blueGrey),
                              ProgressBar(deviceWidth: 10.w, color: blueGrey),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        headingText(title: "Journey Details"),
                        MediumSpace(),
                        LargeSpace(),
                        boxtextBold(title: "Travelled From"),
                        SmallSpace(),
                        DropdownField(
                          onTap: () {
                            getTravelledFrom(context);
                          },
                          title: travelFrom == ""
                              ? "Travelled From"
                              : travelFrom.toString(),
                        ),
                        LargeSpace(),
                        boxtextBold(title: "Travelled To"),
                        SmallSpace(),
                        DropdownField(
                            onTap: () {
                              getTravelledTo(context);
                            },
                            title: travelTo == ""
                                ? "Travelled To"
                                : travelTo.toString()),
                        LargeSpace(),
                        boxtextBold(title: "Travel Class"),
                        SmallSpace(),
                        DropdownField(
                            onTap: () {
                              gettravelClass(context, "");
                            },
                            title: selectTravelClass == null
                                ? "Select Travel Class"
                                : (selectTravelClass?.lookup_data_value ?? '')
                                    .toString()),
                        LargeSpace(),
                        boxtextBold(title: "Issued"),
                        SmallSpace(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Theme(
                              data: ThemeData(
                                  unselectedWidgetColor: Colors.white),
                              child: Radio(
                                  activeColor: primaryColor,
                                  value: "At Station",
                                  groupValue: selectIssueAt,
                                  onChanged: (value) {
                                    setState(() {
                                      selectIssueAt = "At Station";
                                    });
                                  }),
                            ),
                            boxtextBold(title: "At Station"),
                            Theme(
                              data: ThemeData(
                                  unselectedWidgetColor: Colors.white),
                              child: Radio(
                                  activeColor: primaryColor,
                                  value: "On Train",
                                  groupValue: selectIssueAt,
                                  onChanged: (value) {
                                    setState(() {
                                      selectIssueAt = "On Train";
                                    });
                                  }),
                            ),
                            boxtextBold(title: "On Train"),
                          ],
                        ),
                        LargeSpace(),
                        boxtextBold(title: "Issuing Reason"),
                        SmallSpace(),
                        DropdownField(
                            onTap: () {
                              getIssueData(context, "");
                            },
                            title: reasonIssue == null
                                ? "Select Issuing Reason"
                                : "${reasonIssue?.lookup_data_value ?? ''}"
                                    .toString()),
                        reasonIssue?.lookup_data_value.toString() == "Other"
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LargeSpace(),
                                  boxtextBold(title: "Other Reason"),
                                  SmallSpace(),
                                  SizedBox(
                                    width: 100.w,
                                    height: 5.5.h,
                                    child: TextField(
                                      controller: otherReason,
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.black,
                                          fontFamily: "railLight"),
                                      decoration: InputDecoration(
                                        hintText: 'Enter Reason',
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
                                  ),
                                ],
                              )
                            : Container(),
                        if ((reasonIssue?.lookup_data_id ?? '') ==
                            'e3d550e4-e0b2-11eb-8ac7-068868ba27e2')
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MediumSpace(),
                              boxtextBold(title: "Railcard Type"),
                              SmallSpace(),
                              Container(
                                width: 100.w,
                                height: 6.4.h,
                                padding: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                  dropdownColor: secondryColor,
                                  hint: selectedCard == null
                                      ? Text('     Select Railcard',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.black,
                                              fontFamily: "railLight"))
                                      : Text(
                                          "   ${selectedCard?.revpRailcard ?? ''}",
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.black,
                                              fontFamily: "railLight")),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    size: 16.sp,
                                  ),
                                  style: const TextStyle(color: Colors.black),
                                  items: tempCardTypeList2.map(
                                    (val) {
                                      return DropdownMenuItem<
                                          REVPRAILCARDTYPEARRAYBean>(
                                        value: val,
                                        enabled: val?.revpRailCardType == null
                                            ? false
                                            : true,
                                        child: val?.revpRailCardType == null
                                            ? Container(
                                                // decoration: const BoxDecoration(
                                                //   color: Colors.grey,
                                                // ),
                                                alignment: Alignment.center,
                                                height: 40,
                                                child: Text(
                                                    val?.revpSection ?? '',
                                                    style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: white,
                                                        fontFamily:
                                                            "railLight")),
                                              )
                                            : Text(val?.revpRailcard ?? '',
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    color: white,
                                                    fontFamily: "railLight")),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (REVPRAILCARDTYPEARRAYBean? val) {
                                    if (val?.revpRailCardType != null) {
                                      setState(
                                        () {
                                          selectedCard = val;
                                        },
                                      );
                                    }
                                  },
                                )),
                              ),
                            ],
                          ),
                        LargeSpace(),
                        SmallSpace(),
                        boxtextBold(title: "Date and Time of Issue"),
                        SmallSpace(),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 3.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: primaryColor, width: 2)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              boxtextBoldH1(title: formatedDate),
                              Text(
                                "   |   ",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20.sp),
                              ),
                              boxtextBoldH1(title: formatedTime),
                            ],
                          ),
                        ),
                        SmallSpace(),
                      ],
                    ),
                  ),
                ],
              ),
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
}
