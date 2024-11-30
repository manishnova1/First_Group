import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/bloc/station_bloc/bloc_station_list.dart';
import 'package:railpaytro/data/model/station/revp_station_model.dart';
import 'package:sizer/sizer.dart';
import '../../../common/service/common_offline_status.dart';
import '../../../data/local/sqlite.dart';
import '../../../data/model/auth/login_model.dart';
import '../../../data/model/station/station_list_model.dart';
import '../../Utils/DeviceSize.dart';
import '../../Widgets/DrawerWidget.dart';
import '../../Widgets/backButton.dart';
import '../../Widgets/top_header_case.dart';

class StationsListScreen extends StatefulWidget {
  String caseType;

  StationsListScreen(this.caseType, {Key? key}) : super(key: key);

  @override
  _StationsListScreenState createState() => _StationsListScreenState();
}

class _StationsListScreenState extends State<StationsListScreen> {
  String menu = "";
  final searchCOnt = TextEditingController();
  bool isNormalStation = true;
  String caseTitle = "";
  String icon = "";

  getStationListData() async {
    if (mounted) {
      List<ASTATIONBean?> listData = await SqliteDB.instance.getStationList();
      List<AREVPSTATIONBean?> listDataRevp =
          await SqliteDB.instance.getRevpStationList(widget.caseType);
      BlocProvider.of<StationListBloc>(context).add(StationListRefreshEvent(
          stationListModel: listData, revpStationModel: listDataRevp));
      BlocProvider.of<StationListBloc>(context)
          .add(StationFilterListEvent(search: searchCOnt.text));
    }
  }

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
    if (widget.caseType == "UFN (HT)") {
      caseTitle = "Unpaid Fare Notice (HT)";
      icon = "Assets/icons/bandge.png";
    }

    if (widget.caseType == "ufn") {
      caseTitle = "Unpaid Fare Notice (LUMO)";
      icon = "Assets/icons/bandge.png";
    }
    if (widget.caseType == "TEST") {
      caseTitle = "Test Notice";
      icon = "Assets/icons/warning.png";
    }
    if (widget.caseType == "MG11") {
      caseTitle = "Byelaw Infringement Penalty";
      icon = "Assets/icons/bylaw.png";
    }
    if (widget.caseType == "XZ") {
      caseTitle = "Intelligence Report";
      icon = "Assets/icons/warning.png";
    }

    checkUser();
    getStationListData();

    searchCOnt.addListener(() {
      BlocProvider.of<StationListBloc>(context)
          .add(StationFilterListEvent(search: searchCOnt.text));
    });
  }

  checkUser() async {
    LoginModel user = await SqliteDB.instance.getLoginModelData();
    isNormalStation = user.RAILPAYSTATIONTYPE == "Common";
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = getHeight(context);
    return Scaffold(
      backgroundColor: secondryColor,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: [CommonOfflineStatusBar(isOfflineApiRequired: false)],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 100.h,
              width: 100.w,
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
                        title: "Stations",
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: TextField(
                      controller: searchCOnt,
                      decoration: InputDecoration(
                        hintText: ' Search...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        suffixIcon: Icon(
                          Icons.search,
                          size: 20,
                          color: primaryColor,
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        fillColor: white,
                      ),
                      onChanged: (string) {
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Expanded(
                    child: BlocBuilder<StationListBloc, StationListState>(
                      builder: (context, state) {
                        if (state is StationListLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is StationListSuccessState) {
                          return RawScrollbar(
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
                                itemCount: state.listData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pop(context,
                                          state.listData[index]!.value);
                                    },
                                    child: _stationListWidget(
                                        state.listData[index]!.value),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    color: secondryColor,
                                  );
                                },
                              ));
                        } else if (state is StationRevpListSuccessState) {
                          return RawScrollbar(
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
                                itemCount: state.listData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pop(context,
                                          state.listData[index]!.STATION_NAME);
                                    },
                                    child: _stationListWidget(
                                        state.listData[index]),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    color: secondryColor,
                                  );
                                },
                              ));
                        } else {
                          return const Center(
                            child: Text(
                              "Something Went Wrong",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              child: TopHeaderCase(title: caseTitle, icon: icon),
            ),
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
        child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              child: Image.asset(
            "Assets/icons/train.png",
            width: 6.w,
            color: primaryColor,
          )),
          SizedBox(
            width: 4.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                /*isNormalStation ? data.value :*/
                data.STATION_NAME,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: "railLight"),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                  width: 65.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${/*isNormalStation ? data.code :*/ data.CRS_CODE}",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10.sp,
                              fontFamily: "railLight")),
                      Text("${/*isNormalStation ? data.code :*/ data.NLC_CODE}",
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10.sp,
                              fontFamily: "railLight")),
                    ],
                  ))
            ],
          ),
        ],
      ),
    ));
  }
}
