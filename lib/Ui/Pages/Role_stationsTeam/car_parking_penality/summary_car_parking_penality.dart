import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/car_parking_penality/print_summary_car_parking.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/SecondryButton.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/Ui/Widgets/TopBarwithTitle.dart';
import 'package:railpaytro/Ui/Widgets/summaryBox.dart';
import 'package:railpaytro/bloc/car_parking_pelanty_bloc/bloc_car_penalty_submit.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/service/common_offline_status.dart';
import '../../../Utils/DeviceSize.dart';
import '../../../Widgets/DividerShadow.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/PrimaryButton.dart';
import '../../../Widgets/ProgressBox.dart';
import '../../../Widgets/SpaceWidgets.dart';
import '../../../Widgets/backButton.dart';
import '../../../Widgets/progress_bar.dart';
import '../../../Widgets/top_header_case.dart';

class SummaryCarParking extends StatefulWidget {
  Map<String, dynamic> data;
  List imagesList;

  SummaryCarParking(this.data, this.imagesList);

  @override
  _SummaryCarParkingState createState() => _SummaryCarParkingState();
}

class _SummaryCarParkingState extends State<SummaryCarParking> {
  String caseRef = "";

  @override
  void initState() {
    // TODO: implement initState

    caseRef = BlocProvider.of<PenaltySubmitBloc>(context).caseReferance;

    super.initState();
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
      body: Stack(
        children: [
          Container(
            width: 100.w,
            height: 100.h,
            decoration: gradientDecoration,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
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
                                  deviceWidth: 20.w,
                                  color: primaryColor.withOpacity(.5)),
                              ProgressBar(
                                  deviceWidth: 20.w,
                                  color: primaryColor.withOpacity(.5)),
                              ProgressBar(
                                  deviceWidth: 20.w, color: primaryColor),
                              ProgressBar(deviceWidth: 20.w, color: blueGrey),

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
                        headingTextOne(title: "PCN Summary"),
                        LargeSpace(),
                        boxtextSmall(title: "Notice Reference"),
                        subheadingTextBOLD(title: "$caseRef"),
                        LargeSpace(),
                        SmallSpace(),
                        summaryBox(
                            title: "Offence Date & Time:",
                            value: widget.data['offencetime']),
                        SmallSpace(),
                        DividerShadow(),
                        LargeSpace(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 43.w,
                              child: boxtextMediumBold(
                                  title: "Registration Number:"),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                  color: Colors.orangeAccent,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                "${widget.data['vehicle']}",
                                style: TextStyle(
                                  fontFamily: "railBold",
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SmallSpace(),
                        DividerShadow(),
                        LargeSpace(),
                        summaryBox(
                            title: "Vehicle Make:", value: widget.data['make']),
                        SmallSpace(),
                        DividerShadow(),
                        LargeSpace(),
                        summaryBox(
                            title: "Vehicle Model:",
                            value: widget.data['model']),
                        SmallSpace(),
                        DividerShadow(),
                        LargeSpace(),
                        summaryBox(
                            title: "Vehicle Colour:",
                            value: widget.data['color']),
                        SmallSpace(),
                        DividerShadow(),
                        LargeSpace(),
                        summaryBox(
                            title: "Location:",
                            value:
                                "${widget.data['station']}, ${widget.data['location']['location_name']}"),
                        SmallSpace(),
                        DividerShadow(),
                        LargeSpace(),
                        summaryBox(
                            title: "Offence Committed:",
                            value: widget.data['reason_title']),
                        SmallSpace(),
                        DividerShadow(),
                        LargeSpace(),
                        summaryBox(
                            title: "Photos:",
                            value:
                                "${widget.imagesList.length} photo taken as evidence"),
                        SmallSpace(),
                        DividerShadow(),
                        LargeSpace(),
                        LargeSpace(),
                        Container(
                            width: 100.w,
                            child: BlocListener<PenaltySubmitBloc,
                                    PenaltySubmitState>(
                                listener: (BuildContext context, state) {
                              if (state is PenaltySubmitSuccessState) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PrintSummaryCarParking(
                                                widget.data,
                                                widget.imagesList,
                                                state.refCaseId)));
                              } else if (state is PenaltySavedSuccessState) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PrintSummaryCarParking(
                                                widget.data,
                                                widget.imagesList,
                                                state.refCaseId)));
                              } else {}
                            }, child: BlocBuilder<PenaltySubmitBloc,
                                    PenaltySubmitState>(
                              builder: (context, latLonState) {
                                if (latLonState is GetLatLongEvent) {
                                  return PrimaryButton(
                                      title: "Submit Penalty Notice",
                                      onAction: () {
                                        BlocProvider.of<PenaltySubmitBloc>(
                                                context)
                                            .add(PenaltySubmitSubmitEvent(
                                          data: widget.data,
                                          imageCount: widget.imagesList.length
                                              .toString(),
                                          context: context,
                                          lat: latLonState.lat ?? "",
                                          long: latLonState.long ?? "",
                                        ));
                                      });
                                } else {
                                  return Container();
                                }
                              },
                            ))),
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
                  title: "Penalty Charge Notice ",
                  icon: "Assets/icons/car.png")),
          Positioned(bottom: 0, child: backButton())
        ],
      ),
    );
  }
}
