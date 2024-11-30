// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:railpaytro/Ui/Pages/Role_stationsTeam/unpaid_fare_issue/offender_description_face.dart';
import 'package:railpaytro/bloc/global_bloc.dart';
import 'package:railpaytro/common/service/toast_service.dart';
import '../../Ui/Pages/Role_stationsTeam/unpaid_fare_issue/addition_verification.dart';
import '../../Ui/Pages/Role_stationsTeam/unpaid_fare_issue/customer_confirmation.dart';
import '../../Ui/Pages/Role_stationsTeam/unpaid_fare_issue/offender_description.dart';
import '../../Ui/Pages/Role_stationsTeam/unpaid_fare_issue/unpaid_fare_notice_successfull.dart';
import '../../Ui/Pages/Role_stationsTeam/unpaid_fare_issue/zero_fare_ticket_information.dart';
import '../../common/Utils/utils.dart';
import '../../common/locator/locator.dart';
import '../../common/router/router.gr.dart';
import '../../common/service/dialog_service.dart';
import '../../common/service/navigation_service.dart';
import '../../constants/app_config.dart';
import '../../constants/app_utils.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/auth/login_model.dart';
import '../../data/repo/ufn_repo.dart';
import 'address_screen_bloc.dart';
import 'image_submit_bloc.dart';

class SubmitFormEvent {}

class PaymentFormEvent extends SubmitFormEvent {
  BuildContext? context;
  String? total, received, outstanding;

  PaymentFormEvent({this.context, this.total, this.received, this.outstanding});
}

class AdditionalVerifyEvent extends SubmitFormEvent {
  BuildContext? context;
  String? type, notes;

  AdditionalVerifyEvent({this.context, this.type, this.notes});
}

class CustomerSignEvent extends SubmitFormEvent {
  BuildContext context;
  String? refuseSign, unableSign, reason, sendCopyEmail;
  File image;

  CustomerSignEvent(
      {required this.context,
      this.refuseSign,
      this.unableSign,
      this.reason,
      required this.image,
      this.sendCopyEmail});
}

class ZeroFareIssuedEvent extends SubmitFormEvent {
  BuildContext context;
  String? ticketNumber;

  ZeroFareIssuedEvent({required this.context, this.ticketNumber});
}

class OffenderDescriptionEventBody extends SubmitFormEvent {
  BuildContext context;
  String? build, bodyCamera, tattoDis, height, ethnicity, occupation;

  bool? tatto;

  OffenderDescriptionEventBody(
      {required this.context,
      this.occupation,
      this.build,
      this.bodyCamera,
      this.ethnicity,
      this.tatto,
      this.tattoDis,
      this.height});
}

class OffenderDescriptionEvent extends SubmitFormEvent {
  BuildContext context;
  String? hairColor, eveColor, glasses, facialHair;

  OffenderDescriptionEvent(
      {required this.context,
      this.hairColor,
      this.eveColor,
      this.facialHair,
      this.glasses});
}

class OfflineOffenderDescriptionEvent extends SubmitFormEvent {
  BuildContext context;
  Map<String, dynamic>? offlineRequest;

  OfflineOffenderDescriptionEvent({
    required this.context,
    this.offlineRequest,
  });
}

class SubmitFormState {

}

class SubmitFormInitialState extends SubmitFormState {}

class SubmitFormLoadingState extends SubmitFormState {}

class ImageDeleteSuccessState extends SubmitFormState {}

class SubmitFormSuccessState extends SubmitFormState {
  String? fileName;
  String? fileSize;
  String? filePath;

  SubmitFormSuccessState({this.fileName, this.fileSize, this.filePath});
}

class SubmitFormErrorState extends SubmitFormState {
  String errorMsg;

  SubmitFormErrorState(this.errorMsg);
}

//-----

class SubmitFormBloc extends Bloc<SubmitFormEvent, SubmitFormState> {
  UfnRepo ufnRepo;

  SubmitFormBloc(this.ufnRepo) : super(SubmitFormLoadingState());

  Map<String, dynamic> tempMap = {};
  List<Map<String, dynamic>> imageMapList = [];
  Map<String, dynamic> dumpAddressMap = {};

