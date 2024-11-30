import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../constants/app_config.dart';
import '../../model/roaming_staff/case_history_model.dart';
import '../../model/roaming_staff/revp_validateldentity_model.dart';
import '../../model/roaming_staff/save_address_search_model.dart';

part 'roaming_staff_service.g.dart';

@RestApi()
abstract class RoamingStaffService {
  factory RoamingStaffService(Dio dio) = _RoamingStaffService;

  // Issuing history
  @GET(AppConfig.endPoint)
  Future<CaseHistoryModel> getCaseHistoryOfUser(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  // Address / Identity Search
  @GET(AppConfig.endPoint)
  Future<RevpValidateldentityModel> revpValidateIdentity(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<SaveAddressSearchModel> saveAddressSearchData(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<SaveAddressSearchModel> searchAddressId(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<SaveAddressSearchModel> searchFullAddressId(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

//

}
