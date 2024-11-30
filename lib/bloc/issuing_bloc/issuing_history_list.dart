// ignore_for_file: use_build_context_synchronously
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:railpaytro/bloc/issuing_bloc/issuing_submit.dart';
import '../../Ui/Utils/HelpfullMethods.dart';
import '../../common/locator/locator.dart';
import '../../common/service/dialog_service.dart';
import '../../common/service/toast_service.dart';
import '../../data/local/sqlite.dart';
import '../../data/model/Issuing_History_Model.dart';
import '../../data/model/auth/login_model.dart';
import '../../data/repo/issuing_history_repo.dart';

class IssuingHistoryEvent {}

class IssuingHistoryInitRefresh extends IssuingSubmitEvent {}

class IssuingHistoryState {}

class IssuingInitialState extends IssuingHistoryState {}

class IssuingLoadingState extends IssuingHistoryState {}

class IssuingHistorySuccessState extends IssuingHistoryState {
  List<STCASEDETAILS?> issuingHistoryList = [];

  IssuingHistorySuccessState(this.issuingHistoryList);
}

class IssuingFormErrorState extends IssuingHistoryState {
  String errorMsg;

  IssuingFormErrorState(this.errorMsg);
}

class IssuingHistoryBloc
    extends Bloc<IssuingHistoryInitRefresh, IssuingHistoryState> {
  IssuingHistoryRepo _issuing_history_repo;
  List<STCASEDETAILS?> issuingHistoryList = [];

  IssuingHistoryBloc(this._issuing_history_repo) : super(IssuingLoadingState());

  @override
  Stream<IssuingHistoryState> mapEventToState(
      IssuingHistoryInitRefresh event) async* {
    if (event is IssuingHistoryInitRefresh) {
      issuingHistoryList.clear();
      locator<DialogService>().showLoaderwithHide(dismissable: false);
      LoginModel user = await SqliteDB.instance.getLoginModelData();
      var id = await getId();

      try {
        var response = await _issuing_history_repo.getIssuingHistoryList(
            sessionId: user.STCONFIG!.SAPPSESSIONID!,
            macAddress: id!,
            userID: user.STUSER!.ID!);
        Issuing_History issuing_historyModel = response.data as Issuing_History;
        issuingHistoryList = issuing_historyModel.sTCASEDETAILS ?? [];
        locator<DialogService>().hideLoader();

        emit(IssuingHistorySuccessState(issuingHistoryList));
      } catch (e) {
        locator<ToastService>()
            .showLong("Unable to fetch reference list list from DB");
      }
    }
  }
}
