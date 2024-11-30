import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/bloc/printer_bloc/printer_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:zebrautility/ZebraPrinter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../common/locator/locator.dart';
import '../../../common/service/printing_service.dart';
import '../../../constants/app_utils.dart';
import '../../Utils/Colors.dart';
import '../../Widgets/SpaceWidgets.dart';

class PrinterSetting extends StatefulWidget {
  const PrinterSetting({Key? key}) : super(key: key);

  @override
  _PrinterSettingState createState() => _PrinterSettingState();
}

class _PrinterSettingState extends State<PrinterSetting> {
  String? printmac;
  String savePrinterName = "";

  String orientation = "";
  EnumMediaType? mediaType;
  bool isFirstTime = false;
  TextEditingController MacController = TextEditingController();

  Future<void> checkPermission() async {
    String printType = await AppUtils().getPrinterId();

    await Permission.bluetooth.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
    await Permission.bluetoothAdvertise.request();

    setState(() {
      printmac = printType;
      print(printmac.toString());
      MacController.text = printmac.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
    /*  BlocProvider.of<PrinterBloc>(context)
        .add(PrinterDiscoveryDoneEvent(false));*/
  }

  EnterMacdialog(BuildContext context) async {
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
                    title: 'Mac Address',
                  ),
                )),
            content: subheadingText(
                title:
                    "Please enter the printer MAC address without the colons."),
            actions: [
              SizedBox(
                width: 100.w,
                height: 6.8.h,
                child: TextField(
                  inputFormatters: [
                    MaskTextInputFormatter(
                        mask: '##:##:##:##:##:##',
                        filter: {"#": RegExp('^[0-9A-Z]+')}),
                  ],
                  controller: MacController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.black,
                      fontFamily: "railLight"),
                  decoration: InputDecoration(
                    hintText: 'Enter Mac address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    contentPadding: const EdgeInsets.all(10),
                    fillColor: white,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              InkWell(
                  onTap: () {
                    locator<PrintingService>()
                        .connectToPrinter(MacController.text);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    width: 100.w,
                    height: 6.8.h,
                    color: blueGrey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [subheadingTextBOLD(title: "Connect")],
                    ),
                  )),
              SizedBox(height: 2.5.h),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 7.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 15.sp,
                ),
                Text(
                  " Printer Settings",
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 0,
            title: BlocBuilder<PrinterBloc, PrinterState>(
              builder: (context, state) {
                if (state is PrinterSelectedState) {
                  return Text(
                    BlocProvider.of<PrinterBloc>(context).name,
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  );
                } else {
                  return BlocProvider.of<PrinterBloc>(context).name.isNotEmpty
                      ? Text(
                          BlocProvider.of<PrinterBloc>(context).name,
                          style:
                              TextStyle(color: Colors.white, fontSize: 14.sp),
                        )
                      : Container();
                }
              },
            ),
            trailing: Icon(
              Icons.bluetooth_connected_sharp,
              color: Colors.white,
              size: 12.sp,
            ),
            subtitle: BlocBuilder<PrinterBloc, PrinterState>(
              builder: (context, state) {
                if (state is PrinterStatusUpdateState &&
                    state.status == "Connected") {
                  // savePrinterName = MacController.text;
                  AppUtils().setPrinterId(MacController.text);
                }

                if (state is PrinterStatusUpdateState) {
                  return Text(
                    state.status,
                    style: TextStyle(
                        color: state.status == "Connected"
                            ? Colors.lightGreen
                            : Colors.red,
                        fontSize: 13.sp),
                  );
                } else {
                  return Text(
                      BlocProvider.of<PrinterBloc>(context).status.isNotEmpty
                          ? BlocProvider.of<PrinterBloc>(context).status
                          : "Disconnected",
                      style: TextStyle(
                          color: BlocProvider.of<PrinterBloc>(context).status ==
                                  "Connected"
                              ? Colors.lightGreen
                              : Colors.red,
                          fontFamily: "railLight"));
                }
              },
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 0,
            onTap: () {
              EnterMacdialog(context);
            },
            title: Text(
              "Manual Enter MacAddress",
              style: TextStyle(color: Colors.white, fontSize: 13.sp),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          subheadingTextBOLD(title: "Available Devices"),
          const Divider(
            color: Colors.white54,
          ),
          BlocBuilder<PrinterBloc, PrinterState>(builder: (context, state) {
            if (state is PrinterDiscoveryDoneState) {
              return BlocProvider.of<PrinterBloc>(context).isDiscoveryDone
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: BlocProvider.of<PrinterBloc>(context)
                          .printerListFound
                          .entries
                          .length,
                      itemBuilder: (context, i) {
                        MapEntry printerListFound =
                            BlocProvider.of<PrinterBloc>(context)
                                .printerListFound
                                .entries
                                .elementAt(i);

                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          minVerticalPadding: 0,
                          horizontalTitleGap: 0,
                          onTap: () {
                            BlocProvider.of<PrinterBloc>(context).add(
                                PrinterToConnectEvent(
                                    printerListFound.value["name"],
                                    printerListFound.value["ipAddress"],
                                    printerListFound.value["isWifiPrinter"]));
                          },
                          leading: const Icon(
                            Icons.print_outlined,
                            color: Colors.white,
                          ),
                          title: Text(printerListFound.value["name"],
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 10.sp)),
                        );
                      })
                  : Column(
                      children: [
                        SmallSpace(),
                        Text(
                          "No printers available",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.white, fontSize: 10.sp),
                        ),
                      ],
                    );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: BlocProvider.of<PrinterBloc>(context)
                      .printerListFound
                      .entries
                      .length,
                  itemBuilder: (context, i) {
                    MapEntry printerListFound =
                        BlocProvider.of<PrinterBloc>(context)
                            .printerListFound
                            .entries
                            .elementAt(i);

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      minVerticalPadding: 0,
                      horizontalTitleGap: 0,
                      onTap: () {
                        locator<PrintingService>().connectToPrinter(
                            printerListFound.value["ipAddress"]);
                        //    }
                      },
                      leading: const Icon(
                        Icons.print_outlined,
                        color: Colors.white,
                      ),
                      title: printmac.toString().isEmpty
                          ? Text(printerListFound.value["name"])
                          : Text(printmac.toString(),
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 10.sp)),
                    );
                  });
            }
          }),
        ]),
      ),
    );
  }
}
