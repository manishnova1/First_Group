import 'package:injectable/injectable.dart';
import 'package:railpaytro/constants/app_config.dart';
import 'package:railpaytro/data/model/Affected_toc_Model.dart';
import 'package:railpaytro/data/model/issuing_history_IR.dart';
import 'package:railpaytro/data/model/revpirDetailMode.dart';

import '../model/Issuing_History_Model.dart';
import '../model/car_parking_penalty/car_parking_penalty.dart';
import '../model/car_parking_penalty/case_reference_model.dart';
import '../model/car_parking_penalty/reason_for_issue_list_model.dart';
import '../model/print_template_ditales.dart';
import '../model/car_parking_penalty/submit_penaltey_model.dart';
import '../network/result.dart';
import '../service/car_panelty_service/service_car_penalty.dart';
import '../service/issuing_history_service/service_issuing_history.dart';
import 'base/base_repository.dart';

@lazySingleton
class IssuingHistoryRepo extends BaseRepository {
  Future<Result<Issuing_History>> getIssuingHistoryList(
          {required String sessionId,
          required String macAddress,
          required String userID}) async =>
      safeCall(
          IssuingHistoryService(await dio).getHistoryUser(AppConfig.apiKey, {
        "action": AppConfig.getCaseHistoryUser,
        "tocid": AppConfig.tocId,
        "ssessionId": sessionId,
        "macAddress": macAddress,
        "userID": userID,
      }));

  Future<Result<IssuingHistoryIRModel>> getIssuingHistoryListIR(
          {required String sessionId,
          required String macAddress,
          required String userID}) async =>
      safeCall(
          IssuingHistoryService(await dio).getHistoryUserIR(AppConfig.apiKey, {
        "action": AppConfig.getCaseHistoryUserIR,
        "tocid": AppConfig.tocId,
        "ssessionId": sessionId,
        "macAddress": macAddress,
        "userID": userID,
      }));

//
}
