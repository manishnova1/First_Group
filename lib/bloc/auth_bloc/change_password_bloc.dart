import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:railpaytro/common/locator/locator.dart';
import 'package:railpaytro/common/router/router.gr.dart';
import 'package:railpaytro/data/model/auth/login_model.dart';
import '../../common/service/dialog_service.dart';
import '../../common/service/navigation_service.dart';
import '../../data/local/sqlite.dart';
import '../../data/repo/auth_repo.dart';

class ChangePasswordEvent {}

class ChangePasswordRefreshEvent extends ChangePasswordEvent {
  String? password;

  ChangePasswordRefreshEvent({
    this.password,
  });
}

class ChangePasswordState {}

class ChangePasswordInitialState extends ChangePasswordState {}

class ChangePasswordLoadingState extends ChangePasswordState {}

class ChangePasswordSuccessState extends ChangePasswordState {
  ChangePasswordSuccessState();
}

class ChangePasswordErrorState extends ChangePasswordState {
  ChangePasswordErrorState();
}

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  AuthRepo authRepository;

  ChangePasswordBloc(this.authRepository) : super(ChangePasswordInitialState());

  @override
  Stream<ChangePasswordState> mapEventToState(
      ChangePasswordEvent event) async* {
    try {
      if (event is ChangePasswordRefreshEvent) {
        yield ChangePasswordLoadingState();
        locator<DialogService>().showLoader();
        LoginModel user = await SqliteDB.instance.getLoginModelData();
        final res = await authRepository.changePassword(
            userID: user.STUSER!.ID!, password: event.password!);
        locator<DialogService>().hideLoader();

        if (res.isSuccess) {
          Fluttertoast.showToast(
              msg: "Password Changed Successfully ",
              backgroundColor: Colors.black);
          locator<NavigationService>()
              .pushAndRemoveUntil(const LoginScreenRoute());
        } else {
          Fluttertoast.showToast(msg: res.error, backgroundColor: Colors.black);
          yield ChangePasswordErrorState();
        }
      }
    } catch (e, stacktrace) {
      debugPrint("$e : $stacktrace");
      yield ChangePasswordErrorState();
    }
  }
}
