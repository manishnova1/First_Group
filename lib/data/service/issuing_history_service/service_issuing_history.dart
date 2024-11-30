import 'package:dio/dio.dart';
import 'package:railpaytro/data/model/Affected_toc_Model.dart';
import 'package:railpaytro/data/model/Issuing_History_Model.dart';
import 'package:railpaytro/data/model/revpirDetailMode.dart';
import 'package:retrofit/retrofit.dart';
import '../../../constants/app_config.dart';
import '../../model/car_parking_penalty/car_parking_penalty.dart';
import '../../model/car_parking_penalty/case_reference_model.dart';
import '../../model/car_parking_penalty/reason_for_issue_list_model.dart';
import '../../model/issuing_history_IR.dart';
import '../../model/print_template_ditales.dart';
import '../../model/car_parking_penalty/submit_penaltey_model.dart';

part 'service_issuing_history.g.dart';

@RestApi()
abstract class IssuingHistoryService {
  factory IssuingHistoryService(Dio dio) = _IssuingHistoryService;

  //getIssuingHistory
  @GET(AppConfig.endPoint)
  Future<Issuing_History> getHistoryUser(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  //getIntelligentReport
  @GET(AppConfig.endPoint)
  Future<IssuingHistoryIRModel> getHistoryUserIR(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);
}
