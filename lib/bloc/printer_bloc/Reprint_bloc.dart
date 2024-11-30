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
import '../ufn_luno_bloc/address_screen_bloc.dart';

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

class PrinterReprintDiscoveryDoneEvent extends PrinterEvent {
  bool isDiscoveryDone;
  Map<String, dynamic> printerListFound = {};

  PrinterReprintDiscoveryDoneEvent(this.isDiscoveryDone,this.printerListFound);
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

class PrintercheckStatusEvent extends PrinterEvent {
  String status;

  PrintercheckStatusEvent(this.status);
}

class PrinterRotateEvent extends PrinterEvent {
  ZebraPrinter? zebraPrinter;

  PrinterRotateEvent(this.zebraPrinter);
}

class PrinterCheckStatusEvent extends PrinterEvent {
  PrinterCheckStatusEvent();
}

class PrinterSaveReprintStatusEvent extends PrinterEvent {
  String status;

  PrinterSaveReprintStatusEvent(this.status);
}

class PrintingDoneReprintEvent extends PrinterEvent {
  String status;
  PrintingDoneReprintEvent(this.status);

}class PrinterCaseEvent extends PrinterEvent {
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

class PrinterDiscoveryReprintDoneEvent extends PrinterState {
  PrinterDiscoveryReprintDoneEvent();
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
class PrintingDoneReprintState extends PrinterState {
  String status;
  PrintingDoneReprintState(this.status);
}

class PrinterReprintBloc extends Bloc<PrinterEvent, PrinterState> {
  Map<String, dynamic> printerListFound = {};
  String name = "";
  String ipAddress = "";
  bool isWifiPrinter = false;
  bool isDiscoveryDone = false;
  String status = "";
  String statusHead= "";
  PrinterReprintBloc() : super(PrinterInitialState());
  @override
  Stream<PrinterState> mapEventToState(PrinterEvent event) async* {
    LoginModel user = await SqliteDB.instance.getLoginModelData();

    if (event is PrinterToConnectEvent) {
      locator<PrintingService>().connectToPrinter(event.address);
      name = event.name;
      ipAddress = event.address;
      isWifiPrinter = event.isWifi;
      if(status == "Connected") {
        yield PrinterSelectedState(event.name, event.address, event.isWifi);
      }
      else {
        yield PrinterSelectedState("","" ,false);
      }
    }
    else if (event is PrinterHideLoaderEvent) {
      yield PrinterConnectedDoneState();
    }
    else if (event is PrinterDiscoverEvent) {
      yield PrinterConnectingLoadingState();
      locator<PrintingService>().discoveryPrinters();
    } else if (event is PrinterReprintDiscoveryDoneEvent) {
      printerListFound = event.printerListFound ;
      name = "";
      ipAddress = "";
      isWifiPrinter = false;

      isDiscoveryDone = event.isDiscoveryDone;
      yield PrinterConnectedDoneState();
      yield PrinterDiscoveryReprintDoneEvent  ();
    }
    else if (event is PrinterDisconnectEvent) {
      locator<PrintingService>().disconnect();
      printerListFound = {};
      name = "";
      ipAddress = "";
      isWifiPrinter = false;
    }
    else if (event is PrinterPrintCommandEvent) {
      locator<PrintingService>().print(event.zplCommand);
    }
    else if (event is PrinterCheckStatusEvent) {
      locator<PrintingService>().checkPrinterHeadStatus();

    }
    else if (event is PrinterSaveReprintStatusEvent) {
      statusHead = event.status;
      yield PrinterCheckStatusHeadState(event.status);
    }
    else if (event is PrintercheckStatusEvent) {
      status = event.status;

      yield PrinterStatusUpdateState(event.status);
    }
    else if (event is PrinterCaseEvent ) {
      if (event.type== "PF") {
        Map<String, dynamic> data =
            BlocProvider.of<AddressUfnBloc>(event.context!).submitAddressMap;

        List<PRINTTEMPLATEBean?> printerTemplateList =
        await SqliteDB.instance.getPrintTemplateDataList('PF');
        String template = "";

        if ((printerTemplateList[0]?.CONTENTS ?? "").isNotEmpty) {
          template = printerTemplateList[0]?.CONTENTS ?? "";
        }
        template = template.replaceAll("{case_ref_number}", "${data['stCaseDetails']['CASE_REF_NUMBER']}");
        template = template.replaceAll("{amount_due}", double.parse("${data['stCaseDetails']['OUTSTANDING']}").toStringAsFixed(2).padRight(4, '0'));
        template = template.replaceAll("{amountPaid}",double.parse("${data['stCaseDetails']['RECEIVED']}").toStringAsFixed(2));
        template = template.replaceAll("{penaltyfaredue}", double.parse("${data['stCaseDetails']['TOTAL']}").toStringAsFixed(2));
        template = template.replaceAll("{title}","${data['stCaseDetails']['TITLE']}");
        template = template.replaceAll("{firstName}","${data['stCaseDetails']['FORENAME']}");
        template = template.replaceAll("{lastName}","${data['stCaseDetails']['SURNAME']}");
        template = template.replaceAll("{address}", "${data['stCaseDetails']['ADDRESS']}");
        if ("${data['stCaseDetails']['CITY']}" == 'null') {template = template.replaceAll("{city}", "");
        } else {
          template = template.replaceAll("{city}",  "${data['stCaseDetails']['CITY']}");
        }
        template = template.replaceAll("{dateOfBirth}", DateFormat('dd/MM/yyyy').format(DateFormat("MMMM, dd yyyy HH:mm:ss Z").parse("${data['stCaseDetails']['DATEOFBIRTH']}")));
        template = template.replaceAll("{postcode}",  "${data['stCaseDetails']['POSTCODE']}");
        template = template.replaceAll("{offenceDate}", DateFormat('dd/MM/yyyy').format(DateFormat("MMMM, dd yyyy HH:mm:ss Z").parse("${data['stCaseDetails']['OFFENCEDATEANDTIME']}")));
        template = template.replaceAll("{casetime}", DateFormat('HH:mm').format(DateFormat("MMMM, dd yyyy HH:mm:ss Z").parse("${data['stCaseDetails']['OFFENCEDATEANDTIME']}")));
        template = template.replaceAll("{travelledFrom}","${data['stCaseDetails']['TRAVELLEDFROM']}");
        template = template.replaceAll("{travelledTo}", "${data['stCaseDetails']['TRAVELLEDTO']}");
        template = template.replaceAll("{issuedAt}","${data['stCaseDetails']['ISSUEDAT']}");
        template = template.replaceAll("{issueReason}", "${data['stCaseDetails']['RESONFORISSUE']}");
        template = template.replaceAll("{travelClass}",  "${data['stCaseDetails']['TRAVELCLASS']}");
        template = template.replaceAll("{username}", user.STUSER!.SUSERNAME!);
        DateTime today = DateTime.now();
        DateTime formattedDate =
        DateTime(today.year, today.month, today.day + 21);
        template = template.replaceAll(
            "{formattedDate}", DateFormat('dd/MM/yyyy').format(formattedDate));

        yield PrinterCommandReadyToPrintState(template);
      }

      else if (event.type== "PFN") {
        Map<String, dynamic> data =
            BlocProvider.of<AddressUfnBloc>(event.context!).submitAddressMap;
        List<PRINTTEMPLATEBean?> printerTemplateList =
        await SqliteDB.instance.getPrintTemplateDataList('PFN');
        String template = "";
        String pfn_discount_percentage = user.PFN_DISCOUNT_PERCENTAGE.toString();
        String pfn_total_penalty = user.PFN_TOTAL_PENALTY.toString();
        double valueAmount = double.parse(pfn_discount_percentage) / 100;
        double discountAmount = valueAmount * double.parse(pfn_total_penalty);
        String discountController = discountAmount.abs().toStringAsFixed(2);
        print(discountController);
        if ((printerTemplateList[0]?.CONTENTS ?? "").isNotEmpty) {
          template = printerTemplateList[0]?.CONTENTS ?? "";
        }
        var penalty_fare_due =
        ((double.tryParse("${data['stCaseDetails']['TOTAL']}".toString().replaceAll(",", "")) as double)
            + (double.tryParse(pfn_total_penalty.toString()) as double)).toStringAsFixed(2);
        print(penalty_fare_due.toString());
        String reducedTotalDue =  (double.parse("$penalty_fare_due") - 50).toStringAsFixed(2);
        String fullOutstandingAmount = double.parse("${data['stCaseDetails']['OUTSTANDING']}") == 0 ?'N/A' :(double.parse("${data['stCaseDetails']['OUTSTANDING']}") + 50).toStringAsFixed(2);
        String fareTravelled =  double.parse("${data['stCaseDetails']['TOTAL']}").toStringAsFixed(2);
        template = template.replaceAll("{case_ref_number}", "${data['stCaseDetails']['CASE_REF_NUMBER']}");
        template = template.replaceAll("{amount_due}", double.parse("${data['stCaseDetails']['OUTSTANDING']}").toStringAsFixed(2).padRight(4, '0'));
        template = template.replaceAll("{FullOutstandingAmount}",fullOutstandingAmount);
        template = template.replaceAll("{ReducedTotalDue}",reducedTotalDue);
        template = template.replaceAll("{FareTravelled}",fareTravelled);
        template = template.replaceAll("{amountPaid}",double.parse("${data['stCaseDetails']['RECEIVED']}").toStringAsFixed(2));
        template = template.replaceAll("{penaltyfaredue}" ,double.parse(penalty_fare_due).toStringAsFixed(2));
        template = template.replaceAll("{dateOfBirth}", DateFormat('dd/MM/yyyy').format(DateFormat("MMMM, dd yyyy HH:mm:ss Z").parse("${data['stCaseDetails']['DATEOFBIRTH']}")));

        template = template.replaceAll("{title}","${data['stCaseDetails']['TITLE']}");
        template = template.replaceAll("{firstName}","${data['stCaseDetails']['FORENAME']}");
        template = template.replaceAll("{lastName}","${data['stCaseDetails']['SURNAME']}");
        template = template.replaceAll("{address}", "${data['stCaseDetails']['ADDRESS']}");
        if ("${data['stCaseDetails']['CITY']}" == 'null') {template = template.replaceAll("{city}", "");
        } else {template = template.replaceAll("{city}",  "${data['stCaseDetails']['CITY']}");}
        template = template.replaceAll("{postcode}",  "${data['stCaseDetails']['POSTCODE']}");
        template = template.replaceAll("{offenceDate}", DateFormat('dd/MM/yyyy').format(DateFormat("MMMM, dd yyyy HH:mm:ss Z").parse("${data['stCaseDetails']['OFFENCEDATEANDTIME']}")));
        template = template.replaceAll("{casetime}", DateFormat('HH:mm').format(DateFormat("MMMM, dd yyyy HH:mm:ss Z").parse("${data['stCaseDetails']['OFFENCEDATEANDTIME']}")));
        template = template.replaceAll("{travelledFrom}","${data['stCaseDetails']['TRAVELLEDFROM']}");
        template = template.replaceAll("{travelledTo}", "${data['stCaseDetails']['TRAVELLEDTO']}");
        template = template.replaceAll("{issuedAt}","${data['stCaseDetails']['ISSUEDAT']}");
        template = template.replaceAll("{issueReason}", "${data['stCaseDetails']['RESONFORISSUE']}");
        template = template.replaceAll("{travelClass}",  "${data['stCaseDetails']['TRAVELCLASS']}");
        template = template.replaceAll("{username}", user.STUSER!.SUSERNAME!);
        DateTime today = DateTime.now();
        DateTime formattedDate = DateTime(today.year, today.month, today.day + 21);
        template = template.replaceAll(
            "{formattedDate}", DateFormat('dd/MM/yyyy').format(formattedDate));
        yield PrinterCommandReadyToPrintState(template);
      }


      else  if (event.type== "LN") {

        Map<String, dynamic> data = BlocProvider.of<AddressUfnBloc>(event.context!).submitAddressMap;
        String template  = "";
        List<PRINTTEMPLATEBean?>? printerTemplateList=  await SqliteDB.instance.getPrintTemplateDataList("UFN");
        if((printerTemplateList[0]?.CONTENTS ?? "").isNotEmpty) {
          template =printerTemplateList[0]?.CONTENTS ?? "";
        }
        template = template.replaceAll("{case_ref_number}", "${data['stCaseDetails']['CASE_REF_NUMBER']}");
        template = template.replaceAll("{amount_due}", double.parse("${data['stCaseDetails']['OUTSTANDING']}").toStringAsFixed(2).padRight(4, '0'));
        template = template.replaceAll("{amountPaid}",double.parse("${data['stCaseDetails']['RECEIVED']}").toStringAsFixed(2).padRight(4, '0'));
        template = template.replaceAll("{penaltyfaredue}",double.parse("${data['stCaseDetails']['TOTAL']}").toStringAsFixed(2).padRight(4, '0'));;
        template = template.replaceAll("{title}","${data['stCaseDetails']['TITLE']}");
        template = template.replaceAll("{firstName}","${data['stCaseDetails']['FORENAME']}");
        template = template.replaceAll("{lastName}","${data['stCaseDetails']['SURNAME']}");
        template = template.replaceAll("{address}", "${data['stCaseDetails']['ADDRESS']}");
        template = template.replaceAll("{city}",  "${data['stCaseDetails']['CITY']}");
        template = template.replaceAll("{postcode}",  "${data['stCaseDetails']['POSTCODE']}");
        template = template.replaceAll("{dateOfBirth}", DateFormat('dd/MM/yyyy').format(DateFormat("MMMM, dd yyyy HH:mm:ss Z").parse("${data['stCaseDetails']['DATEOFBIRTH']}")));
        template = template.replaceAll("{offenceDate}", DateFormat('dd/MM/yyyy').format(DateFormat("MMMM, dd yyyy HH:mm:ss Z").parse("${data['stCaseDetails']['OFFENCEDATEANDTIME']}")));
        template = template.replaceAll("{casetime}", DateFormat('HH:mm').format(DateFormat("MMMM, dd yyyy HH:mm:ss Z").parse("${data['stCaseDetails']['OFFENCEDATEANDTIME']}")));
        template = template.replaceAll("{travelledFrom}","${data['stCaseDetails']['TRAVELLEDFROM']}");
        template = template.replaceAll("{travelledTo}", "${data['stCaseDetails']['TRAVELLEDTO']}");
        template = template.replaceAll("{issuedAt}","${data['stCaseDetails']['ISSUEDAT']}");
        template = template.replaceAll("{issueReason}", "${data['stCaseDetails']['RESONFORISSUE']}");
        template = template.replaceAll("{travelClass}",  "${data['stCaseDetails']['TRAVELCLASS']}");
        template = template.replaceAll("{username}", user.STUSER!.SUSERNAME!);
        DateTime today = DateTime.now();
        DateTime formatedDate = DateTime(today.year ,today.month,today.day+21);
        template = template.replaceAll("{formattedDate}",DateFormat('dd/MM/yyyy').format(formatedDate));
        yield PrinterCommandReadyToPrintState(template);

      }
      else  if (event.type== "HT") {

        Map<String, dynamic> data = BlocProvider.of<AddressUfnBloc>(event.context!).submitAddressMap;
        String template  = "";
        List<PRINTTEMPLATEBean?>? printerTemplateList=  await SqliteDB.instance.getPrintTemplateDataList("UFN (HT)");
        if((printerTemplateList[0]?.CONTENTS ?? "").isNotEmpty) {
          template =printerTemplateList[0]?.CONTENTS ?? "";
        }
        template = template.replaceAll("{case_ref_number}", "${data['stCaseDetails']['CASE_REF_NUMBER']}");
        template = template.replaceAll("{amount_due}", double.parse("${data['stCaseDetails']['OUTSTANDING']}").toStringAsFixed(2).padRight(4, '0'));
        template = template.replaceAll("{amountPaid}",double.parse("${data['stCaseDetails']['RECEIVED']}").toStringAsFixed(2).padRight(4, '0'));
        template = template.replaceAll("{penaltyfaredue}",double.parse("${data['stCaseDetails']['TOTAL']}").toStringAsFixed(2).padRight(4, '0'));;
        template = template.replaceAll("{title}","${data['stCaseDetails']['TITLE']}");
        template = template.replaceAll("{firstName}","${data['stCaseDetails']['FORENAME']}");
        template = template.replaceAll("{lastName}","${data['stCaseDetails']['SURNAME']}");
        template = template.replaceAll("{address}", "${data['stCaseDetails']['ADDRESS']}");
        template = template.replaceAll("{city}",  "${data['stCaseDetails']['CITY']}");
        template = template.replaceAll("{postcode}",  "${data['stCaseDetails']['POSTCODE']}");
        template = template.replaceAll("{dateOfBirth}", DateFormat('dd/MM/yyyy').format(DateFormat("MMMM, dd yyyy HH:mm:ss Z").parse("${data['stCaseDetails']['DATEOFBIRTH']}")));
        template = template.replaceAll("{offenceDate}", DateFormat('dd/MM/yyyy').format(DateFormat("MMMM, dd yyyy HH:mm:ss Z").parse("${data['stCaseDetails']['OFFENCEDATEANDTIME']}")));
        template = template.replaceAll("{casetime}", DateFormat('HH:mm').format(DateFormat("MMMM, dd yyyy HH:mm:ss Z").parse("${data['stCaseDetails']['OFFENCEDATEANDTIME']}")));
        template = template.replaceAll("{travelledFrom}","${data['stCaseDetails']['TRAVELLEDFROM']}");
        template = template.replaceAll("{travelledTo}", "${data['stCaseDetails']['TRAVELLEDTO']}");
        template = template.replaceAll("{issuedAt}","${data['stCaseDetails']['ISSUEDAT']}");
        template = template.replaceAll("{issueReason}", "${data['stCaseDetails']['RESONFORISSUE']}");
        template = template.replaceAll("{travelClass}",  "${data['stCaseDetails']['TRAVELCLASS']}");
        template = template.replaceAll("{username}", user.STUSER!.SUSERNAME!);
        DateTime today = DateTime.now();
        DateTime formatedDate = DateTime(today.year ,today.month,today.day+21);
        template = template.replaceAll("{formattedDate}",DateFormat('dd/MM/yyyy').format(formatedDate));
        yield PrinterCommandReadyToPrintState(template);

      }

      else  if (event.type== "PCN") {
        LoginModel user = await SqliteDB.instance.getLoginModelData();
        List<PRINTTEMPLATEBean?> printerTemplateList = await SqliteDB.instance.getPrintTemplateDataList('PCN');
        Map<String, dynamic> data =
            BlocProvider.of<AddressUfnBloc>(event.context!).submitAddressMap;
        dynamic stCaseDetailsString = data['stCaseDetails']['CASE_REF_NUMBER'];
        print(stCaseDetailsString);
        String template  = "";
        if((printerTemplateList[0]?.CONTENTS ?? "").isNotEmpty) {
          template =printerTemplateList[0]?.CONTENTS ?? "";
        }
        String? inputDateStr = data['stCaseDetails']["PCNOFFENCE_DATE"];
        DateFormat inputFormat = DateFormat("MMMM, dd yyyy HH:mm:ss Z");
        DateFormat outputFormat = DateFormat("dd/MM/yyyy");
        DateTime dateTimeObj = inputFormat.parse(inputDateStr!);
        String outputDateStr = outputFormat.format(dateTimeObj);
        template = template.replaceAll("{case_ref_number}", "${data['stCaseDetails']['CASE_REF_NUMBER']}");
        template = template.replaceAll("{offenceDate}",outputDateStr);
        template = template.replaceAll("{vehicleReg}","${data['stCaseDetails']['VEHICLEREGNUM']}");
        template = template.replaceAll("{make}","${data['stCaseDetails']['MANUFACTURER']}");
        template = template.replaceAll("{model}","${data['stCaseDetails']['MODEL']}");
        template = template.replaceAll("{colour}", "${data['stCaseDetails']['COLOUR']}");
        template = template.replaceAll("{station}", "${data['stCaseDetails']['STATION_NAME']}");
        template = template.replaceAll("{location}", "${data!['stCaseDetails']['LOCATION_NAME']}");
        template = template.replaceAll("{offenceCommitted}","${data!['stCaseDetails']['PCNISSUINGREASON']}");
        template = template.replaceAll("{username}", "${user.STUSER!.SUSERNAME!}");
        String timeString = data!['stCaseDetails']["PCNOFFENCE_TIME"];
        List<String> parts = timeString.split(':');
        int hour = int.parse(parts[0]);
        int minute = int.parse(parts[1]);
        String formattedTime = "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
        template = template.replaceAll("{casetime}", "${formattedTime}");
        yield PrinterCommandReadyToPrintState(template);
      }


      else if (event.type=="MG11") {
        Map<String, dynamic> data =
            BlocProvider.of<AddressUfnBloc>(event.context!).submitAddressMap;
        List<PRINTTEMPLATEBean?> printerTemplateList = await SqliteDB.instance.getPrintTemplateDataList('MG11');
        String template  = "";
        if((printerTemplateList[0]?.CONTENTS ?? "").isNotEmpty) {
          template =printerTemplateList[0]?.CONTENTS ?? "";
        }
        template = template.replaceAll("{case_ref_number}", "${data['stCaseDetails']['CASE_REF_NUMBER']}");
        template = template.replaceAll("{amount_due}","${data['stCaseDetails']['OUTSTANDING']}");
        template = template.replaceAll("{amountPaid}","${data['stCaseDetails']['RECEIVED']}");
        template = template.replaceAll("{penaltyfaredue}","${data['stCaseDetails']['TOTAL']}");
        template = template.replaceAll("{title}","${data['stCaseDetails']['TITLE']}");
        template = template.replaceAll("{firstName}","${data['stCaseDetails']['FORENAME']}");
        template = template.replaceAll("{lastName}","${data['stCaseDetails']['SURNAME']}");
        template = template.replaceAll("{address}", "${data['stCaseDetails']['ADDRESS']}");
        template = template.replaceAll("{city}",  "${data['stCaseDetails']['CITY']}");
        template = template.replaceAll("{postcode}",  "${data['stCaseDetails']['POSTCODE']}");
        template = template.replaceAll("{dateOfBirth}", "${data['stCaseDetails']['DATEOFBIRTH']}");
        template = template.replaceAll("{offenceDate}", DateFormat('dd/MM/yyyy').format(DateFormat("MMMM, dd yyyy HH:mm:ss Z").parse("${data['stCaseDetails']['OFFENCEDATEANDTIME']}")));
        template = template.replaceAll("{casetime}", DateFormat('HH:mm').format(DateFormat("MMMM, dd yyyy HH:mm:ss Z").parse("${data['stCaseDetails']['OFFENCEDATEANDTIME']}")));
        template = template.replaceAll("{travelledFrom}","${data['stCaseDetails']['TRAVELLEDFROM']}");
        template = template.replaceAll("{travelledTo}", "${data['stCaseDetails']['TRAVELLEDTO']}");
        template = template.replaceAll("{issuedAt}","${data['stCaseDetails']['ISSUEDAT']}");
        template = template.replaceAll("{issueReason}", "${data['stCaseDetails']['RESONFORISSUE']}");
        template = template.replaceAll("{travelClass}",  "${data['stCaseDetails']['TRAVELCLASS']}");
        template = template.replaceAll("{username}", user.STUSER!.SUSERNAME!);
        DateTime today = DateTime.now();
        DateTime formattedDate = DateTime(today.year ,today.month,today.day+21);
        template = template.replaceAll("{formattedDate}",DateFormat('dd/MM/yyyy').format(formattedDate));
        yield PrinterCommandReadyToPrintState(template);

      }


    }

    else if(event is PrintingDoneReprintEvent){
      yield PrintingDoneReprintState(event.status);
    }
    else if (event is PrinterCheckStatusEvent) {
      locator<PrintingService>().checkPrinterHeadStatus();
    }
    else if (event is PrinterSaveReprintStatusEvent) {
      yield PrinterCheckStatusHeadState(event.status);
    }
    else if(event is PrintingDoneReprintEvent){
      yield PrintingDoneReprintState(event.status);
    }

  }
}
