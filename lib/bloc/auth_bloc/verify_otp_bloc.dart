import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/common/locator/locator.dart';
import 'package:railpaytro/common/router/router.gr.dart';

import '../../Ui/Utils/Utillities.dart';
import '../../common/service/dialog_service.dart';
import '../../common/service/navigation_service.dart';
import '../../data/repo/auth_repo.dart';

class VerifyOtpEvent {}

class VerifyOtpRefreshEvent extends VerifyOtpEvent {
  BuildContext context;
  String? email;
  String? otp;

  VerifyOtpRefreshEvent({this.email, this.otp, required this.context});
}

class VerifyOtpState {}

class VerifyOtpInitialState extends VerifyOtpState {}

class VerifyOtpLoadingState extends VerifyOtpState {}

class VerifyOtpSuccessState extends VerifyOtpState {
  VerifyOtpSuccessState();
}

class VerifyOtpErrorState extends VerifyOtpState {
  VerifyOtpErrorState();
}

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  AuthRepo authRepository;

  VerifyOtpBloc(this.authRepository) : super(VerifyOtpInitialState());

  @override
  Stream<VerifyOtpState> mapEventToState(VerifyOtpEvent event) async* {
    try {
      if (event is VerifyOtpRefreshEvent) {
        yield VerifyOtpLoadingState();
        locator<DialogService>().showLoader();
        final res = await authRepository.resetPasswordVerifyOtp(
            email: event.email!, otp: event.otp!);
        locator<DialogService>().hideLoader();

        if (res.isSuccess) {
          if (res.data['MESSAGE'] == "One Time Passcode Not Verified") {
            Dialogs.showValidationMessage(event.context, res.data['MESSAGE']);
          } else {
            locator<NavigationService>()
                .pushAndRemoveUntil(const ChangePasswordWidgetRoute());
            Dialogs.showValidationMessage(event.context, res.data['MESSAGE']);
          }
        } else {
          Dialogs.showValidationMessage(event.context, res.data['MESSAGE']);
        }
      } else {
        yield VerifyOtpErrorState();
      }
    } catch (e, stacktrace) {
      debugPrint("$e : $stacktrace");
      yield VerifyOtpErrorState();
    }
  }
}
