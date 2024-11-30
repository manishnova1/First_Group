import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:railpaytro/bloc/ufn_luno_bloc/address_screen_bloc.dart';
import 'package:railpaytro/common/locator/locator.dart';
import '../../common/Utils/utils.dart';
import '../../common/service/dialog_service.dart';
import '../../constants/app_config.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/auth/login_model.dart';

class OffenderDescriptionEvent {}

class OffenderDescriptionDataEventMG11 extends OffenderDescriptionEvent {
  BuildContext context;
  String? build, bodyCamera, tattoDis, height, ethnicity, occupation;

  bool? tatto;
  String? type;
  String? caseNum;

  OffenderDescriptionDataEventMG11(
      {required this.context,
      this.occupation,
      this.build,
      this.bodyCamera,
      this.ethnicity,
      this.tatto,
      this.tattoDis,
      this.caseNum,
      this.type,
      this.height});
}

class OffenderDescriptionDataEventMG11face extends OffenderDescriptionEvent {
  BuildContext context;
  String? hairColor, eveColor, glasses, facialHair;
  String? type;

  OffenderDescriptionDataEventMG11face(
      {required this.context,
      this.hairColor,
      this.eveColor,
      this.facialHair,
      this.glasses,
      this.type});
}

class OffenderDescriptionBodyEvent extends OffenderDescriptionEvent {
  BuildContext context;
  String? build, bodyCamera, tattoDis, ethnicity, occupation;

  bool? tatto;
  String? type;
  String? caseNum;

  OffenderDescriptionBodyEvent(
      {required this.context,
      this.occupation,
      this.build,
      this.bodyCamera,
      this.ethnicity,
      this.tatto,
      this.tattoDis,
      this.caseNum,
      this.type});
}

class OffenderDescriptionDataEventPfn extends OffenderDescriptionEvent {
  BuildContext context;
  String? hairColor, eveColor, glasses, facialHair;
  String? type;

  OffenderDescriptionDataEventPfn(
      {required this.context,
      this.hairColor,
      this.eveColor,
      this.facialHair,
      this.glasses,
      this.type});
}

class OffenderDescriptionBodyEventPfn extends OffenderDescriptionEvent {
  BuildContext context;
  String? build, bodyCamera, tattoDis, height, ethnicity, occupation;

  bool? tatto;
  String? type;
  String? caseNum;

  OffenderDescriptionBodyEventPfn(
      {required this.context,
      this.occupation,
      this.build,
      this.bodyCamera,
      this.ethnicity,
      this.tatto,
      this.tattoDis,
      this.caseNum,
      this.type,
      this.height});
}

class OfflineOffenderDescriptionDataEvent extends OffenderDescriptionEvent {
  BuildContext context;
  Map<String, dynamic>? offlineRequest;

  OfflineOffenderDescriptionDataEvent({
    required this.context,
    this.offlineRequest,
  });
}

//State --------------------------
class OffenderDescriptionState {}

class OffenderDescriptionInitialState extends OffenderDescriptionState {}

class OffenderDescriptionLoadingState extends OffenderDescriptionState {}

class OffenderDescriptionSucessState extends OffenderDescriptionState {
  dynamic data;

  OffenderDescriptionSucessState(this.data);
}

class OffenderDescriptionErrorState extends OffenderDescriptionState {
  String error;

  OffenderDescriptionErrorState(this.error);
}

class OffenderDescriptionBloc
    extends Bloc<OffenderDescriptionEvent, OffenderDescriptionState> {
  Map<String, dynamic> dumpAddressMap = {};

  OffenderDescriptionBloc() : super(OffenderDescriptionInitialState());

  @override
  Stream<OffenderDescriptionState> mapEventToState(
      OffenderDescriptionEvent event) async* {
    try {
      // for search button -----

      if (event is OffenderDescriptionBodyEventPfn) {
        LoginModel user = await SqliteDB.instance.getLoginModelData();
        Map<String, dynamic> subMap =
            BlocProvider.of<AddressUfnBloc>(event.context).submitAddressMap;

        Map<String, dynamic> dumpMap = {
          'height': event.height,
          'occupation': event.occupation,
          'body_camera': event.bodyCamera,
          'build': event.build,
          'tatoos': (event.tatto ?? false) ? '1' : '0',
          'tatoo_desc':
              event.tattoDis.toString().isEmpty ? "0" : event.tattoDis,
          'ethnicity': event.ethnicity,
          "caseNum": subMap['caseNum']
        };

        dumpAddressMap.addAll(dumpMap);

      } else if (event is OfflineOffenderDescriptionDataEvent) {
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


            var data = response.data;
            if (response.statusCode == 200 && data is Map) {
              Utils.showToast(data['MESSAGE'].toString());
              Fluttertoast.showToast(msg: "Offender description added successfully");

              await SqliteDB.instance.deleteAPIRequestData(
                  caseNum: event.offlineRequest!['caseNum'],
                  subType: "offender");
            } else {
              Utils.showToast(data['ERROR'][0].toString());
            }
          } else {}
        } catch (e) {
          print(e.toString());
          locator<DialogService>().hideLoader();
          Utils.showToast(
              "Case couldn't saved, issue reported to further check, error");
        }
      }
    } catch (e, stacktrace) {
      debugPrint("$e : $stacktrace");
      yield OffenderDescriptionErrorState("Something Went Wrong");
    }
  }
}
