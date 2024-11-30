import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/common/locator/locator.dart';
import 'package:railpaytro/data/sql_db/database_controller.dart';
import 'package:sqflite/sqflite.dart';
import '../../common/Utils/utils.dart';
import '../../common/router/router.gr.dart';
import '../../common/service/dialog_service.dart';
import '../../common/service/navigation_service.dart';
import '../../data/local/sqlite.dart';
import '../../data/offline/auth_offline/auth_offline_status.dart';
import '../../data/repo/auth_repo.dart';

class LandingEvent {}

class LandingInitialEvent extends LandingEvent {}

class LandingState {}

class LandingInitialState extends LandingState {}

class LandingLoadingState extends LandingState {}

class LandingSuccessState extends LandingState {
  LandingSuccessState();
}

class LandingErrorState extends LandingState {
  LandingErrorState();
}

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  AuthRepo authRepository;

  LandingBloc(this.authRepository) : super(LandingInitialState());

  @override
  Stream<LandingState> mapEventToState(LandingEvent event) async* {
    try {
      if (event is LandingInitialEvent) {
        yield LandingLoadingState();

        var isConnected = await Utils.checkInternet();
        var offlineCms = await AuthOfflineStatus().getCmsVarOfflineStatus();
        if (isConnected) {
          locator<DialogService>().showLoader();
          final res = await authRepository.getVariablesSettings();
          //storing cms variables data in db
          SqliteDB.instance.insertCMSVariable(res.data.CMSVARIABLES!);

          locator<DialogService>().hideLoader();
          if (res.isSuccess) {
            yield LandingSuccessState();
            locator<NavigationService>().popAndPush(const LoginScreenRoute());
          } else {
            yield LandingErrorState();
          }
        } else if (offlineCms) {
          Utils.showToast('Data received Offline');

          locator<NavigationService>().popAndPush(const LoginScreenRoute());
        } else {
          Utils.showToast('Please connect to internet and try again');
        }
      }
    } catch (e, stacktrace) {
      print("$e : $stacktrace");
      yield LandingErrorState();
    }
  }
}