  @override
  Stream<SubmitFormState> mapEventToState(SubmitFormEvent event) async* {
    if (event is PaymentFormEvent) {
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
          MaterialPageRoute(builder: (context) => additionVerification()));
      //----------------------------------------------
    } else if (event is AdditionalVerifyEvent) {
      Map<String, dynamic> subMap =
          BlocProvider.of<AddressUfnBloc>(event.context!).submitAddressMap;

      Map<String, dynamic> dumpMap = {
        'verification_type': event.type,
        'additional_info': event.notes,
      };

      subMap.addAll(dumpMap);

      BlocProvider.of<AddressUfnBloc>(event.context!).submitAddressMap = subMap;

      Navigator.push(event.context!,
          MaterialPageRoute(builder: (context) => customerConfirmation()));
    }
    //------------------------------------------------
    else if (event is CustomerSignEvent) {
      Map<String, dynamic> subMap =
          BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap;

      Map<String, dynamic> dumpMap = {
        'refuse_sign': event.refuseSign,
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
      BlocProvider.of<GlobalBloc>(event.context)
          .caseDetailsList
          .forEach((element) async {
        if (element!.cASETYPECODE == 'UFN') {
          if (element.eNABLESTATTUS == "1") {
            Navigator.push(
                event.context,
                MaterialPageRoute(
                    builder: (context) => zeroFareTicketInformation()));
          } else {
            Map<String, dynamic> subMap =
                BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap;
            var list = await SqliteDB.instance.getReferenceList();
            var caseNum = '';

            for (var e in list) {
              if (e!.ISUSED == 0 &&
                  e.ISLOCKED == 1 &&
                  e.CASE_REFERENCE_NO!.toLowerCase().contains('ln/ufn')) {
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
              // subMap.remove('postcode_details');
              // subMap.remove('reason_title');

              BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap =
                  subMap;
              // Navigator.push(
              //     event.context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             OffenderDescription()));
              submitUfnData(subMap, event.context, true);
            } else {
              Fluttertoast.showToast(msg: 'Case Reference not find ');
            }
          }
        }
      });
    }
    //-------------------------------------------------
    else if (event is ZeroFareIssuedEvent) {
      Map<String, dynamic> subMap =
          BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap;
      var list = await SqliteDB.instance.getReferenceList();
      var caseNum = '';

      for (var e in list) {
        if (e!.ISUSED == 0 &&
            e.ISLOCKED == 1 &&
            e.CASE_REFERENCE_NO!.toLowerCase().contains('ln/ufn')) {
          caseNum = e.CASE_REFERENCE_NO ?? '';
          print('Case matched ${list.length}');
          break;
        }
      }

//
      ///Need to update in local db

      Map<String, dynamic> dumpMap = {
        'zeroFareticketnumber': event.ticketNumber,
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
        // subMap.remove('postcode_details');
      //  subMap.remove('reason_title');
        BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap =
            subMap;
        // Navigator.push(
        //     event.context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             OffenderDescription()));
         submitUfnData(subMap, event.context, true);
      } else {
        Fluttertoast.showToast(msg: 'Case Reference not find ');
      }
    }
    //-------------------------------------------------
    else if (event is OffenderDescriptionEventBody) {
      LoginModel user = await SqliteDB.instance.getLoginModelData();
      Map<String, dynamic> subMap =
          BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap;

      Map<String, dynamic> dumpMap = {
        'occupation': event.occupation,
        'body_camera': event.bodyCamera,
        'build': event.build,
        'tatoos': (event.tatto ?? false) ? '1' : '0',
        'tatoo_desc': event.tattoDis.toString().isEmpty ? "0" : event.tattoDis,
        'ethnicity': event.ethnicity,
        'height': event.height,
        "caseNum": subMap['caseNum']
      };

      dumpAddressMap.addAll(dumpMap);
      Navigator.push(event.context!,
          MaterialPageRoute(builder: (context) => OffenderDescriptionFace()));
    }
    else if (event is OffenderDescriptionEvent) {
      LoginModel user = await SqliteDB.instance.getLoginModelData();

      Map<String, dynamic> dumpMap = {
        'eye_color': event.eveColor,
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
      dumpAddressMap.addAll(dumpMap);
      final header = {
        "APIKey": AppConfig.apiKey,
      };

      try {
        bool checkInternet = await Utils.checkInternet();
        if (checkInternet) {
          locator<DialogService>().showLoader();

          var formData = FormData.fromMap(dumpAddressMap);

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
            BlocProvider.of<ImageSubmitBloc>(event.context)
                .imageMapList
                .clear();
            dumpAddressMap.clear();

          } else {
            locator<ToastService>().showValidationMessage(
                event.context!, data['ERROR'][0].toString());
          }
        } else {
          // save request of UFN
          await SqliteDB.instance.insertAPIRequestData({
            "id": dumpAddressMap['caseNum'],
            "body": jsonEncode(dumpAddressMap),
            "request_section": "UFN(LUNO)",
            "request_sub_section": "offender",
          });
          locator<NavigationService>().pushAndRemoveUntil(
              UnPaidFareIssueMainRoute(isOfflineApiRequired: false));

          BlocProvider.of<AddressUfnBloc>(event.context)
              .submitAddressMap
              .clear();
          dumpAddressMap.clear();
        }
      } catch (e) {
        print(e.toString());
        locator<DialogService>().hideLoader();
        locator<ToastService>().showValidationMessage(event.context!,
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
          // locator<DialogService>().showLoader();

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
            locator<ToastService>().showValidationMessage(
                event.context!, data['ERROR'][0].toString());
          }
        }
      } catch (e) {
        print(e.toString());
        locator<DialogService>().hideLoader();
        locator<ToastService>().showValidationMessage(event.context!,
            "Case couldn't saved, issue reported to further check, error");
      }
    }
  }
}


