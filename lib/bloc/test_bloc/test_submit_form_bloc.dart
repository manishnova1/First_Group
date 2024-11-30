// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:railpaytro/bloc/test_bloc/test_address_bloc.dart';
import 'package:railpaytro/bloc/test_bloc/test_image_submit_bloc.dart';
import '../../Ui/Pages/Role_stationsTeam/test_notice_case/test_addition_verification.dart';
import '../../Ui/Pages/Role_stationsTeam/test_notice_case/test_customer_confirmation.dart';
import '../../Ui/Pages/Role_stationsTeam/test_notice_case/test_offender_desc_face.dart';
import '../../Ui/Pages/Role_stationsTeam/test_notice_case/test_unpaid_fare_notice_successfull.dart';
import '../../Ui/Pages/Role_stationsTeam/test_notice_case/test_zero_fare_ticket_information.dart';
import '../../common/Utils/utils.dart';
import '../../common/locator/locator.dart';
import '../../common/router/router.gr.dart';
import '../../common/service/dialog_service.dart';
import '../../common/service/navigation_service.dart';
import '../../constants/app_config.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/auth/login_model.dart';
import '../../data/repo/ufn_repo.dart';
import '../../../../bloc/ufn_luno_bloc/address_screen_bloc.dart';

class TestSubmitFormEvent {}

class TestPaymentFormEvent extends TestSubmitFormEvent {
  BuildContext? context;
  String? total, received, outstanding;

  TestPaymentFormEvent(
      {this.context, this.total, this.received, this.outstanding});
}

class TestAdditionalVerifyEvent extends TestSubmitFormEvent {
  BuildContext? context;
  String? type, notes;

  TestAdditionalVerifyEvent({this.context, this.type, this.notes});
}

class TestCustomerSignEvent extends TestSubmitFormEvent {
  BuildContext context;
  String? refuseSign, unableSign, reason, sendCopyEmail;
  File image;

  TestCustomerSignEvent(
      {required this.context,
      this.refuseSign,
      this.unableSign,
      this.reason,
      required this.image,
      this.sendCopyEmail});
}

class TestZeroFareIssuedEvent extends TestSubmitFormEvent {
  BuildContext context;
  String? ticketNumber;

  TestZeroFareIssuedEvent({required this.context, this.ticketNumber});
}

class OffenderDescriptionEventBodyTest extends TestSubmitFormEvent {
  BuildContext context;
  String? build, bodyCamera, tattoDis, ethnicity, occupation;

  bool? tatto;

  OffenderDescriptionEventBodyTest(
      {required this.context,
      this.occupation,
      this.build,
      this.bodyCamera,
      this.ethnicity,
      this.tatto,
      this.tattoDis});
}

class OffenderDescriptionEvent extends TestSubmitFormEvent {
  BuildContext context;
  String? hairColor, height, eveColor, glasses, facialHair;

  OffenderDescriptionEvent(
      {required this.context,
      this.hairColor,
      this.eveColor,
      this.height,
      this.facialHair,
      this.glasses});
}

class OfflineOffenderDescriptionEvent extends TestSubmitFormEvent {
  BuildContext context;
  Map<String, dynamic>? offlineRequest;

  OfflineOffenderDescriptionEvent({
    required this.context,
    this.offlineRequest,
  });
}

class TestSubmitFormState {}

class TestSubmitFormInitialState extends TestSubmitFormState {}

class TestSubmitFormLoadingState extends TestSubmitFormState {}

class ImageDeleteSuccessState extends TestSubmitFormState {}

class TestSubmitFormSuccessState extends TestSubmitFormState {
  String? fileName;
  String? fileSize;
  String? filePath;

  TestSubmitFormSuccessState({this.fileName, this.fileSize, this.filePath});
}

class TestSubmitFormErrorState extends TestSubmitFormState {
  String errorMsg;

  TestSubmitFormErrorState(this.errorMsg);
}

//-----

