import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:railpaytro/Ui/Pages/HomeScreen.dart';
import 'package:railpaytro/Ui/Pages/change_current_password.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/offline_sync.dart';
import '../../bloc/printer_bloc/printer_bloc.dart';
import '../../bloc/ufn_luno_bloc/address_screen_bloc.dart';
import '../../common/Utils/utils.dart';
import '../../common/locator/locator.dart';
import '../../common/service/navigation_service.dart';
import '../../common/service/printing_service.dart';
import '../../common/service/toast_service.dart';
import '../../data/constantes/constants.dart';
import '../../data/model/auth/login_model.dart';
import '../Pages/PrinterSetting/PrinterSettings.dart';
import '../Utils/Colors.dart';
import 'TextWidgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:railpaytro/Ui/Widgets/Dialogtextbox2.dart';
import '../../bloc/auth_bloc/setting_bloc.dart';
import '../../bloc/global_bloc.dart';
import '../../common/router/router.gr.dart';
import '../../common/service/navigation_service.dart';
import '../../constants/app_utils.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/auth/login_model.dart';
import '../../data/model/summaryModel.dart';
import '../Utils/Colors.dart';
import '../Widgets/Dialogtextbox.dart';
import '../Widgets/PrimaryButton.dart';
import '../Widgets/SecondryButton.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  double totalValue = 0;
  double totalPaid = 0;
  double pfnIssued = 0;
  double mg11Issued = 0;
  double ufnIssued = 0;
  double ufnHTIssued = 0;
  double pcnIssued = 0;
  int pfnCount = 0;
  int mg11Count = 0;
  int ufnCount = 0;
  int ufnhtCount = 0;
  int pcnCount = 0;
  int totalNoofNotice = 0;

  openLogoutDialog(BuildContext context, var data) async {
    LoginModel user = await SqliteDB.instance.getLoginModelData();
    String sessionStartTime = await AppUtils().getUserSessionIn();
    String printType = await AppUtils().getPrinterId();

    String sessionEndtime =
        DateFormat("d MMM yyyy  kk:mm").format(DateTime.now());
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
                width: MediaQuery.of(context).size.width * 0.10,
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: Text(
                    "End of Shift Summary ",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 17.sp,
                        color: Colors.white),
                  ),
                )),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DialogTextbox(
                        title: "Username:", subtitle: user.STUSER!.SUSERNAME!),
                    DialogTextbox(
                        title: "Shift Started:", subtitle: sessionStartTime),
                    // DialogTextbox(
                    //     title: "Session Ended:", subtitle: sessionEndtime),
                    // DialogTextbox(
                    //     title: "Car Park Penalty issued:",
                    //     subtitle: "$pcnCount "
                    //     //(£${pcnIssued.toStringAsFixed(2)})
                    //     ),
                    DialogTextbox(
                        title: "Unpaid Fare Notice(LUMO) issued:",
                        subtitle: "$ufnCount "
                        //(£${ufnIssued.toStringAsFixed(2)})
                        ),
                    DialogTextbox(
                        title: "Unpaid Fare Notice(HT) issued:",
                        subtitle: "$ufnhtCount "
                        //(£${ufnIssued.toStringAsFixed(2)})
                        ),
                    // DialogTextbox(
                    //     title: "Penalty Fare Notice issued:",
                    //     subtitle: "$pfnCount"
                    //     // (£${pfnIssued.toStringAsFixed(2)})
                    //     ),
                    // DialogTextbox(title: "MG11 issued:", subtitle: "$mg11Count "
                    //     //(£${mg11Issued.toStringAsFixed(2)})
                    //     ),
                    DialogTextbox(
                        title: "Total No. of Notices issued:",
                        subtitle: "$totalNoofNotice"),
                    // DialogTextbox(
                    //     title: "Total Value of Notice issued:",
                    //     subtitle: ""
                    //     //"£${totalValue.toStringAsFixed(2)}"
                    // ),
                    // DialogTextbox(
                    //     title: "Total Payments Received:",
                    //     subtitle: ""
                    // //    "£${totalPaid.toStringAsFixed(2)}"
                    // ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Are you sure you want to log out and end this shift?",
                      style: TextStyle(fontSize: 12.sp, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SecondryButton(
                              title: "No",
                              onAction: () {
                                Navigator.pop(context, true);
                              }),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: BlocListener<SettingsBloc, SettingsState>(
                                listener: (context, state) {
                                  if (state is SettingsSuccessState) {
                                    BlocProvider.of<GlobalBloc>(context).add(
                                        GlobalSetStationEvent("", 'station'));
                                  }
                                },
                                child: PrimaryButton(
                                    title: "Yes, Logout",
                                    onAction: () async {
                                      BlocProvider.of<AddressUfnBloc>(context)
                                          .submitAddressMap
                                          .clear();
                                      if (printType != "") {
                                        locator<PrintingService>().disconnect();
                                        AppUtils().setPrinterId("");
                                      }
                                      Navigator.pop(context, true);
                                      BlocProvider.of<SettingsBloc>(context)
                                          .add(SettingsLogOutEvent());
                                    }))),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  openAppInfoDialog(BuildContext context) async {
    bool checkInternet = await Utils.checkInternet();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;

    LoginModel user = await SqliteDB.instance.getLoginModelData();

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
                  child: Text(
                    "App Information",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15.sp,
                        color: Colors.white),
                  ),
                )),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DialogTextbox2(
                        title: "User:", subtitle: user.STUSER!.SUSERNAME!),
                    DialogTextbox2(title: "App Version:", subtitle: "$version"),
                    DialogTextbox2(
                        title: "Current Status:",
                        subtitle: checkInternet ? "Online" : "Offline"),
                    // DialogTextbox2(
                    //     title: "Last Checked for Updates:", subtitle: "N/A"),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                              title: "Close",
                              onAction: () {
                                Navigator.pop(context, true);
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  openErrorDialog(BuildContext context) async {
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
                    title: 'E M R  is offline ',
                  ),
                )),
            content: subheadingText(
                title: "The internet connection appears to be offline."),
            actions: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    "Assets/icons/cross.png",
                    width: 4.w,
                  )),
              SizedBox(
                height: 8.h,
              )
            ],
          );
        });
  }

  Future<void> getFilterData(BuildContext context) async {
    final result = await locator<NavigationService>()
        .push(StationsListScreenRoute(caseType: "LOGON"));
    setState(() {
      if (result.toString() != "null") {
        BlocProvider.of<GlobalBloc>(context)
            .add(GlobalSetStationEvent(result.toString(), 'station'));
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: blueGrey,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: blueGrey,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.clear,
                      color: Colors.white,
                    )),
                SizedBox(height: 3.h),
                headingText(title: "Logged in at/as:"),
                SizedBox(height: 1.h),
                BlocBuilder<GlobalBloc, GlobalState>(builder: (context, state) {
                  if (state is GlobalSelectStationState) {
                    return state.station.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    state.type != 'train'
                                        ? Icons.location_on_outlined
                                        : Icons.train,
                                    size: 22.sp,
                                    color: Colors.white,
                                  ),
                                  Container(
                                      width: 40.w,
                                      child: headingTextThree(
                                          title: state.station)),
                                ],
                              ),
                              InkWell(
                                  onTap: () {
                                    locator<NavigationService>()
                                        .pushAndRemoveUntil(HomescreenRoute(
                                            isOfflineApiRequired: false));
                                  },
                                  child: Card(
                                    color: primaryColor,
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: subheadingText(
                                          title: "Edit",
                                        )),
                                  ))
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Container(
                                    width: 50.w,
                                    child: headingTextThree(
                                        title: "Revenue Protection Team")),
                                InkWell(
                                    onTap: () {
                                      locator<NavigationService>()
                                          .pushAndRemoveUntil(HomescreenRoute(
                                              isOfflineApiRequired: false));
                                    },
                                    child: Card(
                                      color: primaryColor,
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: subheadingText(
                                            title: "Edit",
                                          )),
                                    ))
                              ]);
                  }
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: 50.w,
                            child: headingTextThree(
                                title: "Revenue Protection Team")),
                        InkWell(
                            onTap: () {
                              locator<NavigationService>().pushAndRemoveUntil(
                                  HomescreenRoute(isOfflineApiRequired: false));
                            },
                            child: Card(
                              color: primaryColor,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: subheadingText(
                                    title: "Edit",
                                  )),
                            ))
                      ]);
                })
              ],
            ),
          ),
          ListTile(
            dense: true,
            title: subheadingTextBOLD(title: "Main Menu"),
            onTap: () {
              locator<NavigationService>()
                  .push(UnPaidFareIssueMainRoute(isOfflineApiRequired: false));
              // Update the state of the app.
              // ...
            },
          ),
          Divider(
            color: secondryColor,
          ),
          ListTile(
            dense: true,
            onTap: () async {
              bool checkInternet = await Utils.checkInternet();
              if (checkInternet) {
                BlocProvider.of<OfflineSyncBloc>(context)
                    .add(OfflineOnlineSyncEvent(context));
              } else {
                locator<ToastService>()
                    .showValidationMessage(context, "Internet not available");
              }
            },
            title: subheadingTextBOLD(title: "Offline Sync"),
          ),
          Divider(
            color: secondryColor,
          ),
          ListTile(
            dense: true,
            title: subheadingTextBOLD(title: "Printer Settings"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrinterSetting()));
            },
            subtitle: BlocBuilder<PrinterBloc, PrinterState>(
              builder: (context, state) {
                if (state is PrinterStatusUpdateState) {
                  return Text(
                    state.status,
                    style: TextStyle(
                        color: state.status == "Connected"
                            ? Colors.lightGreen
                            : Colors.red,
                        fontFamily: "railLight"),
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
          Divider(
            color: secondryColor,
          ),
          ListTile(
            dense: true,
            title: subheadingTextBOLD(title: "Change Password"),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChangeCurrentPassword()));
            },
          ),
          Divider(
            color: secondryColor,
          ),
          BlocListener<SettingsBloc, SettingsState>(
              listener: (context, state) {
                if (state is SettingsSuccessSummaryState) {
                  List<summaryModel> list = state.data;
                  SummaryValues(list);
                }
              },
              child: ListTile(
                  dense: true,
                  onTap: () async {
                    BlocProvider.of<PrinterBloc>(context)
                        .add(PrinterDisconnectEvent());
                    bool checkInternet = await Utils.checkInternet();

                    emptyValues();
                    if (checkInternet) {
                      BlocProvider.of<SettingsBloc>(context)
                          .add(SettingsLogOutSummaryEvent(context));
                    } else {
                      openErrorDialog(context);
                    }
                  },
                  title: subheadingTextBOLD(title: "Log Out"))),
          Divider(
            color: secondryColor,
          ),
          ListTile(
            dense: true,
            title: subheadingTextBOLD(title: "App Information"),
            onTap: () async {
              openAppInfoDialog(context);
            },
          ),
          Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              boxtextSmall(title: "POWERED BY:"),
              SizedBox(
                height: 1.h,
              ),
              Image.asset(
                logoURl,
                color: Colors.white,
                height: 2.5.h,
                width: 100.h,
                fit: BoxFit.scaleDown,
              ),
              SizedBox(
                height: 1.h,
              ),
              boxtextSmall(title: "® Tracsis plc"),
            ],
          )
        ],
      ),
    );
  }

  emptyValues() {
    setState(() {
      totalValue = 0;
      totalPaid = 0;
      pfnIssued = 0;
      mg11Issued = 0;
      ufnIssued = 0;
      pcnIssued = 0;
      pfnCount = 0;
      mg11Count = 0;
      ufnCount = 0;
      pcnCount = 0;
      totalNoofNotice = 0;
    });
  }

  SummaryValues(List<summaryModel> list) {
    setState(() {
      for (summaryModel s in list) {
        //total amount paid
        totalPaid = totalPaid + double.parse(s.tOTALAMOUNTPAID.toString());
        //total due  added to total notice issues
        totalValue = totalValue + double.parse(s.tOTALAMOUNTDUE.toString());
        // if (s.cASETYPECODE == "PF") {
        //   pfnIssued = pfnIssued + double.parse(s.tOTALAMOUNTDUE.toString());
        //   pfnCount = int.parse(s.cASECOUNT.toString());
        // }

        if (s.cASETYPECODE == "UFN") {
          ufnCount = int.parse(s.cASECOUNT.toString());
          ufnIssued = ufnIssued + double.parse(s.tOTALAMOUNTDUE.toString());
        }
        if (s.cASETYPECODE == "UFN_HT") {
          ufnhtCount = int.parse(s.cASECOUNT.toString());
          ufnHTIssued = ufnHTIssued + double.parse(s.tOTALAMOUNTDUE.toString());
        }

        // if (s.cASETYPECODE == "PCN") {
        //   pcnCount = int.parse(s.cASECOUNT.toString());
        //   pcnIssued = pcnIssued + double.parse(s.tOTALAMOUNTDUE.toString());
        // }
        // if (s.cASETYPECODE == "MG11") {
        //   mg11Count = int.parse(s.cASECOUNT.toString());
        //   mg11Issued = mg11Issued + double.parse(s.tOTALAMOUNTDUE.toString());
        // }
      }
      totalNoofNotice = ufnCount + ufnhtCount;
    });
    openLogoutDialog(context, list);
  }
}
