
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

class pfn_offender_lookups_list extends StatefulWidget {
  String caseType;
  String categoryList;
  String exrta;

  pfn_offender_lookups_list(this.caseType, this.categoryList, this.exrta,
      {Key? key})
      : super(key: key);

  @override
  _pfn_offender_lookups_listState createState() =>
      _pfn_offender_lookups_listState();
}

class _pfn_offender_lookups_listState extends State<pfn_offender_lookups_list> {
  String menu = "";
  final searchCOnt = TextEditingController();
  List<PERSON_ETHNICITYBean> ethnicityList = [];
  PERSON_ETHNICITYBean? selectedEthnicity;
  List<String> hairColorList = [];

  // List<String> eyeColorLists=[];

  bool taatoo = false;
  bool occupationBool = false;
  bool buildBool = false;
  bool ethnicityBool = false;
  bool eyeBool = false;
  bool hairBool = false;
  bool glassesBool = false;
  bool facialBool = false;
  LookupModel? lookupModel;

  List<PERSON_HAIR_COLOURBean> hairList = [];
  PERSON_HAIR_COLOURBean? selectedHairColor;

  List<PERSON_EYE_COLOURBean> eyeColorList = [];
  PERSON_EYE_COLOURBean? selectedEye;

  List<PERSON_BUILDBean> buildList = [];
  PERSON_BUILDBean? selectedBuild;

  List<PERSON_GLASSESBean> glassesList = [];
  PERSON_GLASSESBean? selectedGlasses;

  List<PERSON_FACIAL_HAIR_TYPEBean> beardList = [];
  PERSON_FACIAL_HAIR_TYPEBean? selectedBeard;

  List<OCCUPATIONBean> occupationList = [];
  OCCUPATIONBean? selectedOccupation;
  String caseTitle = "";
  String icon = "";
  late LookupModel? lookup;

  @override
  void initState() {
    super.initState();
    if (widget.caseType == "PCN") {
      caseTitle = "Penalty Charge Notice";
      icon = "Assets/icons/car.png";
    }
    if (widget.caseType == "") {
      caseTitle = "Station list";
      icon = "Assets/icons/train.png";
    }

    if (widget.caseType == "UFN") {
      caseTitle = "Unpaid Fare Notice (LUMO)";
      icon = "Assets/icons/bandge.png";
    }
    if (widget.caseType == "UFN(HT)") {
      caseTitle = "Unpaid Fare Notice (HT)";
      icon = "Assets/icons/bandge.png";
    }
    if (widget.caseType == "TEST") {
      caseTitle = "Test Notice";
      icon = "Assets/icons/warning.png";
    }
    if (widget.caseType == "MG11") {
      caseTitle = "MG11";
      icon = "Assets/icons/bank.png";
    }
    if (widget.caseType == "XZ") {
      caseTitle = "Intelligence Report";
      icon = "Assets/icons/warning.png";
    }

    dataGet();
  }

