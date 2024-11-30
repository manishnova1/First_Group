import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:railpaytro/data/model/summaryModel.dart';
import '../../common/locator/locator.dart';
import '../../common/router/router.gr.dart';
import '../../common/service/dialog_service.dart';
import '../../common/service/navigation_service.dart';
import '../../constants/app_config.dart';
import '../../constants/app_utils.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/auth/login_model.dart';
import '../../data/repo/auth_repo.dart';

class SettingsEvent {}

class SettingsInitialEvent extends SettingsEvent {}

class SettingsLogOutSummaryEvent extends SettingsEvent {
  BuildContext context;

  SettingsLogOutSummaryEvent(this.context);
}

class SettingsLogOutEvent extends SettingsEvent {}

class SettingsState {}

class SettingsInitialState extends SettingsState {}

class SettingsLoadingState extends SettingsState {}

class SettingsSuccessSummaryState extends SettingsState {
  var data;

  SettingsSuccessSummaryState(this.data);
}

class SettingsSuccessState extends SettingsState {
  SettingsSuccessState();
}

class SettingsErrorState extends SettingsState {
  SettingsErrorState();
}

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  AuthRepo authRepository;

  SettingsBloc(this.authRepository) : super(SettingsInitialState());
  List<summaryModel> summary = [];

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    try {
      if (event is SettingsLogOutEvent) {
        locator<DialogService>().showLoader();
        // LoginModel user = await SqliteDB.instance.getLoginModelData();
        LoginModel user = await SqliteDB.instance.getLoginModelData();
        final res = await authRepository.logOutService(
            sessionId: user.STCONFIG!.SAPPSESSIONID.toString(),
            macAddress: user.STUSER!.MACADRESS.toString());
        locator<DialogService>().hideLoader();

        if (res.isSuccess) {
          AppUtils().logoutUser();
          // DbController().delete();
          locator<NavigationService>()
              .pushAndRemoveUntil(const LoginScreenRoute());
          Fluttertoast.showToast(
              msg: "Successfully Signed Out", backgroundColor: Colors.black);
          yield SettingsSuccessState();
        } else {
          yield SettingsErrorState();
          locator<NavigationService>()
              .pushAndRemoveUntil(const LoginScreenRoute());
          Fluttertoast.showToast(
              msg: "Successfully Signed Out", backgroundColor: Colors.black);
        }
      }

      if (event is SettingsLogOutSummaryEvent) {
        summary.clear();
        locator<DialogService>().showLoader();

        LoginModel user = await SqliteDB.instance.getLoginModelData();

        Map<String, dynamic> dumpMap = {
          'action': AppConfig.goggetGestureDataBySessionID,
          'tocid': AppConfig.tocId,
          'macAddress': user.STUSER?.MACADRESS!,
          'ssessionId': user.STCONFIG?.SAPPSESSIONID!,
          'userID': user.STUSER?.ID!,
        };

        final header = {
          "APIKey": AppConfig.apiKey,
        };

        var formData = FormData.fromMap(dumpMap);

        var response = await Dio().post(AppConfig.baseUrl + AppConfig.endPoint,
            data: formData, options: Options(headers: header));

        locator<DialogService>().hideLoader();

        if (response.statusCode == 200) {
          var data = response.data;
          var res = data["REVPSESSIONSUMMARY"] ?? [];

          for (int i = 0; i < res.length; i++) {
            summary.add(summaryModel.fromJson(res[i]));
          }
          yield SettingsSuccessSummaryState(summary);
        } else if (response.statusCode == 501) {
          yield SettingsErrorState();
        } else {
          yield SettingsErrorState();
        }
      }
    } catch (e, stacktrace) {
      print("$e : $stacktrace");
      yield SettingsErrorState();
    }
  }
}
