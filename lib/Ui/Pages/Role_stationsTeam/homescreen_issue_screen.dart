import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/intelligence_report/intelligence_report_detail.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/issuing_history/issuing_history_main.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/test_notice_case/test_unpaid_fare_main.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/unpaid_fare_Ht/unpaid_fare_main_1.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/unpaid_fare_issue/unpaid_fare_main_1.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/bloc/global_bloc.dart';
import 'package:railpaytro/data/model/auth/login_model.dart';
import 'package:railpaytro/data/model/revpirDetailMode.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../bloc/offline_sync.dart';
import '../../../bloc/printer_bloc/printer_bloc.dart';
import '../../../bloc/ufn_luno_bloc/address_screen_bloc.dart';
import '../../../common/Utils/utils.dart';
import '../../../common/locator/locator.dart';
import '../../../common/router/router.gr.dart';
import '../../../common/service/common_internet_check.dart';
import '../../../common/service/common_offline_status.dart';
import '../../../common/service/navigation_service.dart';
import '../../../common/service/printing_service.dart';
import '../../../common/service/toast_service.dart';
import '../../../constants/app_utils.dart';
import '../../../data/local/sqlite.dart';
import '../../Widgets/DrawerWidget.dart';
import '../../Widgets/IssueBox.dart';
import '../../Widgets/IssueBox2.dart';
import '../../Widgets/PrimaryButton.dart';
import '../../Widgets/SecondryButton.dart';
import '../../Widgets/SpaceWidgets.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
class UnPaidFareIssueMain extends StatefulWidget {
  bool? isOfflineApiRequired;

  UnPaidFareIssueMain({required this.isOfflineApiRequired});

  @override
  _UnPaidFareIssueMainState createState() => _UnPaidFareIssueMainState();
}

class _UnPaidFareIssueMainState extends State<UnPaidFareIssueMain> {
  String menu = "";
  Map _source = {ConnectivityResult.none: false};

  int checkvalue = -1;
  List<REVPIRDETAILSARRAY?> revirDetail = [];
  bool pcnActive = true;
  bool ufnActive = false;
  bool ufnHtActive = false;

  bool pfnActive = true;
  bool pfActive = true;
  bool mg11Active = true;
  bool IRActive = false;
  bool IRActive1 = false;
  bool IRHActive = true;
  bool issuingHistoryActive = true;
  bool testActive = true;
  var PFNewCalculationStartDate = "2023-01-01";
  DateTime currentDate = DateTime.now();
  String DEFAULTREVENUEPROTECTIONTEAM = "";
  LoginModel user = LoginModel();
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  String string = '';

  bool isPrinterConnected(BuildContext context) {
    final printerBloc = BlocProvider.of<PrinterBloc>(context);
    return printerBloc.status == "Connected";
  }
  getprinterConnnected(){
    connectToPrinterIfNotConnected(context);
  }

