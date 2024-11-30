import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Pages/Role_transTeam/train_team_main.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/Ui/Utils/defaultPadiing.dart';
import 'package:railpaytro/Ui/Widgets/DrawerWidget.dart';
import 'package:railpaytro/Ui/Widgets/TextWidgets.dart';
import 'package:railpaytro/common/router/router.gr.dart';
import 'package:sizer/sizer.dart';
import '../../bloc/global_bloc.dart';
import '../../bloc/printer_bloc/printer_bloc.dart';
import '../../common/locator/locator.dart';
import '../../common/service/common_internet_check.dart';
import '../../common/service/common_offline_status.dart';
import '../../common/service/navigation_service.dart';
import '../../common/service/printing_service.dart';
import '../../constants/app_utils.dart';
import '../Utils/hexcode.dart';
import '../Widgets/SpaceWidgets.dart';

class Homescreen extends StatefulWidget {
  bool? isOfflineApiRequired;

  Homescreen({required this.isOfflineApiRequired});

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String menu = "";
  String atStation = "";
  String onTrain = "";
  String roamingInspector = "";
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
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: HexColor('#373A36'),
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);
    super.initState();
    if (locator<PrintingService>().zebraPrinter == null) {
      locator<PrintingService>().checkPermission();
      locator<PrintingService>().checkConnection();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      InternetCheck()
          .checkUpdatedConnection(widget.isOfflineApiRequired, context);
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
            drawer: const DrawerWidget(),
            appBar: AppBar(
              backgroundColor: primaryColor,
              actions: [CommonOfflineStatusBar(isOfflineApiRequired: false)],
            ),
            body: Container(
              decoration: gradientDecoration,
              child: Padding(
                padding: screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MediumSpace(),
                    headingText(title: "Please select your role"),
                    LargeSpace(),
                    InkWell(
                      onTap: () {
                        locator<NavigationService>()
                            .push(const StationScreenRoute());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Container(
                          width: 100.w,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: primaryColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                "Assets/icons/station.png",
                                width: 30.sp,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              headingTextTwo(title: "Station/Gateline Team"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    LargeSpace(),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TrainTeamMain()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Container(
                          width: 100.w,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: primaryColor),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "Assets/icons/train.png",
                                width: 30.sp,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              headingTextTwo(
                                  title: "Conductor or Train Manager"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    LargeSpace(),
                    InkWell(
                      onTap: () {
                        BlocProvider.of<GlobalBloc>(context)
                            .add(GlobalSetStationEvent("", 'station'));
                        locator<NavigationService>().push(
                            UnPaidFareIssueMainRoute(
                                isOfflineApiRequired: false));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Container(
                          width: 100.w,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: primaryColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("Assets/icons/people.png",
                                  width: 30.sp),
                              SizedBox(
                                height: 4.h,
                              ),
                              headingTextTwo(title: " Revenue Protection Team"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    LargeSpace(),
                    LargeSpace(),
                  ],
                ),
              ),
            )));
  }
}
