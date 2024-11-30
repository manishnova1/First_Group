import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/car_parking_penality/capture_image_car_parking.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/bloc/car_parking_pelanty_bloc/bloc_car_penalty_submit.dart';
import 'package:railpaytro/bloc/printer_bloc/printer_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../common/locator/locator.dart';
import '../../../../common/router/router.gr.dart';
import '../../../../common/service/common_offline_status.dart';
import '../../../../common/service/dialog_service.dart';
import '../../../../common/service/navigation_service.dart';
import '../../../Utils/DeviceSize.dart';
import '../../../Utils/common_printer_dialog.dart';
import '../../../Widgets/DrawerWidget.dart';
import '../../../Widgets/PrimaryButton.dart';
import '../../../Widgets/SecondryButton.dart';
import '../../../Widgets/progress_bar.dart';
import '../../../Widgets/top_header_case.dart';
import '../../../Widgets/whiteButton.dart';

class PrintSummaryCarParking extends StatefulWidget {
  Map<String, dynamic> data;
  List imagesList;
  var caseRefNo;

  PrintSummaryCarParking(this.data, this.imagesList, this.caseRefNo);

  @override
  _PrintSummaryCarParkingState createState() => _PrintSummaryCarParkingState();
}

class _PrintSummaryCarParkingState extends State<PrintSummaryCarParking> {
  String caseRef = "";

  // FlutterBlue flutterBlue = FlutterBlue.instance;
  @override
  void initState() {
    // TODO: implement initState

    caseRef = BlocProvider.of<PenaltySubmitBloc>(context).caseReferance;

    super.initState();
  }

  onPrintSucessDialog(BuildContext context) async {
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: headingText(
                    title: 'Print Successful',
                  ),
                )),
                Image.asset(
                  "Assets/icons/success.png",
                  width: 10.w,
                  fit: BoxFit.cover,
                )
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SecondryButton(
                              title: "Add photographic evidence",
                              onAction: () {
                                Navigator.pop(context, true);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CaputreImageCarParking(
                                                widget.data,
                                                widget.imagesList,
                                                widget.caseRefNo)));
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                              title: "Return to Menu",
                              onAction: () {
                                locator<NavigationService>().pushAndRemoveUntil(
                                    UnPaidFareIssueMainRoute(
                                        isOfflineApiRequired: false));
                              }),
                        ),
                      ],
                    ),
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
        alignment: Alignment.center,
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
                                  deviceWidth: 20.w,
                                  color: primaryColor.withOpacity(.5)),
                              ProgressBar(
                                  deviceWidth: 20.w, color: primaryColor),

                              /* const SizedBox(
                                        width: 10,
                                      ),
                                      ProgressBox(deviceWidth: deviceWidth, color: primaryColor),*/
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            headingTextthree(title: "PCN Successful"),
                            Image.asset(
                              "Assets/icons/success.png",
                              width: 20.w,
                              height: 10.h,
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                        boxtextBoldStart3(title: "Notice Reference:"),
                        SizedBox(height: 1),
                        subheadingTextBOLD2(title: "${widget.caseRefNo}"),
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
          Positioned(
              bottom: 0,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CaputreImageCarParking(
                              widget.data,
                              widget.imagesList,
                              widget.caseRefNo)));
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  width: 100.w,
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
              )),
          Positioned(
            bottom: 20.h,
            child: Row(
              children: [
                BlocListener<PrinterBloc, PrinterState>(
                  listener: (context, state) {
                    if (state is PrinterCheckStatusHeadState) {
                      if (state.status == "Connected") {
                        CommonPrinterDialog().startPrintingDialog(context);
                        (widget.data as Map<String, Object?>)
                            .addAll({"case_ref_num": " ${widget.caseRefNo}"});
                        BlocProvider.of<PrinterBloc>(context).add(
                            PrinterCaseEvent(
                                data: widget.data,
                                type: "PCN",
                                context: context));
                      } else {
                        CommonPrinterDialog()
                            .showPrinterStatusDialog(context, state.status);
                      }
                    } else if (state is PrintingDoneState) {
                      if (state.status == "Failed") {
                        Navigator.pop(context);
                        CommonPrinterDialog().cancelPrinterDialog(context,
                            onPressed: () {
                          Navigator.pop(context, true);
                          if (BlocProvider.of<PrinterBloc>(context).status ==
                              "Connected") {
                            BlocProvider.of<PrinterBloc>(context)
                                .add(PrinterCheckStatusEvent());
                          } else {
                            CommonPrinterDialog().showPrinterDialog(context);
                          }
                        });
                      } else if (state.status == "Done") {
                        Navigator.of(context).pop();

                        locator<DialogService>().commonSuccessDialog(context,
                            continueAction: () {
                          Navigator.pop(context);
                          onPrintSucessDialog(context);
                        }, rePrintAction: () {
                          Navigator.pop(context);
                          if (BlocProvider.of<PrinterBloc>(context).status ==
                              "Connected") {
                            BlocProvider.of<PrinterBloc>(context)
                                .add(PrinterCheckStatusEvent());
                          } else {
                            CommonPrinterDialog().showPrinterDialog(context);
                          }
                        });
                      }
                    } else if (state is PrinterCommandReadyToPrintState) {
                      BlocProvider.of<PrinterBloc>(context)
                          .add(PrinterPrintCommandEvent(state.zplCommand));
                    }
                  },
                  child: GestureDetector(
                    onTap: () {
                      if (BlocProvider.of<PrinterBloc>(context).status ==
                          "Connected") {
                        BlocProvider.of<PrinterBloc>(context)
                            .add(PrinterCheckStatusEvent());
                      } else {
                        CommonPrinterDialog().showPrinterDialog(context);
                      }
                    },
                    child: Container(
                      width: 88.w,
                      decoration: BoxDecoration(
                        color: blueGrey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            boxtextBold(title: "Print PCN"),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(Icons.print, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
// Future<bool> _checkDeviceBluetoothIsOn() async {
//   return await flutterBlue.isOn;
// }
}
