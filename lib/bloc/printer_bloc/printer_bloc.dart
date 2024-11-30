import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:zebrautility/ZebraPrinter.dart';
import '../../common/locator/locator.dart';
import '../../common/service/printing_service.dart';
import '../../constants/app_config.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/auth/login_model.dart';
import '../../data/model/print_template_ditales.dart';
import '../../../../bloc/ufn_luno_bloc/address_screen_bloc.dart';

class PrinterEvent {}

class PrinterInstanceEvent extends PrinterEvent {
  PrinterInstanceEvent();
}

class PrinterInitiateEvent extends PrinterEvent {
  ZebraPrinter? zebraPrinter;

  PrinterInitiateEvent(this.zebraPrinter);
}

class PrinterDiscoverEvent extends PrinterEvent {
  PrinterDiscoverEvent();
}

class PrinterHideLoaderEvent extends PrinterEvent {
  PrinterHideLoaderEvent();
}

class PrinterDiscoveryDoneEvent extends PrinterEvent {
  bool isDiscoveryDone;
  Map<String, dynamic> printerListFound = {};

  PrinterDiscoveryDoneEvent(this.isDiscoveryDone, this.printerListFound);
}

class PrinterToConnectEvent extends PrinterEvent {
  String address;
  String name;

  bool isWifi;

  PrinterToConnectEvent(this.name, this.address, this.isWifi);
}

class PrinterPrintCommandEvent extends PrinterEvent {
  String zplCommand;

  PrinterPrintCommandEvent(this.zplCommand);
}

class PrinterDisconnectEvent extends PrinterEvent {
  PrinterDisconnectEvent();
}

class PrinterConnectToGenericEvent extends PrinterEvent {
  String address;
  ZebraPrinter? zebraPrinter;

  PrinterConnectToGenericEvent(this.address, this.zebraPrinter);
}

class PrinterSetMediaTypeEvent extends PrinterEvent {
  EnumMediaType mediaType;
  ZebraPrinter? zebraPrinter;

  PrinterSetMediaTypeEvent(this.mediaType, this.zebraPrinter);
}

class PrinterSetDarknessEvent extends PrinterEvent {
  int darkness;
  ZebraPrinter? zebraPrinter;

  PrinterSetDarknessEvent(this.darkness, this.zebraPrinter);
}

class PrinterStatusEvent extends PrinterEvent {
  String status;

  PrinterStatusEvent(this.status);
}

class PrinterRotateEvent extends PrinterEvent {
  ZebraPrinter? zebraPrinter;

  PrinterRotateEvent(this.zebraPrinter);
}

class PrinterCheckStatusEvent extends PrinterEvent {
  PrinterCheckStatusEvent();
}

class PrinterSaveStatusEvent extends PrinterEvent {
  String status;

  PrinterSaveStatusEvent(this.status);
}

class PrintingDoneEvent extends PrinterEvent {
  String status;

  PrintingDoneEvent(this.status);
}

class PrinterCaseEvent extends PrinterEvent {
  Map<String, dynamic>? data;
  String? type;
  BuildContext? context;

  PrinterCaseEvent({this.data, this.type, this.context});
}

class PrinterState {}

class PrinterInitialState extends PrinterState {}

class PrinterInstanceState extends PrinterState {
  PrinterInstanceState();
}

class PrinterErrorState extends PrinterState {
  String errorMsg;

  PrinterErrorState(this.errorMsg);
}

class PrinterDiscoveryDoneState extends PrinterState {
  PrinterDiscoveryDoneState();
}

class PrinterFoundState extends PrinterState {
  List<Map<String, dynamic>> printerListFound;

  PrinterFoundState(this.printerListFound);
}

class PrinterSelectedState extends PrinterState {
  String name;
  String ipAddress;
  bool isWifiPrinter;

  PrinterSelectedState(
    this.name,
    this.ipAddress,
    this.isWifiPrinter,
  );
}

class PrinterLocationPermissionState extends PrinterState {
  String message;

  PrinterLocationPermissionState(this.message);
}

class PrinterStatusUpdateState extends PrinterState {
  String status;

  PrinterStatusUpdateState(this.status);
}

class PrinterCheckStatusHeadState extends PrinterState {
  String status;

  PrinterCheckStatusHeadState(this.status);
}

