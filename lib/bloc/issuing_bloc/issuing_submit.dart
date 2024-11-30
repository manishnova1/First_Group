// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:railpaytro/Ui/Utils/Utillities.dart';
import '../../common/locator/locator.dart';
import '../../common/service/dialog_service.dart';
import '../../constants/app_config.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/auth/login_model.dart';

class IssuingSubmitEvent {}

class issuingButtonEventPressed extends IssuingSubmitEvent {
  BuildContext? context;
  String reasonID;
  String reasonTxt;
  String caseID;

  issuingButtonEventPressed(
      {required this.context,
      required this.reasonID,
      required this.reasonTxt,
      required this.caseID});
}

class IssuingSubmitState {}

class IssuingSubmitFormInitialState extends IssuingSubmitState {}

class IssuingSubmitFormLoadingState extends IssuingSubmitState {}

class IssuingImageDeleteSuccessState extends IssuingSubmitState {}

class IssuingSubmitFormSuccessState extends IssuingSubmitState {
  String? fileName;
  String? fileSize;
  String? filePath;

  IssuingSubmitFormSuccessState({this.fileName, this.fileSize, this.filePath});
}

class IssuingFormErrorState extends IssuingSubmitState {
  String errorMsg;

  IssuingFormErrorState(this.errorMsg);
}

class IssuingSubmitFormBloc
    extends Bloc<IssuingSubmitEvent, IssuingSubmitState> {
  IssuingSubmitFormBloc() : super(IssuingSubmitFormLoadingState());

  @override
  Stream<IssuingSubmitState> mapEventToState(IssuingSubmitEvent event) async* {
    if (event is issuingButtonEventPressed) {
      LoginModel user = await SqliteDB.instance.getLoginModelData();

      Map<String, dynamic> dumpMap = {
        'action': AppConfig.revpSubmitIssuingCaseCancel,
        'tocid': AppConfig.tocId,
        'macAddress': user.STUSER?.MACADRESS!,
        'ssessionId': user.STCONFIG?.SAPPSESSIONID!,
        'userID': user.STUSER?.ID!,
        'reason_id': event.reasonID,
        'reason_text': event.reasonTxt,
        'caseid': event.caseID
      };

      submitIssuingCancelData(dumpMap, event.context!);
    }
  }

  Future submitIssuingCancelData(
      Map<String, dynamic> body, BuildContext context) async {
    locator<DialogService>().showLoader();

    final header = {
      "APIKey": AppConfig.apiKey,
    };

    var formData = FormData.fromMap(body);

    var response = await Dio().post(AppConfig.baseUrl + AppConfig.endPoint,
        data: formData, options: Options(headers: header));

    locator<DialogService>().hideLoader();

    if (response.statusCode == 200) {
      try {
        if (response.statusCode == 200) {
          Fluttertoast.showToast(msg: "Case details cancelled successfully.");
        } else {
          Fluttertoast.showToast(
              msg:
                  "Error - This case could not be cancelled. A report has been sent to the systems team. Please advise your Prosecutions Team separately.");
        }
      } catch (e) {
        Fluttertoast.showToast(
            msg:
                "Error - This case could not be cancelled. A report has been sent to the systems team. Please advise your Prosecutions Team separately.");
      }
    } else if (response.statusCode == 501) {
      Dialogs.showValidationMessage(context, response.data.MESSAGE);
    } else {
      var data = response.data;
      Dialogs.showValidationMessage(context, data['ERROR'][0]);
    }
  }
}
