import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/Ui/Widgets/backButton.dart';

import 'package:sizer/sizer.dart';
import '../../../bloc/global_bloc.dart';
import '../../../data/model/lookup_model.dart';
import '../../Utils/DeviceSize.dart';
import '../../Widgets/SpaceWidgets.dart';
import '../../Widgets/top_header_case.dart';

class UfnLookupList extends StatefulWidget {
  String caseType;
  String categoryList;
  String exrta;

  UfnLookupList(this.caseType, this.categoryList, this.exrta, {Key? key})
      : super(key: key);

  @override
  _UfnLookupListState createState() => _UfnLookupListState();
}

class _UfnLookupListState extends State<UfnLookupList> {
  String menu = "";
  final searchCOnt = TextEditingController();
  List<CASE_REASON_FOR_ISSUEBean> reassonIssueList = [];
  CASE_REASON_FOR_ISSUEBean? reasonIssue;
  String caseTile = "";
  String icon = "";
  late LookupModel? offenceModel;
  List<CASE_REASON_FOR_ISSUEBean> filteredList = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.caseType == "UFN") {
      caseTile = "Unpaid Fare Notice (LUMO)";
      icon = "Assets/icons/bandge.png";
    } else if (widget.caseType == "UFN2") {
      caseTile = "Unpaid Fare Notice (HT)";
      icon = "Assets/icons/bandge.png";
    } else if (widget.caseType == "PFN") {
      caseTile = "Penalty Fare Notice";
      icon = "Assets/icons/icon2.png";
    }

    dataGet();
  }

  dataGet() async {
    if (widget.categoryList == "Issuing Reason") {
      List<CASE_REASON_FOR_ISSUEBean> list = [];
      offenceModel = BlocProvider.of<GlobalBloc>(context).lookupModel;
      for (var element in offenceModel!.CASE_REASON_FOR_ISSUE!) {
        list.add(element);
      }
      reassonIssueList = list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: gradientDecoration,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 0),
                      child: headingText(
                        title: widget.categoryList,
                      )),
                  LargeSpace(),
                  Expanded(
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
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(10.0),
                          itemCount: reassonIssueList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                // Navigator.pop(context,state.listData[index]!.value);
                              },
                              child:
                                  _stationListWidget(reassonIssueList[index]),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: secondryColor,
                            );
                          },
                        )),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ),
            Positioned(
                top: 0, child: TopHeaderCase(title: caseTile, icon: icon)),
            const Positioned(
              bottom: 0,
              child: backButton(),
            )
          ],
        ),
      ),
    );
  }

  Widget _stationListWidget(data) {
    var deviceWidth = getWidth(context);
    return GestureDetector(
        onTap: () {
          Navigator.pop(context, data);
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60.w,
                    child: Text(
                      /*isNormalStation ? data.value :*/
                      data.lookup_data_value.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: "railLight",
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class mg11listreason extends StatefulWidget {
  String caseType;
  String categoryList;
  String exrta;

  mg11listreason(this.caseType, this.categoryList, this.exrta, {Key? key})
      : super(key: key);

  @override
  _mg11listreasonState createState() => _mg11listreasonState();
}

class _mg11listreasonState extends State<mg11listreason> {
  String menu = "";
  final searchCOnt = TextEditingController();
  List<REASON_FOR_ISSUE_FOR_MG11Bean> reassonIssueList = [];
  REASON_FOR_ISSUE_FOR_MG11Bean? reasonIssue;
  String caseTile = "";
  String icon = "";
  late LookupModel? offenceModel;

  @override
  void initState() {
    super.initState();
    if (widget.caseType == "MG11") {
      caseTile = "MG11";
      icon = "Assets/icons/bylaw.png";
    }

    dataGet();
  }

  dataGet() async {
    if (widget.categoryList == "Issuing Reason") {
      List<REASON_FOR_ISSUE_FOR_MG11Bean> list = [];
      offenceModel = BlocProvider.of<GlobalBloc>(context).lookupModel;
      for (var element in offenceModel!.REASON_FOR_ISSUE_FOR_MG11!) {
        list.add(element);
      }
      reassonIssueList = list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: gradientDecoration,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 0),
                    child: headingText(
                      title: widget.categoryList,
                    ),
                  ),
                  LargeSpace(),
                  TextField(
                    onChanged: (value) {
                      // Implement search functionality here
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  Expanded(
                    child: RawScrollbar(
                      trackVisibility: true,
                      thumbColor: primaryColor,
                      trackColor: Colors.black54,
                      trackRadius: const Radius.circular(20),
                      thumbVisibility: true,
                      thickness: 8,
                      radius: const Radius.circular(20),
                      scrollbarOrientation: ScrollbarOrientation.right,
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10.0),
                        itemCount: reassonIssueList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              // Navigator.pop(context, state.listData[index]!.value);
                            },
                            child: _stationListWidget(reassonIssueList[index]),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: secondryColor,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ),
            Positioned(
                top: 0, child: TopHeaderCase(title: caseTile, icon: icon)),
            const Positioned(
              bottom: 0,
              child: backButton(),
            )
          ],
        ),
      ),
    );
  }

  Widget _stationListWidget(data) {
    var deviceWidth = getWidth(context);
    return GestureDetector(
        onTap: () {
          Navigator.pop(context, data);
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60.w,
                    child: Text(
                      /*isNormalStation ? data.value :*/
                      data.lookup_data_value.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: "railLight",
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