class PrinterConnectingLoadingState extends PrinterState {
  PrinterConnectingLoadingState();
}

class PrinterLoadingState extends PrinterState {
  PrinterLoadingState();
}

class PrinterConnectedDoneState extends PrinterState {
  PrinterConnectedDoneState();
}

class PrinterCommandReadyToPrintState extends PrinterState {
  String zplCommand;

  PrinterCommandReadyToPrintState(this.zplCommand);
}

class PrinterGetMediaTypeState extends PrinterState {
  List<EnumMediaType> mediaType;
  ZebraPrinter? zebraPrinter;

  PrinterGetMediaTypeState(this.mediaType, this.zebraPrinter);
}

class PrinterStatusChangeState extends PrinterState {
  String status;
  String color;

  PrinterStatusChangeState(this.status, this.color);
}

class PrintingDoneState extends PrinterState {
  String status;

  PrintingDoneState(this.status);
}

class PrinterBloc extends Bloc<PrinterEvent, PrinterState> {
  Map<String, dynamic> printerListFound = {};
  String name = "";
  String ipAddress = "";
  bool isWifiPrinter = false;
  bool isDiscoveryDone = false;
  String status = "";
  String statusHead = "";

  PrinterBloc() : super(PrinterInitialState());

  @override
  Stream<PrinterState> mapEventToState(PrinterEvent event) async* {
    if (event is PrinterToConnectEvent) {
      locator<PrintingService>().connectToPrinter(event.address);
      name = event.name;
      ipAddress = event.address;
      isWifiPrinter = event.isWifi;
      if (status == "Connected") {
        yield PrinterSelectedState(event.name, event.address, event.isWifi);
      } else {
        yield PrinterSelectedState("", "", false);
      }
    } else if (event is PrinterHideLoaderEvent) {
      yield PrinterConnectedDoneState();
    } else if (event is PrinterDiscoverEvent) {
      yield PrinterConnectingLoadingState();
      locator<PrintingService>().discoveryPrinters();
    } else if (event is PrinterDiscoveryDoneEvent) {
      printerListFound = event.printerListFound;
      name = "";
      ipAddress = "";
      isWifiPrinter = false;

      isDiscoveryDone = event.isDiscoveryDone;
      yield PrinterConnectedDoneState();
      yield PrinterDiscoveryDoneState();
    } else if (event is PrinterDisconnectEvent) {
      locator<PrintingService>().disconnect();
      printerListFound = {};
      name = "";
      ipAddress = "";
      isWifiPrinter = false;
    } else if (event is PrinterPrintCommandEvent) {
      locator<PrintingService>().print(event.zplCommand);
    } else if (event is PrinterCheckStatusEvent) {
      locator<PrintingService>().checkPrinterHeadStatus();
    } else if (event is PrinterSaveStatusEvent) {
      statusHead = event.status;
      yield PrinterCheckStatusHeadState(event.status);
    } else if (event is PrinterStatusEvent) {
      status = event.status;
      /* if(status == "Connected" || status == "Disconnected")
      {
        yield PrinterConnectedDoneState();
      }*/
      yield PrinterStatusUpdateState(event.status);
    } else if (event is PrinterCaseEvent) {
      if (event.type == "PF") {
        Map<String, dynamic> data =
            BlocProvider.of<AddressUfnBloc>(event.context!).submitAddressMap;

        List<PRINTTEMPLATEBean?> printerTemplateList =
            await SqliteDB.instance.getPrintTemplateDataList('PF');
        String template = "";
        //   template  = AppConfig.pFNPrintTemplateDAta;

        if ((printerTemplateList[0]?.CONTENTS ?? "").isNotEmpty) {
          template = printerTemplateList[0]?.CONTENTS ?? "";
        }
        template =
            template.replaceAll("{case_ref_number}", "${data['caseNum']}");
        template =
            template.replaceAll("{amount_due}", "${data['outstanding']}");
        template = template.replaceAll("{amountPaid}", "${data['received']}");
        template = template.replaceAll("{penaltyfaredue}",
            double.parse(data['penalty_fare_due']).toStringAsFixed(2));
        template = template.replaceAll("{title}", "${data["title"]}");
        template = template.replaceAll("{firstName}", "${data['forename']}");
        template = template.replaceAll("{lastName}", "${data['surname']}");

        if ("${data['address_1']}" == 'null') {
          template = template.replaceAll("{address}", "");
        } else {
          template = template.replaceAll(
              "{address}", "${data['address_1']} ${data['address_2']}");
        }
        if ("${data['locality']}" == 'null') {
          template = template.replaceAll("{city}", "");
        } else {
          template = template.replaceAll("{city}", "${data['locality']}");
        }
        //
        // template = template.replaceAll("{city}", "${data['locality']}");
        // template = template.replaceAll("{address}", "${data['address_1']}");

        template = template.replaceAll("{postcode}", "${data['post_code']}");
        template =
            template.replaceAll("{dateOfBirth}", "${data['dateofbirth']}");
        template = template.replaceAll(
            "{offenceDate}",
            DateFormat('dd/MM/yyyy')
                .format(DateFormat("dd-MM-yyyy").parse(data['offence_dt'])));
        template = template.replaceAll("{casetime}", "${data['offence_time']}");
        template =
            template.replaceAll("{travelledFrom}", "${data['boarded_at']}");
        template =
            template.replaceAll("{travelledTo}", "${data['alighted_at']}");
        template = template.replaceAll("{issuedAt}", "${data['issued_at']}");
        template =
            template.replaceAll("{issueReason}", "${data['reason_title']}");
        template =
            template.replaceAll("{travelClass}", "${data['otherClasses']}");
        template = template.replaceAll("{username}", "${data['username']}");
        DateTime today = DateTime.now();
        DateTime formattedDate =
            DateTime(today.year, today.month, today.day + 21);
        template = template.replaceAll(
            "{formattedDate}", DateFormat('dd/MM/yyyy').format(formattedDate));

        yield PrinterCommandReadyToPrintState(template);
      } else if (event.type == "PFN") {
        Map<String, dynamic> data =
            BlocProvider.of<AddressUfnBloc>(event.context!).submitAddressMap;

        List<PRINTTEMPLATEBean?> printerTemplateList =
            await SqliteDB.instance.getPrintTemplateDataList('PFN');
        String template = "";
        //   template  = AppConfig.pFNPrintTemplateDAta;

        if ((printerTemplateList[0]?.CONTENTS ?? "").isNotEmpty) {
          template = printerTemplateList[0]?.CONTENTS ?? "";
        }
        template =
            template.replaceAll("{case_ref_number}", "${data['caseNum']}");
        template =
            template.replaceAll("{amount_due}", "${data['outstanding']}");
        template =
            template.replaceAll("{dateOfBirth}", "${data['dateofbirth']}");
        template = template.replaceAll("{amountPaid}", "${data['received']}");
        template = template.replaceAll("{penaltyfaredue}",
            double.parse(data['penalty_fare_due']).toStringAsFixed(2));
        template = template.replaceAll("{title}", "${data["title"]}");
        template = template.replaceAll("{firstName}", "${data['forename']}");
        template = template.replaceAll("{lastName}", "${data['surname']}");

        if ("${data['address_1']}" == 'null') {
          template = template.replaceAll("{address}", "");
        } else {
          template = template.replaceAll(
              "{address}", "${data['address_1']} ${data['address_2']}");
        }
        if ("${data['locality']}" == 'null') {
          template = template.replaceAll("{city}", "");
        } else {
          template = template.replaceAll("{city}", "${data['locality']}");
        }

        template = template.replaceAll("{postcode}", "${data['post_code']}");

        template = template.replaceAll(
            "{offenceDate}",
            DateFormat('dd/MM/yyyy')
                .format(DateFormat("dd-MM-yyyy").parse(data['offence_dt'])));
        template = template.replaceAll("{casetime}", "${data['offence_time']}");
        template =
            template.replaceAll("{travelledFrom}", "${data['boarded_at']}");
        template =
            template.replaceAll("{travelledTo}", "${data['alighted_at']}");
        template = template.replaceAll("{issuedAt}", "${data['issued_at']}");
        template =
            template.replaceAll("{issueReason}", "${data['reason_title']}");
        template =
            template.replaceAll("{travelClass}", "${data['otherClasses']}");
        template = template.replaceAll("{username}", "${data['username']}");
        DateTime today = DateTime.now();
        DateTime formattedDate =
            DateTime(today.year, today.month, today.day + 21);
        template = template.replaceAll(
            "{formattedDate}", DateFormat('dd/MM/yyyy').format(formattedDate));

        yield PrinterCommandReadyToPrintState(template);
      }

      else if (event.type == "UFN") {
        Map<String, dynamic> data =
            BlocProvider.of<AddressUfnBloc>(event.context!).submitAddressMap;

        String template = "";
        // template  = AppConfig.uFNPrintTemplateDAta;

        List<PRINTTEMPLATEBean?>? printerTemplateList =
        await SqliteDB.instance.getPrintTemplateDataList("UFN");
        if ((printerTemplateList[0]?.CONTENTS ?? "").isNotEmpty) {
          template = printerTemplateList[0]?.CONTENTS ?? "";
        }
        template =
            template.replaceAll("{case_ref_number}", "${data['caseNum']}");
        template =
            template.replaceAll("{amount_due}", "${data['outstanding']}");
        template = template.replaceAll("{amountPaid}", "${data['received']}");
        template = template.replaceAll("{penaltyfaredue}", "${data['total']}");
        template = template.replaceAll("{title}", "${data["title"]}");
        template = template.replaceAll("{firstName}", "${data['forename']}");
        template = template.replaceAll("{lastName}", "${data['surname']}");
        template = template.replaceAll(
            "{address}", "${data['address_1']} ${data['address_2']}");
        template = template.replaceAll("{city}", "${data['locality']}");
        template = template.replaceAll("{postcode}", "${data['post_code']}");
        template =
            template.replaceAll("{dateOfBirth}", "${data['dateofbirth']}");
        template = template.replaceAll(
            "{offenceDate}",
            DateFormat('dd/MM/yyyy')
                .format(DateFormat("dd-MM-yyyy").parse(data['offence_dt'])));
        template = template.replaceAll("{casetime}", "${data['offence_time']}");
        template =
            template.replaceAll("{travelledFrom}", "${data['boarded_at']}");
        template =
            template.replaceAll("{travelledTo}", "${data['alighted_at']}");
        template = template.replaceAll("{issuedAt}", "${data['issued_at']}");
        template =
            template.replaceAll("{issueReason}", "${data['reason_Title']}");
        template =
            template.replaceAll("{travelClass}", "${data['otherClasses']}");
        template = template.replaceAll("{username}", "${data['username']}");
        DateTime today = DateTime.now();
        DateTime formatedDate =
        DateTime(today.year, today.month, today.day + 21);
        template = template.replaceAll(
            "{formattedDate}", DateFormat('dd/MM/yyyy').format(formatedDate));

        yield PrinterCommandReadyToPrintState(template);
      }



      else if (event.type == "UFN(HT)") {
        Map<String, dynamic> data =
            BlocProvider.of<AddressUfnBloc>(event.context!).submitAddressMap;

        String template = "";
        // template  = AppConfig.uFNPrintTemplateDAta;

        List<PRINTTEMPLATEBean?>? printerTemplateList =
            await SqliteDB.instance.getPrintTemplateDataList("UFN (HT)");
        if ((printerTemplateList[0]?.CONTENTS ?? "").isNotEmpty) {
          template = printerTemplateList[0]?.CONTENTS ?? "";
        }
        template =
            template.replaceAll("{case_ref_number}", "${data['caseNum']}");
        template =
            template.replaceAll("{amount_due}", "${data['outstanding']}");
        template = template.replaceAll("{amountPaid}", "${data['received']}");
        template = template.replaceAll("{penaltyfaredue}", "${data['total']}");
        template = template.replaceAll("{title}", "${data["title"]}");
        template = template.replaceAll("{firstName}", "${data['forename']}");
        template = template.replaceAll("{lastName}", "${data['surname']}");
        template = template.replaceAll(
            "{address}", "${data['address_1']} ${data['address_2']}");
        template = template.replaceAll("{city}", "${data['locality']}");
        template = template.replaceAll("{postcode}", "${data['post_code']}");
        template =
            template.replaceAll("{dateOfBirth}", "${data['dateofbirth']}");
        template = template.replaceAll(
            "{offenceDate}",
            DateFormat('dd/MM/yyyy')
                .format(DateFormat("dd-MM-yyyy").parse(data['offence_dt'])));
        template = template.replaceAll("{casetime}", "${data['offence_time']}");
        template =
            template.replaceAll("{travelledFrom}", "${data['boarded_at']}");
        template =
            template.replaceAll("{travelledTo}", "${data['alighted_at']}");
        template = template.replaceAll("{issuedAt}", "${data['issued_at']}");
        template =
            template.replaceAll("{issueReason}", "${data['reason_Title']}");
        template =
            template.replaceAll("{travelClass}", "${data['otherClasses']}");
        template = template.replaceAll("{username}", "${data['username']}");
        DateTime today = DateTime.now();
        DateTime formatedDate =
            DateTime(today.year, today.month, today.day + 21);
        template = template.replaceAll(
            "{formattedDate}", DateFormat('dd/MM/yyyy').format(formatedDate));

        yield PrinterCommandReadyToPrintState(template);
      }

      else if (event.type == "PCN") {
        LoginModel user = await SqliteDB.instance.getLoginModelData();
        List<PRINTTEMPLATEBean?> printerTemplateList =
            await SqliteDB.instance.getPrintTemplateDataList('PCN');

        String template = "";
        String hour = "${event.data!['offencetimeRaw'].hour}";
        String minutes = "${event.data!['offencetimeRaw'].minute}";
        if ((printerTemplateList[0]?.CONTENTS ?? "").isNotEmpty) {
          template = printerTemplateList[0]?.CONTENTS ?? "";
        }
        //    template  = AppConfig.pCNPrintTemplateData;
        template = template.replaceAll(
            "{case_ref_number}", "${event.data!['case_ref_num']}");
        template = template.replaceAll("{offenceDate}",
            "${DateFormat('dd/MM/yyyy').format(event.data!['offencetimeRaw'])}");
        template =
            template.replaceAll("{vehicleReg}", "${event.data!['vehicle']}");
        template = template.replaceAll("{make}", "${event.data!['make']}");
        template = template.replaceAll("{model}", "${event.data!['model']}");
        template = template.replaceAll("{colour}", "${event.data!['color']}");
        template =
            template.replaceAll("{station}", "${event.data!['station']}");
        template = template.replaceAll(
            "{location}", "${event.data!['location']['location_name']}");
        template = template.replaceAll(
            "{offenceCommitted}", "${event.data!['reason_title']}");
        template = template.replaceAll(
            "{penaltyDue}", "${event.data!['reason_title']}");
        template =
            template.replaceAll("{username}", "${user.STUSER!.SUSERNAME!}");
        if (hour.length >= 2 && minutes.length >= 2) {
          template = template.replaceAll("{casetime}", "$hour:$minutes");
        }
        if (hour.length >= 2 && minutes.length < 2) {
          template = template.replaceAll("{casetime}", "$hour:0$minutes");
        }
        if (hour.length < 2 && minutes.length >= 2) {
          template = template.replaceAll("{casetime}", "0$hour:$minutes");
        } else {
          template = template.replaceAll("{casetime}", "0$hour:0$minutes");
        }
        yield PrinterCommandReadyToPrintState(template);
      } else if (event.type == "MG11") {
        Map<String, dynamic> data =
            BlocProvider.of<AddressUfnBloc>(event.context!).submitAddressMap;

        List<PRINTTEMPLATEBean?> printerTemplateList =
            await SqliteDB.instance.getPrintTemplateDataList('MG11');
        String template = "";
        // template  = AppConfig.mg11PrintTemplateDAta;
        if ((printerTemplateList[0]?.CONTENTS ?? "").isNotEmpty) {
          template = printerTemplateList[0]?.CONTENTS ?? "";
        }
        template =
            template.replaceAll("{case_ref_number}", "${data['caseNum']}");
        template =
            template.replaceAll("{amount_due}", "${data['outstanding']}");
        template = template.replaceAll("{amountPaid}", "${data['received']}");
        template = template.replaceAll(
            "{penaltyfaredue}", "${data['penalty_fare_due']}");
        template = template.replaceAll("{title}", "${data["title"]}");
        template = template.replaceAll("{firstName}", "${data['forename']}");
        template = template.replaceAll("{lastName}", "${data['surname']}");
        template = template.replaceAll(
            "{address}", "${data['address_1']} ${data['address_2']}");
        template = template.replaceAll("{city}", "${data['locality']}");
        template = template.replaceAll("{postcode}", "${data['post_code']}");
        template =
            template.replaceAll("{dateOfBirth}", "${data['dateofbirth']}");
        template = template.replaceAll(
            "{offenceDate}",
            DateFormat('dd/MM/yyyy')
                .format(DateFormat("dd-MM-yyyy").parse(data['offence_dt'])));
        template = template.replaceAll("{casetime}", "${data['offence_time']}");
        template =
            template.replaceAll("{travelledFrom}", "${data['boarded_at']}");
        template =
            template.replaceAll("{travelledTo}", "${data['alighted_at']}");
        template = template.replaceAll("{issuedAt}", "${data['issued_at']}");
        template =
            template.replaceAll("{issueReason}", "${data['reason_title']}");
        template =
            template.replaceAll("{travelClass}", "${data['otherClasses']}");
        template = template.replaceAll("{username}", "${data['username']}");
        DateTime today = DateTime.now();
        DateTime formattedDate =
            DateTime(today.year, today.month, today.day + 21);
        template = template.replaceAll(
            "{formattedDate}", DateFormat('dd/MM/yyyy').format(formattedDate));
        yield PrinterCommandReadyToPrintState(template);
      } else if (event.type == "TEST") {
        Map<String, dynamic> data =
            BlocProvider.of<AddressUfnBloc>(event.context!).submitAddressMap;

        String template = "";
        template = AppConfig.uFNPrintTemplateDataTestNotice;

        /*  List<PRINTTEMPLATEBean?>? printerTemplateList=  await SqliteDB.instance.getPrintTemplateDataList("UFN");
        if((printerTemplateList[0]?.CONTENTS ?? "").isNotEmpty) {
          template =printerTemplateList[0]?.CONTENTS ?? "";
        }*/
        template =
            template.replaceAll("{case_ref_number}", "${data['caseNum']}");
        template =
            template.replaceAll("{amount_due}", "${data['outstanding']}");
        template = template.replaceAll("{amountPaid}", "${data['received']}");
        template = template.replaceAll("{penaltyfaredue}", "${data['total']}");
        template = template.replaceAll("{title}", "${data["title"]}");
        template = template.replaceAll("{firstName}", "${data['forename']}");
        template = template.replaceAll("{lastName}", "${data['surname']}");
        template = template.replaceAll("{address}", "${data['address_1']}");
        template = template.replaceAll("{city}", "${data['locality']}");
        template = template.replaceAll("{postcode}", "${data['post_code']}");
        template =
            template.replaceAll("{dateOfBirth}", "${data['dateofbirth']}");
        template = template.replaceAll(
            "{offenceDate}",
            DateFormat('dd/MM/yyyy')
                .format(DateFormat("dd-MM-yyyy").parse(data['offence_dt'])));
        template = template.replaceAll("{casetime}", "${data['offence_time']}");
        template =
            template.replaceAll("{travelledFrom}", "${data['boarded_at']}");
        template =
            template.replaceAll("{travelledTo}", "${data['alighted_at']}");
        template = template.replaceAll("{issuedAt}", "${data['issued_at']}");
        template =
            template.replaceAll("{issueReason}", "${data['reason_Title']}");
        template =
            template.replaceAll("{travelClass}", "${data['otherClasses']}");
        template = template.replaceAll("{username}", "${data['username']}");
        DateTime today = DateTime.now();
        DateTime formatedDate =
            DateTime(today.year, today.month, today.day + 21);
        template = template.replaceAll(
            "{formattedDate}", DateFormat('dd/MM/yyyy').format(formatedDate));
        yield PrinterCommandReadyToPrintState(template);
      }
    } else if (event is PrintingDoneEvent) {
      yield PrintingDoneState(event.status);
    } else if (event is PrinterCheckStatusEvent) {
      locator<PrintingService>().checkPrinterHeadStatus();
    } else if (event is PrinterSaveStatusEvent) {
      yield PrinterCheckStatusHeadState(event.status);
    } else if (event is PrintingDoneEvent) {
      yield PrintingDoneState(event.status);
    }
  }
}
