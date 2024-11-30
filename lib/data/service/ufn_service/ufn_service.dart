import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../constants/app_config.dart';
import '../../model/ufn/AddressListModel.dart';
import '../../model/ufn/FullAddressListModel.dart';
import '../../model/ufn/RevpCardType.dart';
import '../../model/ufn/TicketImageDelete.dart';
import '../../model/ufn/ValidateIdentityModel.dart';
import '../../model/ufn/revp_card_type.dart';
import '../../model/ufn/submit_model.dart';

part 'ufn_service.g.dart';

@RestApi()
abstract class UfnService {
  factory UfnService(Dio dio) = _UfnService;

  // Issuing history
  @GET(AppConfig.endPoint)
  Future<dynamic> getAddressList(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<dynamic> getFullAddressList(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  //card type
  @GET(AppConfig.endPoint)
  Future<RevpCardType> getRevpCardType(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<ValidateIdentityModel> validateIdentity(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @POST(AppConfig.endPoint)
  Future<dynamic> uploadRevpTicketImage(
      @Header('APIKey') String hValue, @Body() Map<String, dynamic> body);

  @GET(AppConfig.endPoint)
  Future<TicketImageDelete> deleteTicketImage(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);
}
