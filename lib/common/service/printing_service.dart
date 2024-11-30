import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zebrautility/ZebraPrinter.dart';
import 'package:zebrautility/zebrautility.dart';
import '../../Ui/Utils/common_printer_dialog.dart';
import '../../bloc/printer_bloc/Reprint_bloc.dart';
import '../../bloc/printer_bloc/printer_bloc.dart';
import '../../constants/app_utils.dart';
import '../locator/locator.dart';
import '../router/router.gr.dart';

@lazySingleton
class PrintingService {
  final AppRouter _router;
  ZebraPrinter? zebraPrinter;
  BuildContext? context;
  Map<String, dynamic> printerListFound = {};

  PrintingService(this._router);

  BuildContext getSafeContext() {
    context = _router.navigatorKey.currentContext;
    return context ?? (throw ('Have you forgot to setup routes?'));
  }

  Function onPermissionDenied = () {};

  void connectToPrinter1(name, ipAddress, isWifiPrinter) {
    printerListFound.addAll({
      ipAddress: {
        "name": name,
        "ipAddress": ipAddress,
        "isWifiPrinter": isWifiPrinter,
      }
    });

  }

  Future<void> checkPermission() async {
    await Permission.bluetooth.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
    await Permission.bluetoothAdvertise.request();
    // await Permission.location.request();

    var status = await Permission.bluetooth.status;
    var status1 = await Permission.bluetoothScan.status;
    var status2 = await Permission.bluetoothConnect.status;
    var status3 = await Permission.bluetoothAdvertise.status;

    if (status.isDenied && status1.isDenied && status2.isDenied && status3.isDenied) {
      await Permission.bluetooth.request();
      await Permission.bluetoothScan.request();
      await Permission.bluetoothConnect.request();
      await Permission.bluetoothAdvertise.request();
    }
    else if (status.isGranted) {
      if (zebraPrinter != null) {
        zebraPrinter?.discoveryPrinters();
      }
    }
    else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    else if (status.isRestricted) {
      print(
          "The OS restricts access, for example because of parental controls.");
    }
    if (await Permission.location.request().isGranted) {
      if (zebraPrinter != null) {
        zebraPrinter?.discoveryPrinters();
      }
    }
    else if (await Permission.location.request().isPermanentlyDenied){
      openAppSettings();
    }
    else if(await Permission.location.request().isRestricted) {
      print(
          "The OS restricts access, for example because of parental controls.");
    }
  }
  void checkConnection() async {
    int disconnectCount = 0;

    zebraPrinter = await Zebrautility.getPrinterInstance(
      onPrinterFound: (name, ipAddress, isWifiPrinter) {
        connectToPrinter1(name, ipAddress, isWifiPrinter);
      },
      onPrinterDiscoveryDone: () {
        BlocProvider.of<PrinterBloc>(getSafeContext())
            .add(PrinterDiscoveryDoneEvent(true, printerListFound));
        printerListFound = {};
      },
      onChangePrinterStatus: (status, color) async {
        if (status.isNotEmpty) {
          if (status == "Done" || status == "Failed") {
            BlocProvider.of<PrinterBloc>(getSafeContext())
                .add(PrintingDoneEvent(status));
            BlocProvider.of<PrinterReprintBloc>(getSafeContext())
                .add(PrintingDoneReprintEvent(status));


          } else if (status == "Disconnected") {
            BlocProvider.of<PrinterBloc>(getSafeContext())
                .add(PrinterStatusEvent(status));
            BlocProvider.of<PrinterReprintBloc>(getSafeContext())
                .add(PrintercheckStatusEvent("Disconnected"));


            while (disconnectCount < 1 ) {
              await Future.delayed(const Duration(seconds: 50));
              String? connectionStatus = await isPrinterConnected();

              if (connectionStatus == null || connectionStatus == "Disconnected") {
                BlocProvider.of<PrinterBloc>(getSafeContext())
                    .add(PrinterStatusEvent("Disconnected"));
                BlocProvider.of<PrinterReprintBloc>(getSafeContext())
                    .add(PrintercheckStatusEvent("Disconnected"));
                disconnectCount++;


              } else if (connectionStatus == "Connected") {
                BlocProvider.of<PrinterBloc>(getSafeContext())
                    .add(PrinterStatusEvent("Connected"));
                BlocProvider.of<PrinterReprintBloc>(getSafeContext())
                    .add(PrintercheckStatusEvent("Connected"));

                disconnectCount = 0; // resetting counter
              }
            }

          } else if (status == "Connected") {
            BlocProvider.of<PrinterBloc>(getSafeContext())
                .add(PrinterStatusEvent(status));
            BlocProvider.of<PrinterReprintBloc>(getSafeContext())
                .add(PrintercheckStatusEvent("Connected"));

            await Future.delayed(Duration(seconds: 50));
            String? connectionStatus = await isPrinterConnected();

            if (connectionStatus == null || connectionStatus == "Disconnected") {
              BlocProvider.of<PrinterBloc>(getSafeContext())
                  .add(PrinterStatusEvent("Disconnected"));
              BlocProvider.of<PrinterReprintBloc>(getSafeContext())
                  .add(PrintercheckStatusEvent("Disconnected"));
            }

          } else if (status == "Connection Lost") {
            printerListFound = {};
            BlocProvider.of<PrinterBloc>(getSafeContext())
                .add(PrinterDiscoveryDoneEvent(true, printerListFound));

            BlocProvider.of<PrinterReprintBloc>(getSafeContext())
                .add(PrintercheckStatusEvent("Disconnected"));

            CommonPrinterDialog().showPrinterDialog(getSafeContext());
          }
        }
      },
      onChangePrinterHeadStatus: (status) async {
        if (status.isNotEmpty) {
          if (status == "Connected") {
            BlocProvider.of<PrinterBloc>(getSafeContext())
                .add(PrinterSaveStatusEvent(status));
            BlocProvider.of<PrinterReprintBloc>(getSafeContext())
                .add(PrinterSaveReprintStatusEvent(status));
            await Future.delayed(const Duration(seconds: 30));
            String? connectionStatus = await isPrinterConnected();

            if (connectionStatus == "Disconnected") {
              BlocProvider.of<PrinterBloc>(getSafeContext())
                  .add(PrinterStatusEvent("Disconnected"));
              BlocProvider.of<PrinterReprintBloc>(getSafeContext())
                  .add(PrintercheckStatusEvent("Disconnected"));

            }
          } else {
            CommonPrinterDialog()
                .showPrinterStatusDialog(getSafeContext(), status);
          }
        }
      },
      onPermissionDenied: onPermissionDenied,
    );
  }

  connectToPrinter(String address ) {

    if (address.isNotEmpty) {
      if(zebraPrinter != null ) {
        zebraPrinter?.connectToPrinter(address);
      }
    }
  }

  DisconnectToPrinter(String address) {

    if (address.isNotEmpty) {
      if(zebraPrinter != null ) {
        zebraPrinter?.disconnect();
      }
    }
  }





  discoveryPrinters() {
    if(zebraPrinter != null) {
      zebraPrinter?.discoveryPrinters();
    }
  }

  disconnect() async {
    String printType = await AppUtils().getPrinterId();
    if(zebraPrinter != null) {
      zebraPrinter?.disconnect();
      locator<PrintingService>().zebraPrinter!.unpair(printType);


    }
  }

  unpairprinter() {
    if(zebraPrinter != null) {
      zebraPrinter?.unpair("address");
    }
  }

  print(String zplCommand) {
    if(zebraPrinter != null) {
      zebraPrinter?.print(zplCommand);
    }
  }

  checkPrinterHeadStatus() {
    if(zebraPrinter != null) {
      zebraPrinter?.checkPrinterHeadStatus();
    }
  }


  isPrinterConnected() {
    if(zebraPrinter != null) {
      zebraPrinter?.isPrinterConnected();
    }
  }
}