class TestSubmitFormBloc
    extends Bloc<TestSubmitFormEvent, TestSubmitFormState> {
  UfnRepo ufnRepo;

  TestSubmitFormBloc(this.ufnRepo) : super(TestSubmitFormLoadingState());

  Map<String, dynamic> tempMap = {};
  List<Map<String, dynamic>> imageMapList = [];

  @override
  Stream<TestSubmitFormState> mapEventToState(
      TestSubmitFormEvent event) async* {
    if (event is TestPaymentFormEvent) {
      Map<String, dynamic> subMap =
          BlocProvider.of<AddressUfnBloc>(event.context!).submitAddressMap;
      print(event);
      var total_due_pound = event.total?.split('.')[0];
      var total_due_pence = event.total?.split('.')[1];
      var amt_recieved_pound = event.received?.split('.')[0];
      var amt_recieved_pence = event.received?.split('.')[1];
      var outstanding_pound = event.outstanding?.split('.')[0];
      var outstanding_pence = event.outstanding?.split('.')[1];
      Map<String, dynamic> dumpMap = {
        'total_due_pound': total_due_pound,
        'total_due_pence': total_due_pence,
        'amt_recieved_pound': amt_recieved_pound,
        'amt_recieved_pence': amt_recieved_pence,
        'outstanding_pound': outstanding_pound,
        'outstanding_pence': outstanding_pence,
        'smartcard_number': '',
        'outstanding': event.outstanding,
        'total': event.total,
        'received': event.received
      };

      subMap.addAll(dumpMap);

      BlocProvider.of<AddressUfnBloc>(event.context!).submitAddressMap = subMap;
      Navigator.push(event.context!,
          MaterialPageRoute(builder: (context) => testAdditionVerification()));
      //----------------------------------------------
    } else if (event is TestAdditionalVerifyEvent) {
      Map<String, dynamic> subMap =
          BlocProvider.of<AddressUfnBloc>(event.context!).submitAddressMap;

      Map<String, dynamic> dumpMap = {
        'verification_type': event.type,
        'additional_info': event.notes,
      };

      subMap.addAll(dumpMap);

      BlocProvider.of<AddressUfnBloc>(event.context!).submitAddressMap = subMap;

      Navigator.push(event.context!,
          MaterialPageRoute(builder: (context) => testCustomerConfirmation()));
    }
    //------------------------------------------------
    else if (event is TestCustomerSignEvent) {
      Map<String, dynamic> subMap =
          BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap;

      Map<String, dynamic> dumpMap = {
        'refuse_sign': '1', //event.refuseSign,
        'unable_sign': event.unableSign,

        /// will be changed
        // 'reason': event.reason,
        'send_copy_email': event.sendCopyEmail,
        'customeraddressmatch': '1',
        'nameMatch': '1',
        'ticketImage': event.image.path

        /// 'ticketImage': await MultipartFile.fromFile(event.image.path,
        //    filename: event.image.path.split('/').last)
      };
      subMap.addAll(dumpMap);

      BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap = subMap;
      LoginModel user = await SqliteDB.instance.getLoginModelData();
      if (user.REVPZEROFARETICKETENABLED
          .toString()
          .toLowerCase()
          .contains("true")) {
        Navigator.push(
            event.context,
            MaterialPageRoute(
                builder: (context) => TestZeroFareTicketInformation()));
      } else {
        Map<String, dynamic> subMap =
            BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap;
        var list = await SqliteDB.instance.getReferenceList();
        var caseNum = '';

        for (var e in list) {
          if (e!.ISUSED == 0 &&
              e.ISLOCKED == 1 &&
              e.CASE_REFERENCE_NO!.toLowerCase().contains('ufn')) {
            caseNum = e.CASE_REFERENCE_NO ?? '';
            print('Case matched ${list.length}');
            break;
          }
        }

        Map<String, dynamic> dumpMap = {
          'zeroFare ticket number': null,
          'caseNum': caseNum,
        };

        subMap.addAll(dumpMap);
        BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap =
            subMap;

        if (caseNum.isNotEmpty) {
          LoginModel user = await SqliteDB.instance.getLoginModelData();

          Map<String, dynamic> dumpMap = {
            'action': AppConfig.revpSubmitUnpaidFareNotice,
            'tocid': AppConfig.tocId,
            'macAddress': user.STUSER?.MACADRESS!,
            'ssessionId': user.STCONFIG?.SAPPSESSIONID!,
            'userID': user.STUSER?.ID!,
            "username": user.STUSER!.SUSERNAME,
            'selectedheadcode': '',
          };

          subMap.addAll(dumpMap);
          subMap.remove('postcode_details');
          subMap.remove('reason_title');
          BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap =
              subMap;

          submitTestData(subMap, event.context, true);
        } else {
          Fluttertoast.showToast(msg: 'Case Reference not find ');
        }
      }
    }
    //-------------------------------------------------
    else if (event is TestZeroFareIssuedEvent) {
      Map<String, dynamic> subMap =
          BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap;
      var list = await SqliteDB.instance.getReferenceList();
      var caseNum = '';

      for (var e in list) {
        if (e!.ISUSED == 0 &&
            e.ISLOCKED == 1 &&
            e.CASE_REFERENCE_NO!.toLowerCase().contains('ufn')) {
          caseNum = e.CASE_REFERENCE_NO ?? '';
          print('Case matched ${list.length}');
          break;
        }
      }

//
      ///Need to update in local db

      Map<String, dynamic> dumpMap = {
        'zeroFare ticket number': event.ticketNumber,
        'caseNum': caseNum,
        'body_camera': "Yes",
      };

      subMap.addAll(dumpMap);
      BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap = subMap;

      if (caseNum.isNotEmpty) {
        LoginModel user = await SqliteDB.instance.getLoginModelData();

        Map<String, dynamic> dumpMap = {
          'action': AppConfig.revpSubmitUnpaidFareNotice,
          'tocid': AppConfig.tocId,
          'macAddress': user.STUSER?.MACADRESS!,
          'ssessionId': user.STCONFIG?.SAPPSESSIONID!,
          'userID': user.STUSER?.ID!,
          "username": user.STUSER!.SUSERNAME,
          'selectedheadcode': '',
        };

        subMap.addAll(dumpMap);
        subMap.remove('postcode_details');
        subMap.remove('reason_title');
        BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap =
            subMap;

        submitTestData(subMap, event.context, true);
      } else {
        Fluttertoast.showToast(msg: 'Case Reference not find ');
      }
    }
    //-------------------------------------------------
    else if (event is OffenderDescriptionEventBodyTest) {
      LoginModel user = await SqliteDB.instance.getLoginModelData();
      Map<String, dynamic> subMap =
          BlocProvider.of<AddressTestBloc>(event.context).submitAddressMap;

      Map<String, dynamic> dumpMap = {
        'occupation': event.occupation,
        'body_camera': event.bodyCamera,
        'build': event.build,
        'tatoos': (event.tatto ?? false) ? '1' : '0',
        'tatoo_desc': event.tattoDis,
        'ethnicity': event.ethnicity,
        "caseNum": subMap['caseNum']
      };

      subMap.addAll(dumpMap);
      Navigator.push(
          event.context!,
          MaterialPageRoute(
              builder: (context) => OffenderDescriptionFacetest()));
    } else if (event is OffenderDescriptionEvent) {
      LoginModel user = await SqliteDB.instance.getLoginModelData();
      Map<String, dynamic> subMap =
          BlocProvider.of<AddressTestBloc>(event.context).submitAddressMap;

      Map<String, dynamic> dumpMap = {
        'height': event.height,
        'tatoo_desc': event.facialHair,
        'hair_color': event.hairColor,
        'glasses': event.glasses,
        'facial_hair_type': event.facialHair,
        'action': AppConfig.revpSaveCustomerDescription,
        'tocid': AppConfig.tocId,
        'macAddress': user.STUSER?.MACADRESS!,
        'selectedheadcode': '',
        'ssessionId': user.STCONFIG?.SAPPSESSIONID!,
        'userID': user.STUSER?.ID!,
        "username": user.STUSER!.SUSERNAME
      };

      final header = {
        "APIKey": AppConfig.apiKey,
      };

      try {
        bool checkInternet = await Utils.checkInternet();
        if (checkInternet) {
          locator<DialogService>().showLoader();

          var formData = FormData.fromMap(dumpMap);

          var response = await Dio().post(
              AppConfig.baseUrl + AppConfig.endPoint,
              data: formData,
              options: Options(headers: header));

          locator<DialogService>().hideLoader();
          var data = response.data;
          if (response.statusCode == 200) {
            Utils.showToast(data['MESSAGE'].toString());
            locator<NavigationService>().pushAndRemoveUntil(
                UnPaidFareIssueMainRoute(isOfflineApiRequired: false));

            BlocProvider.of<AddressUfnBloc>(event.context)
                .submitAddressMap
                .clear();
            BlocProvider.of<TestImageSubmitBloc>(event.context)
                .imageMapList
                .clear();
          } else {
            Utils.showToast(data['ERROR'][0].toString());
          }
        } else {
          // save request of UFN
          await SqliteDB.instance.insertAPIRequestData({
            "id": subMap['caseNum'],
            "body": jsonEncode(dumpMap),
            "request_section": "UFN",
            "request_sub_section": "offender",
          });
          locator<NavigationService>().pushAndRemoveUntil(
              UnPaidFareIssueMainRoute(isOfflineApiRequired: false));

          BlocProvider.of<AddressUfnBloc>(event.context)
              .submitAddressMap
              .clear();
        }
      } catch (e) {
        print(e.toString());
        Utils.showToast(
            "Case couldn't saved, issue reported to further check, error");
      }
    } else if (event is OfflineOffenderDescriptionEvent) {
      LoginModel user = await SqliteDB.instance.getLoginModelData();

      Map<String, dynamic> dumpMap = {
        'action': AppConfig.revpSaveCustomerDescription,
        'tocid': AppConfig.tocId,
        'macAddress': user.STUSER?.MACADRESS!,
        'selectedheadcode': '',
        'ssessionId': user.STCONFIG?.SAPPSESSIONID!,
        'userID': user.STUSER?.ID!,
        "username": user.STUSER!.SUSERNAME
      };
      event.offlineRequest!.addAll(dumpMap);

      final header = {
        "APIKey": AppConfig.apiKey,
      };

      try {
        bool checkInternet = await Utils.checkInternet();
        if (checkInternet) {
          locator<DialogService>().showLoader();

          var formData = FormData.fromMap(event.offlineRequest!);

          var response = await Dio().post(
              AppConfig.baseUrl + AppConfig.endPoint,
              data: formData,
              options: Options(headers: header));

          locator<DialogService>().hideLoader();
          var data = response.data;
          if (response.statusCode == 200 && data is Map) {
            Utils.showToast(data['MESSAGE'].toString());
            await SqliteDB.instance.deleteAPIRequestData(
                caseNum: event.offlineRequest!['caseNum'], subType: "offender");
          } else {
            Utils.showToast(data['ERROR'][0].toString());
          }
        }
      } catch (e) {
        print(e.toString());
        locator<DialogService>().hideLoader();
        Utils.showToast(
            "Case couldn't saved, issue reported to further check, error");
      }
    }
  }
}

Future submitTestData(Map<String, dynamic> bodyData, BuildContext context,
    bool isOnlineMode) async {
  Map<String, dynamic> body = bodyData;

  locator<DialogService>().OfflineSuccessAlertDialog(context);

  if (isOnlineMode) {
    await SqliteDB.instance.updateCaseRef(body['caseNum']);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TestUnpaidfareNoticeSuccessfull(
                  caseNumber: body['caseNum'] ?? "",
                )));
  }
}
