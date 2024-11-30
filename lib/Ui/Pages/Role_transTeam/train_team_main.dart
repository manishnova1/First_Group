import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import '../../../common/Utils/utils.dart';
import '../../../common/service/common_offline_status.dart';
import 'package:railpaytro/Ui/Widgets/PrimaryButton.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/Ui/Widgets/TopBarBack.dart';
import 'package:railpaytro/bloc/on_station_bloc/bloc_in_station.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/DeviceSize.dart';
import '../../Widgets/DrawerWidget.dart';
import '../../Widgets/SpaceWidgets.dart';
import '../../Widgets/backButton.dart';
import '../../Widgets/top_header_case.dart';
import '../../trainselect2.dart';
import '../Role_stationsTeam/stations_list_screen.dart';

class TrainTeamMain extends StatefulWidget {
  @override
  _TrainTeamMainState createState() => _TrainTeamMainState();
}

class _TrainTeamMainState extends State<TrainTeamMain> {
  String menu = "";
  String trainOrigin = "";
  String trainDesitination = "";
  String? departureTime;
  DateTime? selectedDuration;
  TextEditingController departureController = TextEditingController();

  Future<void> getTrainOrigin(BuildContext context) async {
    /// Check  Auto route data receving
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StationsListScreen2("")),
    );
    setState(() {
      if (result.toString() != "null") {
        trainOrigin = result.toString();
      } else {
        trainOrigin = '';
      }
    });
  }

  Future<void> getTrainDestination(BuildContext context) async {
    /// Check  Auto route data receving
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StationsListScreen2("")),
    );
    setState(() {
      if (result.toString() != "null") {
        trainDesitination = result.toString();
      } else {
        trainDesitination = '';
      }
    });
  }

  openErrorDialogForVerication(BuildContext context) async {
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
            content: subheadingText(title: "App is offline."),
            actions: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    width: 30.w,
                    height: 5.5.h,
                    color: primaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [subheadingTextBOLD(title: "OK")],
                    ),
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
    super.initState();
    selectedDuration = DateTime.now();
    departureTime = DateFormat("HH:mm").format(selectedDuration!);
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = getWidth(context);
    var deviceHeight = getHeight(context);
    return Scaffold(
        backgroundColor: secondryColor,
        drawer: const DrawerWidget(),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TopBarBack(deviceHeight: deviceHeight, deviceWidth: deviceWidth),
                  SizedBox(height: 7.h),
                  Padding(
                    padding: screenPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headingText(
                          title: "Please enter the train you are\nworking on",
                        ),
                        MediumSpace(),
                        subheadingText(
                          title: "Please enter station name ",
                        ),
                        LargeSpace(),
                        boxtextBold(title: "Train Origin"),
                        SmallSpace(),
                        GestureDetector(
                          onTap: () {
                            getTrainOrigin(context);
                          },
                          child: Container(
                            width: 100.w,
                            height: 6.4.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  const Icon(CupertinoIcons.location),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    trainOrigin.isEmpty
                                        ? "Search Station..."
                                        : trainOrigin.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        LargeSpace(),
                        boxtextBold(title: "Train Destination"),
                        SmallSpace(),
                        GestureDetector(
                          onTap: () {
                            getTrainDestination(context);
                          },
                          child: Container(
                            width: 100.w,
                            height: 6.4.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  const Icon(CupertinoIcons.location),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    trainDesitination.isEmpty
                                        ? "Search Station..."
                                        : trainDesitination.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        LargeSpace(),
                        boxtextBold(title: "Departure Time"),
                        SmallSpace(),
                        Container(
                            height: 14.h,
                            child: CupertinoTheme(
                                data: CupertinoThemeData(
                                  textTheme: CupertinoTextThemeData(
                                    dateTimePickerTextStyle: TextStyle(
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  brightness: Brightness.dark,
                                ),
                                child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.time,
                                    use24hFormat: true,
                                    onDateTimeChanged: (newDateTime) {
                                      setState(() {
                                        departureTime = DateFormat("HH:mm")
                                            .format(newDateTime);
                                        selectedDuration = newDateTime!;
                                      });
                                    }))),
                        SmallSpace(),
                        LargeSpace(),
                        MediumSpace(),
                        PrimaryButton(
                            title: "Search",
                            onAction: () async {
                              if (trainOrigin.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Train Origin Can\'t be Empty",
                                    backgroundColor: Colors.black);
                              } else if (trainDesitination.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Train Destination Can\'t be Empty",
                                    backgroundColor: Colors.black);
                              } else {
                                bool checkInternet =
                                    await Utils.checkInternet();
                                if (checkInternet) {
                                  BlocProvider.of<OnStationBloc>(context).add(
                                      OnStationRefreshEvent(
                                          startLocation: trainOrigin,
                                          endLocation: trainDesitination,
                                          time: departureTime,
                                          selectedDateTime: selectedDuration));
                                } else {
                                  openErrorDialogForVerication(context);
                                }
                              }
                            }),
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
                  title: "Station Selection", icon: "Assets/icons/train.png")),
          const Positioned(
            bottom: 0,
            child: backButton(),
          )
        ]));
  }
}
