import 'package:injectable/injectable.dart';
import 'package:railpaytro/constants/app_config.dart';

import '../model/auth/cms_variables_model.dart';
import '../model/auth/login_model.dart';
import '../model/case_detail_model.dart';
import '../model/case_details_print_model.dart';
import '../network/result.dart';
import '../service/auth_service/service_auth.dart';
import 'base/base_repository.dart';

@lazySingleton
class AuthRepo extends BaseRepository {
  Future<Result<LoginModel>> loginUser(
          {required String userName,
          required String password,
          required String azureToken,
          required String type,
          required String macAddress}) async =>
      safeCall(AuthService(await dio).loginUser(AppConfig.apiKey, {
        "action": AppConfig.gogLogin,
        "tocid": AppConfig.tocId,
        "username": userName,
        "password": password,
        "MACAddress": macAddress,
        "azureToken": azureToken,
        "type": type,
        "sSessionID": "test",
      }));

  Future<Result<CmsVariablesModel>> getVariablesSettings() async =>
      safeCall(AuthService(await dio).getVariablesSettings(AppConfig.apiKey, {
        "action": AppConfig.gogGetCMSVariablesData,
        "tocid": AppConfig.tocId,
      }));

  //logout User session
  Future<Result<dynamic>> logOutService(
          {required String sessionId, required String macAddress}) async =>
      safeCall(AuthService(await dio).logOutService(AppConfig.apiKey, {
        "action": AppConfig.gogLogOut,
        "tocid": AppConfig.tocId,
        "ssessionId": sessionId,
        "MACAddress": macAddress,
      }));

  //ResetPassword
  Future<Result<dynamic>> resetPassword(
          {required String email, required String macAddress}) async =>
      safeCall(AuthService(await dio).resetPassword(AppConfig.apiKey, {
        'tocid': AppConfig.tocId,
        'action': AppConfig.resetPassCheckEmail,
        'email': email,
        'MACAddress': macAddress,
      }));

  //ResetPassword
  Future<Result<dynamic>> resetPasswordVerifyOtp(
          {required String email, required String otp}) async =>
      safeCall(AuthService(await dio).resetPasswordOtpVerify(AppConfig.apiKey, {
        'tocid': AppConfig.tocId,
        'action': AppConfig.resetPassVerifyOtp,
        'email': email,
        'otp': otp,
      }));

  //ResetPassword
  Future<Result<dynamic>> checkUserSessionStatus(
          {required String ssessionId,
          required String userID,
          required String macAddress}) async =>
      safeCall(AuthService(await dio).checkUserSessionStatus(AppConfig.apiKey, {
        'tocid': AppConfig.tocId,
        'action': AppConfig.gogCheckUserSessionStatus,
        'ssessionId': ssessionId,
        'userID': userID,
        'macAddress': macAddress,
      }));

  //getGestureReasons
  Future<Result<dynamic>> getGestureReasons(
          {required String ssessionId,
          required String userID,
          required String reasonType,
          required String macAddress}) async =>
      safeCall(AuthService(await dio).getGestureReasons(AppConfig.apiKey, {
        'tocid': AppConfig.tocId,
        'action': AppConfig.getGestureReasons,
        'ssessionId': ssessionId,
        'userID': userID,
        'macAddress': macAddress,
        'reasonType': reasonType,
      }));

  //changePassword
  Future<Result<dynamic>> changePassword(
          {required String userID, required String password}) async =>
      safeCall(AuthService(await dio).changePassword(AppConfig.apiKey, {
        'tocid': AppConfig.tocId,
        'action': AppConfig.changePassword,
        'password': password,
        'cpassword': password,
        'UserID': userID,
      }));

  //checkCustomerEmail
  Future<Result<dynamic>> checkCustomerEmail(
          {required String email, required String macAddress}) async =>
      safeCall(AuthService(await dio).checkCustomerEmail(AppConfig.apiKey, {
        'tocid': AppConfig.tocId,
        'action': AppConfig.checkCustomerEmail,
        'email': email,
        'MACAddress': macAddress,
      }));

  //addAuditLog
  Future<Result<dynamic>> addAuditLog(
          {required String userID,
          required String sSessionID,
          required String description}) async =>
      safeCall(AuthService(await dio).addAuditLog(AppConfig.apiKey, {
        'TocID': AppConfig.tocId,
        'action': AppConfig.addAuditLog,
        'UserID': userID,
        'sSessionID': sSessionID,
        'UserAddedDT': DateTime.now().toString(),
        'Description': description,
        'Latitude': '',
        'Longitude': '',
      }));

  Future<Result<dynamic>> logoutSummary(
          {required String userID,
          required String email,
          required String macAddress,
          required String ssessionId,
          required String action,
          required String tocid}) async =>
      safeCall(AuthService(await dio).logoutSummary(AppConfig.apiKey, {
        'tocid': AppConfig.tocId,
        'action': AppConfig.goggetGestureDataBySessionID,
        'MACAddress': macAddress,
        'UserID': userID,
        'ssessionId': ssessionId,
      }));

  Future<Result<StCaseDetails>> getCases(
          {required int reload,
          required String ssessionId,
          required String userID}) async =>
      safeCall(AuthService(await dio).getCases(AppConfig.apiKey, {
        'tocid': AppConfig.tocId,
        'action': AppConfig.zeroFairEnable,
        'reload': reload,
        'userID': userID,
        'ssessionId': ssessionId,
      }));

  Future<Result<StCaseDetailsPrint>> getPrintCases(
          {required int reload,
          required String ssessionId,
          required String userID}) async =>
      safeCall(AuthService(await dio).getPrintCases(AppConfig.apiKey, {
        'tocid': AppConfig.tocId,
        'action': AppConfig.revpAppPrintControl,
        'reload': reload,
        'userID': userID,
        'ssessionId': ssessionId,
      }));
}
