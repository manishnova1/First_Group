import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/TopBarwithTitle.dart';
import 'package:railpaytro/Ui/Widgets/service_list_Item.dart';
import 'package:sizer/sizer.dart';

import '../../../bloc/auth_bloc/audit_bloc.dart';
import '../../../bloc/global_bloc.dart';
import '../../../bloc/on_station_bloc/bloc_in_station.dart';
import '../../../common/service/common_offline_status.dart';
import '../../Utils/DeviceSize.dart';
import '../../Widgets/DrawerWidget.dart';
import '../../Widgets/top_header_case.dart';
import '../Role_stationsTeam/stations_list_screen.dart';

class TrainSelection extends StatefulWidget {
  final String origin;
  final String destination;
  final String time;
  final DateTime selectedTime;

  const TrainSelection(
      {Key? key,
      required this.origin,
      required this.destination,
      required this.time,
      required this.selectedTime})
      : super(key: key);

  @override
  _TrainSelectionState createState() => _TrainSelectionState();
}

class _TrainSelectionState extends State<TrainSelection> {
  bool earlierActive = true;
  bool laterActive = false;
  String menu = "";
  String? trainOrigin;
  String? trainDesitination;
  String? departureTime;
  TextEditingController departureController = TextEditingController();

  Future<void> getTrainOrigin(BuildContext context) async {
    /// Check  Auto route data receving
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StationsListScreen("")),
    );
    setState(() {
      if (result.toString() != "null") {
        trainOrigin = result.toString();
      } else {
        trainOrigin = null;
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
                  Padding(
                    padding: screenPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 7.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  laterActive = false;
                                  earlierActive = true;
                                  BlocProvider.of<OnStationBloc>(context).add(
                                      OnStationEarlyEvent(
                                          startLocation: widget.origin,
                                          endLocation: widget.destination,
                                          selectedDateTime:
                                              BlocProvider.of<OnStationBloc>(
                                                      context)
                                                  .selectedDateTime!));
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                width: 40.w,
                                decoration: BoxDecoration(
                                    color: earlierActive
                                        ? primaryColor
                                        : Colors.white,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(5))),
                                child: Center(
                                    child: Text(
                                  "Earlier Trains",
                                  style: TextStyle(
                                      color: earlierActive
                                          ? Colors.white
                                          : primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.sp),
                                )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  laterActive = true;
                                  earlierActive = false;
                                  BlocProvider.of<OnStationBloc>(context).add(
                                      OnStationLaterEvent(
                                          startLocation: widget.origin,
                                          endLocation: widget.destination,
                                          selectedDateTime:
                                              BlocProvider.of<OnStationBloc>(
                                                      context)
                                                  .selectedDateTime!));
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                width: 40.w,
                                decoration: BoxDecoration(
                                    color: laterActive
                                        ? primaryColor
                                        : Colors.white,
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        bottomRight: Radius.circular(5))),
                                child: Center(
                                    child: Text(
                                  "Later Trains",
                                  style: TextStyle(
                                      color: laterActive
                                          ? Colors.white
                                          : primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.sp),
                                )),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 3.h),
                        SizedBox(
                            child: BlocConsumer<OnStationBloc, OnStationState>(
                          builder: (context, state) {
                            if (state is OnStationSuccessState) {
                              return state.data.ASERVICELIST![0].PTD!.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          state.data.ASERVICELIST!.length,
                                      itemBuilder: (context, i) {
                                        return GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<AuditLogBloc>(
                                                    context)
                                                .add(AuditLogCallEvent());
                                            BlocProvider.of<GlobalBloc>(context)
                                                .add(GlobalSetStationEvent(
                                                    state.data.ASERVICELIST![i]
                                                        .TRAINIDENTITY!,
                                                    'train'));
                                          },
                                          child: ServiceListItemWidget(
                                              startLocation:
                                                  state.data.STARTSTATION,
                                              endLocation:
                                                  state.data.ENDSTATION,
                                              serviceid: state.data
                                                  .ASERVICELIST![i].SERVICEID,
                                              trainidenity: state
                                                  .data
                                                  .ASERVICELIST![i]
                                                  .TRAINIDENTITY,
                                              time: state
                                                  .data.ASERVICELIST![i].PTD,
                                              //time: state.data.ASERVICELIST![i].DET,
                                              toc: state
                                                  .data.ASERVICELIST![i].TOC),
                                        );
                                      })
                                  : const Center(
                                      child: Text("No Station Found"));
                            } else if (state is OnStationSuccessState) {
                              return state.data.ASERVICELIST![0].DAT!.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          state.data.ASERVICELIST!.length,
                                      itemBuilder: (context, i) {
                                        return GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<AuditLogBloc>(
                                                    context)
                                                .add(AuditLogCallEvent());
                                            BlocProvider.of<GlobalBloc>(context)
                                                .add(GlobalSetStationEvent(
                                                    state.data.ASERVICELIST![i]
                                                        .TRAINIDENTITY!,
                                                    'train'));
                                          },
                                          child: ServiceListItemWidget(
                                              startLocation:
                                                  state.data.STARTSTATION,
                                              endLocation:
                                                  state.data.ENDSTATION,
                                              serviceid: state.data
                                                  .ASERVICELIST![i].SERVICEID,
                                              trainidenity: state
                                                  .data
                                                  .ASERVICELIST![i]
                                                  .TRAINIDENTITY,
                                              time: state
                                                  .data.ASERVICELIST![i].DAT,
                                              //time: state.data.ASERVICELIST![i].DET,
                                              toc: state
                                                  .data.ASERVICELIST![i].TOC),
                                        );
                                      })
                                  : const Center(
                                      child: Text("No Station Found"));
                            } else if (state is OnStationLoadingState) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 100.0),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else {
                              return const Center(
                                  child: Text("Something went wrong"));
                            }
                          },
                          listener: (BuildContext context, Object? state) {},
                        )),
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
                  title: "Train Selection", icon: "Assets/icons/train.png")),
        ]));
  }
}
