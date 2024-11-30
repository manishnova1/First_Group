import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:railpaytro/Ui/Pages/PrinterSetting/PrinterSettings.dart';
import 'package:railpaytro/Ui/Widgets/Dialogtextbox2.dart';
import 'package:railpaytro/common/service/toast_service.dart';
import 'package:sizer/sizer.dart';
import '../../bloc/auth_bloc/setting_bloc.dart';
import '../../bloc/global_bloc.dart';
import '../../bloc/offline_sync.dart';
import '../../bloc/printer_bloc/printer_bloc.dart';
import '../../common/Utils/utils.dart';
import '../../common/locator/locator.dart';
import '../../constants/app_utils.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/auth/login_model.dart';
import '../../data/model/summaryModel.dart';
import '../Utils/Colors.dart';
import '../Widgets/Dialogtextbox.dart';
import '../Widgets/PrimaryButton.dart';
import '../Widgets/SecondryButton.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double totalValue = 0;
  double totalPaid = 0;
  double pfnIssued = 0;
  double mg11Issued = 0;
  double ufnIssued = 0;
  double pcnIssued = 0;
  int pfnCount = 0;
  int mg11Count = 0;
  int ufnCount = 0;
  int pcnCount = 0;
  int totalNoofNotice = 0;

  openLogoutDialog(BuildContext context, var data) async {
    LoginModel user = await SqliteDB.instance.getLoginModelData();
    String sessionStartTime = await AppUtils().getUserSessionIn();
    String sessionEndtime =
        DateFormat("d MMM yyyy  kk:mm").format(DateTime.now());
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(20),
            backgroundColor: secondryColor,
            actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
            title: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Text(
                    "End of session summary",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15.sp,
                        color: Colors.white),
                  ),
                )),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DialogTextbox(
                        title: "Username:", subtitle: user.STUSER!.SUSERNAME!),
                    DialogTextbox(
                        title: "Session Started:", subtitle: sessionStartTime),
                    DialogTextbox(
                        title: "Session Ended:", subtitle: sessionEndtime),
                    DialogTextbox(
                        title: "Car Park Penalty issued:",
                        subtitle:
                            "$pcnCount (£${pcnIssued.toStringAsFixed(2)})"),
                    DialogTextbox(
                        title: "Unpaid Fare Notice (LUMO) issued:",
                        subtitle:
                            "$ufnCount (£${ufnIssued.toStringAsFixed(2)})"),
                    DialogTextbox(
                        title: "Penalty Fare Notice issued:",
                        subtitle:
                            "$pfnCount (£${pfnIssued.toStringAsFixed(2)})"),
                    DialogTextbox(
                        title: "Mg11 issued:",
                        subtitle:
                            "$mg11Count (£${mg11Issued.toStringAsFixed(2)})"),
                    DialogTextbox(
                        title: "Total No. of Notices issued:",
                        subtitle: "$totalNoofNotice"),
                    DialogTextbox(
                        title: "Total Value of Notice issued:",
                        subtitle: "£${totalValue.toStringAsFixed(2)}"),
                    DialogTextbox(
                        title: "Total Payments Received:",
                        subtitle: "£${totalPaid.toStringAsFixed(2)}"),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Are you sure you want to logout end this session?",
                      style: TextStyle(fontSize: 11.sp, color: Colors.white60),
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
                                    title: "Yes",
                                    onAction: () {
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
            insetPadding: EdgeInsets.all(20),
            backgroundColor: secondryColor,
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
                    DialogTextbox2(
                        title: "Last Checked for Updates:", subtitle: "N/A"),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SecondryButton(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // if(!kReleaseMode)
          ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                  height: 20.h,
                  color: Colors.white,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 4.h),
                      child: Text(
                        "Settings",
                        style: TextStyle(color: Colors.black, fontSize: 25.sp),
                      ),
                    ),
                  ))),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 4.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 0,
                  onTap: () async {
                    bool checkInternet = await Utils.checkInternet();
                    if (checkInternet) {
                      BlocProvider.of<OfflineSyncBloc>(context)
                          .add(OfflineOnlineSyncEvent(context));
                    } else {
                      locator<ToastService>().showValidationMessage(
                          context, "Internet not available");
                    }
                  },
                  title: Text(
                    "Offline Sync",
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                  ),
                  leading: Icon(Icons.offline_bolt, color: Colors.white),
                ),
                const Divider(
                  color: Colors.white70,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 0,
                  onTap: () {
                    // locator<NavigationService>()
                    //     .pushAndRemoveUntil(BottomNavigationHomePageRoute());
                  },
                  title: Text(
                    "Change Role",
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                  ),
                  leading:
                      Icon(Icons.supervised_user_circle, color: Colors.white),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white70,
                    size: 12.sp,
                  ),
                ),
                const Divider(
                  color: Colors.white70,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 0,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PrinterSetting()));
                  },
                  title: Text(
                    "Printer Settings",
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                  ),
                  leading: Icon(Icons.local_print_shop_outlined,
                      color: Colors.white),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white70,
                    size: 12.sp,
                  ),
                  subtitle: BlocBuilder<PrinterBloc, PrinterState>(
                    builder: (context, state) {
                      if (state is PrinterStatusUpdateState) {
                        return Text(
                          state.status,
                          style: TextStyle(
                              color: state.status == "Connected"
                                  ? Colors.lightGreen
                                  : Colors.red),
                        );
                      } else {
                        return Text(
                            BlocProvider.of<PrinterBloc>(context)
                                    .status
                                    .isNotEmpty
                                ? BlocProvider.of<PrinterBloc>(context).status
                                : "Disconnected",
                            style: TextStyle(
                                color: BlocProvider.of<PrinterBloc>(context)
                                            .status ==
                                        "Connected"
                                    ? Colors.lightGreen
                                    : Colors.red,
                                fontFamily: "railLight"));
                      }
                    },
                  ),
                ),
                const Divider(
                  color: Colors.white70,
                ),
                BlocListener<SettingsBloc, SettingsState>(
                    listener: (context, state) {
                      if (state is SettingsSuccessSummaryState) {
                        List<summaryModel> list = state.data;
                        SummaryValues(list);
                      }
                    },
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      horizontalTitleGap: 0,
                      onTap: () {
                        emptyValues();
                        BlocProvider.of<SettingsBloc>(context)
                            .add(SettingsLogOutSummaryEvent(context));
                      },
                      title: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      ),
                      leading: Icon(Icons.logout, color: Colors.white),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white70,
                        size: 12.sp,
                      ),
                    )),
                const Divider(
                  color: Colors.white70,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 0,
                  onTap: () async {
                    openAppInfoDialog(context);
                  },
                  title: Text(
                    "About App",
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                  ),
                  leading: Icon(Icons.info_outline, color: Colors.white),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white70,
                    size: 12.sp,
                  ),
                ),
                const Divider(
                  color: Colors.white70,
                )
              ],
            ),
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
        if (s.cASETYPECODE == "PF") {
          pfnIssued = pfnIssued + double.parse(s.tOTALAMOUNTDUE.toString());
          pfnCount = int.parse(s.cASECOUNT.toString());
        }

        if (s.cASETYPECODE == "UFN") {
          ufnCount = int.parse(s.cASECOUNT.toString());
          ufnIssued = ufnIssued + double.parse(s.tOTALAMOUNTDUE.toString());
        }
        if (s.cASETYPECODE == "PCN") {
          pcnCount = int.parse(s.cASECOUNT.toString());
          pcnIssued = pcnIssued + double.parse(s.tOTALAMOUNTDUE.toString());
        }
        if (s.cASETYPECODE == "MG11") {
          mg11Count = int.parse(s.cASECOUNT.toString());
          mg11Issued = mg11Issued + double.parse(s.tOTALAMOUNTDUE.toString());
        }
      }
      totalNoofNotice = ufnCount + pfnCount + mg11Count + pcnCount;
    });
    openLogoutDialog(context, list);
  }
}