  dataGet() {
    lookup = BlocProvider.of<GlobalBloc>(context).lookupModel;

    if (widget.categoryList == "Ethnicity") {
      setState(() {
        ethnicityBool = true;
        List<PERSON_ETHNICITYBean> list = [];
        lookupModel = BlocProvider.of<GlobalBloc>(context).lookupModel;
        for (var element in lookupModel!.PERSON_ETHNICITY!) {
          list.add(element);
        }

        ethnicityList = list;
      });
    }
    if (widget.categoryList == "Build") {
      setState(() {
        buildBool = true;

        List<PERSON_BUILDBean> list = [];
        lookupModel = BlocProvider.of<GlobalBloc>(context).lookupModel;
        for (var element in lookupModel!.PERSON_BUILD!) {
          list.add(element);
        }

        buildList = list;
      });
    }
    if (widget.categoryList == "Occupation") {
      setState(() {
        occupationBool = true;
        List<OCCUPATIONBean> list = [];
        lookupModel = BlocProvider.of<GlobalBloc>(context).lookupModel;
        for (var element in lookupModel!.OCCUPATION!) {
          list.add(element);
        }

        occupationList = list;
      });
    }
    if (widget.categoryList == "Hair Colour and Style") {
      setState(() {
        hairBool = true;
        List<PERSON_HAIR_COLOURBean> list = [];
        lookupModel = BlocProvider.of<GlobalBloc>(context).lookupModel;
        for (var element in lookupModel!.PERSON_HAIR_COLOUR!) {
          list.add(element);
        }

        hairList = list;
      });
    }
    if (widget.categoryList == "Eye Colour") {
      setState(() {
        eyeBool = true;
        List<PERSON_EYE_COLOURBean> list = [];
        lookupModel = BlocProvider.of<GlobalBloc>(context).lookupModel;
        for (var element in lookupModel!.PERSON_EYE_COLOUR!) {
          list.add(element);
        }

        eyeColorList = list;
      });
    }
    if (widget.categoryList == "Glasses") {
      setState(() {
        glassesBool = true;
        List<PERSON_GLASSESBean> list = [];
        lookupModel = BlocProvider.of<GlobalBloc>(context).lookupModel;
        for (var element in lookupModel!.PERSON_GLASSES!) {
          list.add(element);
        }

        glassesList = list;
      });
    }
    if (widget.categoryList == "Facial Hair") {
      setState(() {
        facialBool = true;
        List<PERSON_FACIAL_HAIR_TYPEBean> list = [];
        lookupModel = BlocProvider.of<GlobalBloc>(context).lookupModel;
        for (var element in lookupModel!.PERSON_FACIAL_HAIR_TYPE!) {
          list.add(element);
        }

        beardList = list;
      });
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
                  Visibility(
                    visible: ethnicityBool,
                    child: Expanded(
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
                            itemCount: ethnicityList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  // Navigator.pop(context,state.listData[index]!.value);
                                },
                                child: _stationListWidget(ethnicityList[index]),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: secondryColor,
                              );
                            },
                          )),
                    ),
                  ),
                  Visibility(
                    visible: buildBool,
                    child: Expanded(
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
                            itemCount: buildList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  // Navigator.pop(context,state.listData[index]!.value);
                                },
                                child: _stationListWidget(buildList[index]),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: secondryColor,
                              );
                            },
                          )),
                    ),
                  ),
                  Visibility(
                    visible: occupationBool,
                    child: Expanded(
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
                            itemCount: occupationList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  // Navigator.pop(context,state.listData[index]!.value);
                                },
                                child:
                                    _stationListWidget(occupationList[index]),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: secondryColor,
                              );
                            },
                          )),
                    ),
                  ),
                  Visibility(
                    visible: hairBool,
                    child: Expanded(
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
                            itemCount: hairList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  // Navigator.pop(context,state.listData[index]!.value);
                                },
                                child: _stationListWidget(hairList[index]),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: secondryColor,
                              );
                            },
                          )),
                    ),
                  ),
                  Visibility(
                    visible: glassesBool,
                    child: Expanded(
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
                            itemCount: glassesList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  // Navigator.pop(context,state.listData[index]!.value);
                                },
                                child: _stationListWidget(glassesList[index]),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: secondryColor,
                              );
                            },
                          )),
                    ),
                  ),
                  Visibility(
                    visible: eyeBool,
                    child: Expanded(
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
                            itemCount: eyeColorList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  // Navigator.pop(context,state.listData[index]!.value);
                                },
                                child: _stationListWidget(eyeColorList[index]),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: secondryColor,
                              );
                            },
                          )),
                    ),
                  ),
                  Visibility(
                    visible: facialBool,
                    child: Expanded(
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
                            itemCount: beardList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  // Navigator.pop(context,state.listData[index]!.value);
                                },
                                child: _stationListWidget(beardList[index]),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: secondryColor,
                              );
                            },
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ),
            Positioned(
                top: 0, child: TopHeaderCase(title: caseTitle, icon: icon)),
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
