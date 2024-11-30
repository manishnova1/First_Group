import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../constants/app_config.dart';
import '../../model/auth/cms_variables_model.dart';
import '../../model/auth/login_model.dart';
import '../../model/case_detail_model.dart';
import '../../model/case_details_print_model.dart';

part 'service_auth.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio) = _AuthService;

  //Login API
  @POST(AppConfig.endPoint)
  Future<LoginModel> loginUser(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<CmsVariablesModel> getVariablesSettings(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<dynamic> resetPassword(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<dynamic> resetPasswordOtpVerify(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<dynamic> checkUserSessionStatus(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<dynamic> logOutService(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<dynamic> getGestureReasons(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<dynamic> changePassword(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<dynamic> checkCustomerEmail(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<dynamic> addAuditLog(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<dynamic> logoutSummary(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<StCaseDetails> getCases(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<StCaseDetailsPrint> getPrintCases(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);
}
