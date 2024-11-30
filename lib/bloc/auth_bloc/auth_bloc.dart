import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/common/locator/locator.dart';
import 'package:railpaytro/data/local/sqlite.dart';
import '../../Ui/Utils/HelpfullMethods.dart';
import '../../Ui/Utils/Utillities.dart';
import '../../common/router/router.gr.dart';
import '../../common/service/dialog_service.dart';
import '../../common/service/navigation_service.dart';
import '../../common/service/toast_service.dart';
import '../../constants/app_utils.dart';
import '../../data/model/auth/login_model.dart';
import '../../data/repo/auth_repo.dart';

class LoginEvent {}

class LoginRefreshEvent extends LoginEvent {
  String? username;
  String? password;
  BuildContext context;
  String? azureToken;
  String? type;

  LoginRefreshEvent(
      this.context, this.username, this.password, this.azureToken, this.type);
}

class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  LoginModel? loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginState {
  LoginErrorState();
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepo authRepository;

  LoginBloc(this.authRepository) : super(LoginInitialState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginRefreshEvent) {
      yield LoginLoadingState();
      try {
        locator<DialogService>().showLoader();
        var id = await getId();

        final res = await authRepository.loginUser(
            userName: event.username!,
            password: event.password!,
            azureToken: event.azureToken!,
            type: event.type!,
            macAddress: id!);

        if (res.data.STATUS == 200 &&
            (res.data.STUSER?.DAYLEFTFORCHANGEPASSWORD)! <= 0) {
          locator<ToastService>().showValidationMessageResetPassword(
              event.context,
              "Your Password has been expired please reset your Password");
          locator<DialogService>().hideLoader();
        } else if (res.data.STATUS == 200) {
          AppUtils().setUserLoggedIn(true);
          AppUtils().setUserSessionIn();
          await SqliteDB.instance.insertLoginModel(res.data);
          Dialogs.showValidationMessage(
              event.context, "Logged in Successfully");
          yield LoginSuccessState(res.data);
        } else if (res.data.STATUS == 203) {
          locator<NavigationService>().push(const ForgotPasswordRoute());
          locator<DialogService>().hideLoader();
        } else if (res.data.STATUS == 400) {
          locator<ToastService>().showValidationMessage(event.context,
              "There is already an open session on a different device with this user account. Please contact the System Administrator if there is a problem.");
          locator<DialogService>().hideLoader();
        } else if (res.data.STATUS == 401) {
          locator<ToastService>().showValidationMessage(
              event.context, "Invalid username or password");
          locator<DialogService>().hideLoader();
        } else if (res.data.STATUS == 402) {
          locator<ToastService>().showValidationMessage(event.context,
              "Account Locked - please contact System Administrator");
          locator<DialogService>().hideLoader();
        } else if (res.data.STATUS == 211) {
          locator<ToastService>().showValidationMessage(event.context,
              "User account not registered for this application");
          locator<DialogService>().hideLoader();
        } else if (res.data.STATUS == 500) {
          locator<ToastService>().showValidationMessage(event.context,
              "Account Locked - please contact System Administrator");
          locator<DialogService>().hideLoader();
        } else {
          locator<DialogService>().hideLoader();
          locator<ToastService>().showValidationMessage(
            event.context,
            res.error,
          );
          yield LoginErrorState();
          locator<DialogService>().hideLoader();
        }
      } catch (e, stacktrace) {
        locator<DialogService>().hideLoader();
        debugPrint("$e : $stacktrace");
        yield LoginErrorState();
        locator<ToastService>().showValidationMessage(
            event.context, "Invalid username or password");
      }
    }
  }
}
