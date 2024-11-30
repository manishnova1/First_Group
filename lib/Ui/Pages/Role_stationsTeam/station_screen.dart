import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/PrimaryButton.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/bloc/global_bloc.dart';
import '../../../common/service/common_offline_status.dart';
import 'package:sizer/sizer.dart';
import '../../../bloc/station_bloc/bloc_station_list.dart';
import '../../../common/locator/locator.dart';
import '../../../common/router/router.gr.dart';
import '../../../common/service/navigation_service.dart';
import '../../../data/local/sqlite.dart';
import '../../../data/model/auth/login_model.dart';
import '../../../data/model/station/revp_station_model.dart';
import '../../../data/model/station/station_list_model.dart';
import '../../Utils/DeviceSize.dart';
import '../../Widgets/DrawerWidget.dart';
import '../../Widgets/SpaceWidgets.dart';
import '../../Widgets/whiteButton.dart';
import 'homescreen_issue_screen.dart';

class StationScreen extends StatefulWidget {
  const StationScreen({Key? key}) : super(key: key);

  @override
  _StationScreenState createState() => _StationScreenState();
}

class _StationScreenState extends State<StationScreen> {
  String menu = "";
  String searchResult = '';

  Future<void> getFilterData(BuildContext context) async {
    final result = await locator<NavigationService>()
        .push(StationsListScreenRoute(caseType: "LOGON"));
    setState(() {
      if (result.toString() != "null") {
        searchResult = result.toString();
        BlocProvider.of<GlobalBloc>(context)
            .add(GlobalSetStationEvent(searchResult, 'station'));
      } else {
        searchResult = '';
      }
    });
  }

  final searchCOnt = TextEditingController();
  bool isNormalStation = true;

  getStationListData() async {
    List<ASTATIONBean?> listData = await SqliteDB.instance.getStationList();
    List<AREVPSTATIONBean?> listDataRevp =
        await SqliteDB.instance.getRevpStationList("LOGON");
    BlocProvider.of<StationListBloc>(context).add(StationListRefreshEvent(
        stationListModel: listData, revpStationModel: listDataRevp));
    BlocProvider.of<StationListBloc>(context)
        .add(StationFilterListEvent(search: searchCOnt.text));
  }

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          backgroundColor: primaryColor,
          actions: [CommonOfflineStatusBar(isOfflineApiRequired: false)],
        ),
        backgroundColor: secondryColor,
        body: Container(
          decoration: gradientDecoration,
          child: Padding(
            padding: screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headingText(
                  title: "Select the station you are working at:",
                ),
                LargeSpace(),
                boxtextBold(title: "Station Name"),
                SmallSpace(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
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
                                    BlocProvider.of<GlobalBloc>(context).add(
                                        GlobalSetStationEvent(
                                            state.listData[index]!.value
                                                .toString(),
                                            'station'));
                                    openAlertDialog(
                                        context,
                                        state.listData[index]!.value
                                            .toString());
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
                                    BlocProvider.of<GlobalBloc>(context).add(
                                        GlobalSetStationEvent(
                                            state.listData[index]!.STATION_NAME
                                                .toString(),
                                            'station'));
                                    openAlertDialog(
                                        context,
                                        state.listData[index]!.STATION_NAME
                                            .toString());

                                    // Navigator.pop(context,
                                    //     state.listData[index]!.STATION_NAME);
                                  },
                                  child:
                                      _stationListWidget(state.listData[index]),
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
              ],
            ),
          ),
        ));
  }

  ///dialog
  openAlertDialog(BuildContext context, String value) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                side: BorderSide(color: primaryColor, width: 2)),
            backgroundColor: blackColor,
            actionsPadding: const EdgeInsets.symmetric(horizontal: 20),
            title: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: headingText(
                title: 'You have selected',
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                        ),
                        subheadingText(title: value)
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    PrimaryButton(
                        title: "Proceed",
                        onAction: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => UnPaidFareIssueMain(
                                      isOfflineApiRequired: false)));
                        }),
                    SizedBox(
                      height: 2.h,
                    ),
                    whiteButton(
                        title: "Go Back",
                        onAction: () {
                          Navigator.pop(context, true);
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
}
