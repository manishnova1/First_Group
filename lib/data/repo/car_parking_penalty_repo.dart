import 'package:injectable/injectable.dart';
import 'package:railpaytro/constants/app_config.dart';
import 'package:railpaytro/data/model/Affected_toc_Model.dart';
import 'package:railpaytro/data/model/revpirDetailMode.dart';

import '../model/car_parking_penalty/car_parking_penalty.dart';
import '../model/car_parking_penalty/case_reference_model.dart';
import '../model/car_parking_penalty/reason_for_issue_list_model.dart';
import '../model/print_template_ditales.dart';
import '../model/car_parking_penalty/submit_penaltey_model.dart';
import '../model/ufn/TicketImageDelete.dart';
import '../network/result.dart';
import '../service/car_panelty_service/service_car_penalty.dart';
import 'base/base_repository.dart';

@lazySingleton
class CarParkingPenaltyRepo extends BaseRepository {
  Future<Result<CarParkingPenalty>> getVehicleDetails(
          {required String regNo,
          required String uniqeId,
          required String ssessionId,
          required String username,
          required String userID}) async =>
      safeCall(CarPenaltyService(await dioConnectionTimeOut)
          .getVehicleDetails(AppConfig.apiKey, {
        "action": AppConfig.getVehicleDetails,
        "tocid": AppConfig.tocId,
        "macAddress": uniqeId,
        "ssessionId": ssessionId,
        "username": username,
        "userID": userID,
        "reg_no": regNo,
      }));

  Future<TicketImageDelete> deleteTicketImage({
    required String macAddress,
    required String ssessionId,
    required String userID,
    required String imagepath,
  }) async =>
      CarPenaltyService(await dio).deleteTicketImage(AppConfig.apiKey, {
        "action": AppConfig.gogDeleteTicketImage,
        "tocid": AppConfig.tocId,
        "macAddress": macAddress,
        "ssessionId": ssessionId,
        "userID": userID,
        "imagepath": imagepath,
      });

  //revpListOffences
  Future<Result<ReasonForIssueModel>> revpListOffences(
          {required String sessionId,
          required String macAddress,
          required String userID}) async =>
      safeCall(CarPenaltyService(await dio).revpListOffences(AppConfig.apiKey, {
        "action": AppConfig.listOffences,
        "tocid": AppConfig.tocId,
        "ssessionId": sessionId,
        "MACAddress": macAddress,
        "userID": userID,
      }));

  //revpListAffectedTOC
  Future<Result<affectedTOC>> revpListAffectedTOC(
          {required String sessionId,
          required String macAddress,
          required String userID}) async =>
      safeCall(CarPenaltyService(await dio).revpListAffected(AppConfig.apiKey, {
        "action": AppConfig.listofAffected,
        "revp_toc_id": AppConfig.tocId,
        "ssessionId": sessionId,
        "macAddress": macAddress,
        "userID": userID,
        "tocid": AppConfig.tocId,
        "active": "1"
      }));

  //getRevpCaseReferences
  Future<Result<CaseReferenceModel>> getRevpCaseReferences(
          {required String sessionId,
          required String macAddress,
          required String userID,
          required String username}) async =>
      safeCall(
          CarPenaltyService(await dio).getRevpCaseReferences(AppConfig.apiKey, {
        "action": AppConfig.getRevpCaseReferences,
        "tocid": AppConfig.tocId,
        "ssessionId": sessionId,
        "MACAddress": macAddress,
        "userID": userID,
        "username": username,
      }));

  //getRevpDetailsArray
  Future<Result<revpirDetailsModel>> getRevpirDetails(
          {required String sessionId,
          required String macAddress,
          required String userID,
          required String username}) async =>
      safeCall(CarPenaltyService(await dio).getrevpirDetails(AppConfig.apiKey, {
        "action": AppConfig.listofDetails,
        "tocid": AppConfig.tocId,
        "ssessionId": sessionId,
        "MACAddress": macAddress,
        "userID": userID,
        "username": username,
      }));

  //revpListOffences
  Future<Result<SubmitPenalteyModel>> submitParkingPenaltyData(
          {required Map<String, dynamic> requestData}) async =>
      safeCall(CarPenaltyService(await dioConnectionTimeOut)
          .submitParkingPenaltyData(AppConfig.apiKey, requestData));

//
}
