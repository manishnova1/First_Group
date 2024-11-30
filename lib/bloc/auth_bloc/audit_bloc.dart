import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/common/locator/locator.dart';
import 'package:railpaytro/data/model/auth/login_model.dart';
import '../../common/router/router.gr.dart';
import '../../common/service/dialog_service.dart';
import '../../common/service/navigation_service.dart';
import '../../data/local/sqlite.dart';
import '../../data/repo/auth_repo.dart';

class AuditLogEvent {}

class AuditLogCallEvent extends AuditLogEvent {
  String? tag;

  AuditLogCallEvent({
    this.tag,
  });
}

class AuditLogState {}

class AuditLogInitialState extends AuditLogState {}

class AuditLogLoadingState extends AuditLogState {}

class AuditLogSuccessState extends AuditLogState {
  AuditLogSuccessState();
}

class AuditLogErrorState extends AuditLogState {
  AuditLogErrorState();
}

class AuditLogBloc extends Bloc<AuditLogEvent, AuditLogState> {
  AuthRepo authRepository;

  AuditLogBloc(this.authRepository) : super(AuditLogInitialState());

  @override
  Stream<AuditLogState> mapEventToState(AuditLogEvent event) async* {
    try {
      if (event is AuditLogCallEvent) {
        yield AuditLogLoadingState();
        locator<DialogService>().showLoader();

        LoginModel user = await SqliteDB.instance.getLoginModelData();

        // Selected train routeId: 202208318053465 with 15:12   Market Rasen - Leicester

        final res = await authRepository.addAuditLog(
            userID: user.STUSER!.ID!,
            sSessionID: user.STCONFIG!.SAPPSESSIONID!,
            description: 'Dummy Description For Testing');

        if (res.isSuccess) {
          yield AuditLogSuccessState();
          locator<DialogService>().hideLoader();
          // if (event.tag != null && event.tag == "") {
          ///Updated for apk
          locator<NavigationService>().pushAndRemoveUntil(
              UnPaidFareIssueMainRoute(isOfflineApiRequired: false));

          // }
        } else {
          // Fluttertoast.showToast(msg: "User Not Found", backgroundColor: Colors.black);
          yield AuditLogErrorState();
          locator<DialogService>().hideLoader();
        }
      }
    } catch (e, stacktrace) {
      debugPrint("$e : $stacktrace");
      yield AuditLogErrorState();
      locator<DialogService>().hideLoader();
    }
  }
}