Future submitUfnData(Map<String, dynamic> bodyData, BuildContext context,
    bool isOnlineMode) async {
  Map<String, dynamic> body = {};
  body.addAll(bodyData);
  BlocProvider.of<AddressUfnBloc>(context)
      .add(AddressPfnSaveCaseNumber(bodyData['caseNum']));
  bool checkInternet = await Utils.checkInternet();
  if (checkInternet) {
    if (isOnlineMode)
      locator<DialogService>().showLoaderwithHide(dismissable: false);
    if (body['ticketImage'] is String &&
        body['ticketImage'].toString().isNotEmpty) {
      body['ticketImage'] = await MultipartFile.fromFile(
          body['ticketImage'].toString(),
          filename: body['ticketImage'].toString().split('/').last);
    }

    var formData = FormData.fromMap(body);
    final dio = Dio();
    dio.options = BaseOptions(
      baseUrl: AppConfig.baseUrl,
      receiveTimeout: 5000,
      headers: {
        'APIKey': "00112233",
      },
      followRedirects: true,
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) async {
        if (error.type == DioErrorType.receiveTimeout) {
          locator<DialogService>().hideLoader();
          if (bodyData['caseNum'] != null && isOnlineMode) {
            // save request of UFN
            await SqliteDB.instance.insertAPIRequestData({
              "id": bodyData['caseNum'],
              "body": jsonEncode(bodyData),
              "request_section": "UFN(LUNO)",
              "request_sub_section": "main",
            });
            List<Map<String, dynamic>> imageMapSyncList =
                BlocProvider.of<ImageSubmitBloc>(context).imageMapList;
            await Future.forEach(imageMapSyncList, (dynamic request) async {
              // save request of UFN
              await SqliteDB.instance.insertAPIImagesRequestData(
                  bodyData['caseNum'],
                  jsonEncode(request["data"]),
                  request["path"],
                  request["type"],
                  "UFN(LUNO)",
                  "main");
            });
            locator<ToastService>().showValidationMessage(
                context, "Data has been saved successfully into database");

            //update case number :
            await SqliteDB.instance.updateCaseRef(body['caseNum']);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => unpaidfareNoticeSuccessfull(
                          caseNumber: BlocProvider.of<AddressUfnBloc>(context)
                              .caseNumber,
                        )));
          }
        }
        return handler.next(error);
      },
    ));
    var response = await dio.post(AppConfig.endPoint, data: formData);

    locator<DialogService>().hideLoader();

    if (response.statusCode == 200 && response.data is Map) {
      try {
        if (response.data['MESSAGE']
            .toString()
            .contains("Case details added successfully")) {
          Fluttertoast.showToast(msg: "Case details added successfully.");

          if (isOnlineMode) {
            await SqliteDB.instance.updateCaseRef(body['caseNum']);
            if (body['caseNum'] != null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => unpaidfareNoticeSuccessfull(
                            caseNumber: body['caseNum'],
                          )));
            }
          } else {
            await SqliteDB.instance.deleteAPIRequestData(
                caseNum: body['caseNum'], subType: "main");
            await SqliteDB.instance.deleteImagesData(body['caseNum']);
          }
        } else {
          locator<ToastService>().showValidationMessage(
              context, "Case couldn't saved, issue reported to further check");
        }
      } catch (e) {
        locator<ToastService>().showValidationMessage(context,
            "Case couldn't saved, issue reported to further check, error");
      }
    } else if (response.statusCode == 501) {
      locator<ToastService>()
          .showValidationMessage(context, response.data.MESSAGE);
    }
  } else {
    if (body['caseNum'] != null) {
      // save request of UFN
      await SqliteDB.instance.insertAPIRequestData({
        "id": body['caseNum'],
        "body": jsonEncode(body),
        "request_section": "UFN(LUNO)",
        "request_sub_section": "main",
      });
      List<Map<String, dynamic>> imageMapSyncList =
          BlocProvider.of<ImageSubmitBloc>(context).imageMapList;
      await Future.forEach(imageMapSyncList, (dynamic request) async {
        // save request of UFN
        await SqliteDB.instance.insertAPIImagesRequestData(
            body['caseNum'],
            jsonEncode(request["data"]),
            request["path"],
            request["type"],
            "UFN",
            "main");
      });
      locator<ToastService>().showValidationMessage(
          context, "Data has been saved successfully into database");

      //update case number :
      await SqliteDB.instance.updateCaseRef(body['caseNum']);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => unpaidfareNoticeSuccessfull(
                    caseNumber:
                        BlocProvider.of<AddressUfnBloc>(context).caseNumber,
                  )));
    }
  }
}
