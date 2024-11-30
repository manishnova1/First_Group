import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/common/locator/locator.dart';
import '../../Ui/Utils/HelpfullMethods.dart';
import '../../Ui/Utils/Utillities.dart';
import '../../common/router/router.gr.dart';
import '../../common/service/dialog_service.dart';
import '../../common/service/navigation_service.dart';
import '../../data/repo/auth_repo.dart';

class ForgotPassEvent {}

class ForgotPassRefreshEvent extends ForgotPassEvent {
  String? email;
  BuildContext context;

  ForgotPassRefreshEvent(this.email, this.context);
}

class ForgotPassState {}

class ForgotPassInitialState extends ForgotPassState {}

class ForgotPassLoadingState extends ForgotPassState {}

class ForgotPassSuccessState extends ForgotPassState {
  ForgotPassSuccessState();
}

class ForgotPassErrorState extends ForgotPassState {
  ForgotPassErrorState();
}

class ForgotPassBloc extends Bloc<ForgotPassEvent, ForgotPassState> {
  AuthRepo authRepository;

  ForgotPassBloc(this.authRepository) : super(ForgotPassInitialState());

  @override
  Stream<ForgotPassState> mapEventToState(ForgotPassEvent event) async* {
    try {
      if (event is ForgotPassRefreshEvent) {
        yield ForgotPassLoadingState();
        locator<DialogService>().showLoader();
        var id = await getId();
        final res = await authRepository.checkCustomerEmail(
            email: event.email!, macAddress: id!);
        locator<DialogService>().hideLoader();
        if (res.isSuccess) {
          Dialogs.showValidationMessage(event.context,
              "Password Reset Link Sent To ${event.email} Successfully");
          //Route to Home
          locator<NavigationService>()
              .pushAndRemoveUntil(VerifyOtpWidgetRoute(tag: ''));
        } else {
          Dialogs.showValidationMessage(event.context, "User Not Found");

          yield ForgotPassErrorState();
        }
      }
    } catch (e, stacktrace) {
      debugPrint("$e : $stacktrace");
      yield ForgotPassErrorState();
    }
  }
}
