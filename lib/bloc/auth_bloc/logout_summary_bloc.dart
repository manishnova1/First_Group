// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/Ui/Utils/Utillities.dart';
import '../../common/Utils/utils.dart';
import '../../common/locator/locator.dart';
import '../../common/service/dialog_service.dart';
import '../../constants/app_config.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/auth/login_model.dart';

class LogoutSummaryEvent {}

class LogoutSummaryButtonEventPressed extends LogoutSummaryEvent {
  BuildContext? context;

  LogoutSummaryButtonEventPressed({
    required this.context,
  });
}

class LogoutSummaryState {}

class LogoutSummaryFormInitialState extends LogoutSummaryState {}

class LogoutSummaryFormLoadingState extends LogoutSummaryState {}

class LogoutSummaryDeleteSuccessState extends LogoutSummaryState {}

class IssuingSubmitFormSuccessState extends LogoutSummaryState {
  IssuingSubmitFormSuccessState();
}

class LogoutSummaryErrorState extends LogoutSummaryState {
  String errorMsg;

  LogoutSummaryErrorState(this.errorMsg);
}

//-----

class LogoutSummaryFormBloc
    extends Bloc<LogoutSummaryEvent, LogoutSummaryState> {
  LogoutSummaryFormBloc() : super(LogoutSummaryFormLoadingState());

  @override
  Stream<LogoutSummaryState> mapEventToState(LogoutSummaryEvent event) async* {
    if (event is LogoutSummaryButtonEventPressed) {
      LoginModel user = await SqliteDB.instance.getLoginModelData();

      Map<String, dynamic> dumpMap = {
        'action': AppConfig.goggetGestureDataBySessionID,
        'tocid': AppConfig.tocId,
        'macAddress': user.STUSER?.MACADRESS!,
        'ssessionId': user.STCONFIG?.SAPPSESSIONID!,
        'userID': user.STUSER?.ID!,
      };

      logoutSummary(dumpMap, event.context!);
    }
  }

  Future logoutSummary(Map<String, dynamic> body, BuildContext context) async {
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
        if (response.data['MESSAGE']
            .toString()
            .contains("added data successfully")) {
          Dialogs.successDialog(context);
        } else {
          Utils.showToast("error adding data");
        }
      } catch (e) {
        print(e.toString());
        Dialogs.showValidationMessage(
            context, "couldn't saved, issue reported to further check");
      }
    } else if (response.statusCode == 501) {
      Dialogs.showValidationMessage(context, response.data.MESSAGE);
    } else {
      var data = response.data;
      Dialogs.showValidationMessage(context, data['ERROR'][0]);
      // yield RevpTicketImageUploadErrorState(data['ERROR'][0]);
    }
  }
}