  connectToPrinterIfNotConnected(BuildContext context) async {
    if (!isPrinterConnected(context)) {
      String printType = await AppUtils().getPrinterId();
      if (printType != null && printType != "") {
        locator<PrintingService>().connectToPrinter(printType);
      }
    }
  }
  @override
  void initState() {
    getprinterConnnected();
    BlocProvider.of<AddressUfnBloc>(context).submitAddressMap.clear();
    revirDetail = BlocProvider.of<GlobalBloc>(context).revpirDetailLIST;
    getUserSetting();
    DEFAULTREVENUEPROTECTIONTEAM = user.DEFAULTREVENUEPROTECTIONTEAM.toString();
    if (locator<PrintingService>().zebraPrinter == null) {
      locator<PrintingService>().checkPermission();
      locator<PrintingService>().checkConnection();
    }
    if (widget.isOfflineApiRequired != null &&
        widget.isOfflineApiRequired == true) {
      BlocProvider.of<GlobalBloc>(context).add(GlobalInsertOfflineDataEvent());
    }

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      InternetCheck()
          .checkUpdatedConnection(widget.isOfflineApiRequired, context);
      _networkConnectivity.initialise();
      _networkConnectivity.myStream.listen((source) {
        _source = source;
        print('source $_source');
        switch (_source.keys.toList()[0]) {
          case ConnectivityResult.mobile:
            {
              string = _source.values.toList()[0]
                  ? 'Mobile: Online'
                  : 'Mobile: Offline';
              AppUtils().setoffline(false);

              BlocProvider.of<OfflineSyncBloc>(context)
                  .add(OfflineOnlineSyncEvent(context));
              break;
            }
          case ConnectivityResult.wifi:
            {
              string =
                  _source.values.toList()[0] ? 'WiFi: Online' : 'WiFi: Offline';
              AppUtils().setoffline(false);

              BlocProvider.of<OfflineSyncBloc>(context)
                  .add(OfflineOnlineSyncEvent(context));
              break;
            }
          case ConnectivityResult.none:
          default:
            string = 'Offline';
        }
        setState(() {});
      });
    });
  }

  getUserSetting() async {
    user = await SqliteDB.instance.getLoginModelData();

    setState(() {
      ufnActive = user.IS_UNPAID_FARE_ISSUER!;
      ufnHtActive = user.IS_UNPAID_FARE_ISSUERHT!;

      pfnActive = user.IS_PENALTY_FARE_ISSUER!;
      pfActive = user.IS_PENALTY_FARE_ISSUER!;
      mg11Active = user.IS_MG11!;
      issuingHistoryActive = user.IS_ISSUEHISTORY_ISSUER!;
      IRActive = user.INTELLIGENCEREPORTENABLED!;
      // testActive = user.IS_TESTNOTICE!;

      PFNewCalculationStartDate = user.PFNEWCALCULATIONSTARTDATE.toString();
      DateTime newPFNStartDate =
          DateFormat("dd-MM-yyyy").parse(PFNewCalculationStartDate);
      if (newPFNStartDate.compareTo(currentDate) <= 0) {
        pfnActive = true;
        pfActive = false;
      } else {
        pfActive = true;
        pfnActive = false;
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

  openIntelligenceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                side: BorderSide(color: primaryColor, width: 3)),
            backgroundColor: Colors.white,
            insetPadding: EdgeInsets.all(20),
            actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
            content: const Text(
              "Important",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontFamily: "railLight",
              ),
              textAlign: TextAlign.center,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 45.h,
                      color: blueGrey.withOpacity(.1),
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
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            child: Html(
                                data: revirDetail[0]
                                    ?.preConfermationMessage
                                    .toString(),
                                onLinkTap: (String? url,
                                    RenderContext context,
                                    Map<String, String> attributes,
                                    var e) async {
                                  Uri phoneno = Uri.parse(url.toString());
                                  if (await launchUrl(phoneno)) {
                                    //dialer opened
                                  } else {
                                    //dailer is not opened
                                  }
                                },
                                style: {
                                  'body': Style(
                                    textAlign: TextAlign.justify,
                                    color: Colors.black87,
                                    fontFamily: "railLight",
                                    fontSize: FontSize(12.sp),
                                  ),
                                  'a': Style(
                                      color: Colors.blueGrey,
                                      textAlign: TextAlign.justify,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "railLight"),
                                }),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SecondryButton(
                              title: "Cancel",
                              onAction: () {
                                Navigator.pop(context, true);
                              }),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: PrimaryButton(
                                title: "Continue",
                                onAction: () {
                                  Navigator.pop(context, true);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              IntelligenceReportDetail()));
                                }))
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
    return MultiBlocListener(
        listeners: [
          BlocListener<GlobalBloc, GlobalState>(
            listener: (context, state) {
              if (state is GlobalCommonDataInsertedState) {
                BlocProvider.of<GlobalBloc>(context)
                    .add(GlobalGetCMSVariableData());
                BlocProvider.of<GlobalBloc>(context).add(GlobalGetLoginData());
                BlocProvider.of<GlobalBloc>(context)
                    .add(GlobalGetCommonDataBaseDataEvent());
              }
            },
          ),
        ],
        child: Scaffold(
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
                  padding: screenPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headingText(title: "Select Notice or Report"),
                      LargeSpace(),



                      ufnActive
                          ? Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    BlocProvider.of<GlobalBloc>(context)
                                        .caseDetailsPrintList
                                        .forEach((element) async {
                                      if (element!.cASETYPECODEPRINT ==
                                              'UFN' &&
                                          element.eNABLESTATTUSPRINT == "1") {
                                        if (BlocProvider.of<PrinterBloc>(
                                                    context)
                                                .status ==
                                            "Connected") {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UnpaidFare("")));
                                        } else {
                                          locator<ToastService>()
                                              .showValidationMsgPrintEnable(
                                                  context,
                                                  'You must pair and connect a printer before proceeding.');
                                        }
                                      }
                                      else if (element!.cASETYPECODEPRINT ==
                                              'UFN' &&
                                          element.eNABLESTATTUSPRINT == "0") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UnpaidFare("")));
                                      }
                                    });
                                  },
                                  child: IssueBox(
                                      title: "Unpaid Fare Notice (LUMO)",
                                      icon: "Assets/icons/bandge.png"),
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                              ],
                            )
                          : Container(),

                      ufnHtActive
                          ? Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    BlocProvider.of<GlobalBloc>(context)
                                        .caseDetailsPrintList
                                        .forEach((element) async {
                                      if (element!.cASETYPECODEPRINT ==
                                              'UFN (HT)' &&
                                          element.eNABLESTATTUSPRINT == "1") {
                                        if (BlocProvider.of<PrinterBloc>(
                                                    context)
                                                .status ==
                                            "Connected") {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UnpaidFareHt("")));
                                        } else {
                                          locator<ToastService>()
                                              .showValidationMsgPrintEnable(
                                                  context,
                                                  'You must pair and connect a printer before proceeding.');
                                        }
                                      } else if (element!.cASETYPECODEPRINT ==
                                              'UFN (HT)' &&
                                          element.eNABLESTATTUSPRINT == "0") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UnpaidFareHt("")));
                                      }
                                    });
                                  },
                                  child: IssueBox(
                                      title: "Unpaid Fare Notice (HT)",
                                      icon: "Assets/icons/bandge.png"),
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                              ],
                            )
                          : Container(),

                      IRActive
                          ? Column(
                              children: [
                                InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             IntelligenceReportDetail()));
                                       openIntelligenceDialog(context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: lightGreenColor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      width: 100.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          subheadingTextBOLD(
                                              title: "Intelligence Report"),
                                          Image.asset(
                                            "Assets/icons/warning.png",
                                            width: 20.sp,
                                          )
                                        ],
                                      ),
                                    )),
                              ],
                            )
                          : Container(),
                      LargeSpace(),
                      LargeSpace(),
                      headingText(title: "Other Tools"),

                      LargeSpace(),

                      issuingHistoryActive
                          ? Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    bool checkInternet =
                                        await Utils.checkInternet();
                                    if (checkInternet) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  IssuingHistoryMain("")));
                                    } else {
                                      openErrorDialogForVerication(context);
                                    }
                                  },
                                  child: IssueBox2(
                                    title: "Manage Previous Notices",
                                    icon: Icons.history,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                              ],
                            )
                          : Container(),
                      testActive
                          ? InkWell(
                              onTap: () {
                                {
                                  ///Auto route
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TestUnpaidFare("Test Notice")));
                                }
                              },
                              child: IssueBox2(
                                title: "Test Notice",
                                icon: Icons.info_outline,
                              ))
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [],
                            ),
                      LargeSpace(),
                      MediumSpace(),
                    ],
                  ),
                ),
                Visibility(
                    visible: user.DEFAULTREVENUEPROTECTIONTEAM.toString() ==
                            "none" ||
                        user.DEFAULTREVENUEPROTECTIONTEAM.toString() ==
                            "Roaming_Station_Train",
                    child: Positioned(
                        bottom: 0,
                        child: InkWell(
                            onTap: () {
                              locator<NavigationService>().pushAndRemoveUntil(
                                  HomescreenRoute(isOfflineApiRequired: false));
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              width: 100.w,
                              color: secondryColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 14.sp,
                                  ),
                                  subheadingTextBOLD(title: "  Go Back")
                                ],
                              ),
                            )))),
              ],
            )));
  }
}

class NetworkConnectivity {
  NetworkConnectivity._();

  static final _instance = NetworkConnectivity._();

  static NetworkConnectivity get instance => _instance;
  final _networkConnectivity = Connectivity();
  final _controller = StreamController.broadcast();

  Stream get myStream => _controller.stream;

  void initialise() async {
    ConnectivityResult result = await _networkConnectivity.checkConnectivity();
    _checkStatus(result);
    _networkConnectivity.onConnectivityChanged.listen((result) {
      print(result);
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}
