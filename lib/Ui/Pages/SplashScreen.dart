import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Utils/Colors.dart';
import 'package:railpaytro/bloc/global_bloc.dart';
import 'package:railpaytro/common/router/router.gr.dart';
import 'package:railpaytro/constants/app_utils.dart';
import '../../bloc/printer_bloc/printer_bloc.dart';
import '../../common/locator/locator.dart';
import '../../common/service/navigation_service.dart';
import '../../common/service/printing_service.dart';
import '../../data/constantes/constants.dart';
import '../../data/model/auth/login_model.dart';
import '../Utils/DeviceSize.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

LoginModel user = LoginModel();

class _SplashScreenState extends State<SplashScreen> {
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
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, () async {
      bool isLogin = await AppUtils().getUserLoggedIn();
      bool getOfflineDataStatus = await AppUtils().getOfflineDataStatus();
      if (isLogin) {
        // ignore: use_build_context_synchronousl
        BlocProvider.of<GlobalBloc>(context)
            .add(GlobalCheckUserSessionStatusEvent());
        if (!getOfflineDataStatus) {
          BlocProvider.of<GlobalBloc>(context)
              .add(GlobalInsertOfflineDataEvent());
        }
      } else {
        BlocProvider.of<GlobalBloc>(context)
            .add(GlobalInsertCMSVariableDataEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = getWidth(context);
    return Scaffold(
        backgroundColor: secondryColor,
        body: BlocListener<GlobalBloc, GlobalState>(
          listener: (context, state) {
            if (state is GlobalCMSDataFetchedState) {
              BlocProvider.of<GlobalBloc>(context)
                  .add(GlobalGetCMSVariableData());
              locator<NavigationService>().popAndPush(const LoginScreenRoute());
            } else if (state is GlobalCommonDataFetchedState &&
                (user.DEFAULTREVENUEPROTECTIONTEAM.toString() ==
                        "Roaming_Station_Train" ||
                    user.DEFAULTREVENUEPROTECTIONTEAM.toString() == "None")) {
              locator<NavigationService>().pushAndRemoveUntil(
                  HomescreenRoute(isOfflineApiRequired: false));
            } else if (state is GlobalCommonDataFetchedState) {
              locator<NavigationService>().pushAndRemoveUntil(
                  UnPaidFareIssueMainRoute(isOfflineApiRequired: false));
            } else if (state is GlobalCheckStatusState) {
              BlocProvider.of<GlobalBloc>(context)
                  .add(GlobalSetStationEvent("", 'station'));

              BlocProvider.of<GlobalBloc>(context)
                  .add(GlobalInsertCMSVariableDataEvent());
            } else if (state is GlobalCheckStatusOfflineState) {
              BlocProvider.of<GlobalBloc>(context)
                  .add(GlobalGetCMSVariableData());
              BlocProvider.of<GlobalBloc>(context).add(GlobalGetLoginData());
              BlocProvider.of<GlobalBloc>(context)
                  .add(GlobalGetCommonDataBaseDataEvent());
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                    width: deviceWidth * 0.7,
                    child: Image.asset(
                      logoURl,
                      width: deviceWidth * 0.7,
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  "Revenue Protection Suite",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ));
  }
}
