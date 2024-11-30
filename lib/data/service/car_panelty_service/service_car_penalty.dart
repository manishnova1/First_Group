import 'package:dio/dio.dart';
import 'package:railpaytro/data/model/Affected_toc_Model.dart';
import 'package:railpaytro/data/model/revpirDetailMode.dart';
import 'package:retrofit/retrofit.dart';
import '../../../constants/app_config.dart';
import '../../model/car_parking_penalty/car_parking_penalty.dart';
import '../../model/car_parking_penalty/case_reference_model.dart';
import '../../model/car_parking_penalty/reason_for_issue_list_model.dart';
import '../../model/print_template_ditales.dart';
import '../../model/car_parking_penalty/submit_penaltey_model.dart';
import '../../model/ufn/TicketImageDelete.dart';

part 'service_car_penalty.g.dart';

@RestApi()
abstract class CarPenaltyService {
  factory CarPenaltyService(Dio dio) = _CarPenaltyService;

  //getVehicleDetails API
  @GET(AppConfig.endPoint)
  Future<CarParkingPenalty> getVehicleDetails(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<TicketImageDelete> deleteTicketImage(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<ReasonForIssueModel> revpListOffences(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<affectedTOC> revpListAffected(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<CaseReferenceModel> getRevpCaseReferences(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<revpirDetailsModel> getrevpirDetails(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @POST(AppConfig.endPoint)
  Future<SubmitPenalteyModel> submitParkingPenaltyData(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);
}
