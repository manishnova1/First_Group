import 'package:injectable/injectable.dart';
import 'package:railpaytro/constants/app_config.dart';

import '../model/ufn/AddressListModel.dart';
import '../model/ufn/FullAddressListModel.dart';
import '../model/ufn/RevpCardType.dart';
import '../model/ufn/TicketImageDelete.dart';
import '../model/ufn/ValidateIdentityModel.dart';
import '../model/ufn/revp_card_type.dart';
import '../model/ufn/submit_model.dart';
import '../network/result.dart';
import '../service/ufn_service/ufn_service.dart';
import 'base/base_repository.dart';

@lazySingleton
class UfnRepo extends BaseRepository {
  Future<Result<dynamic>> getAddressList(
          {required String userId,
          required String postCode,
          required String container,
          required String sessionId,
          required String macAddress}) async =>
      safeCall(UfnService(await dioConnectionTimeOut)
          .getAddressList(AppConfig.apiKey, {
        "action": AppConfig.searchAddressId,
        "tocid": AppConfig.tocId,
        "macAddress": macAddress,
        "ssessionId": sessionId,
        "userID": userId,
        "container": container,
        "post_code": postCode,
      }));

  Future<Result<dynamic>> getFullAddressList(
          {required String userId,
          required String id,
          required String sessionId,
          required String macAddress}) async =>
      safeCall(UfnService(await dio).getFullAddressList(AppConfig.apiKey, {
        "action": AppConfig.searchFullAddressId,
        "tocid": AppConfig.tocId,
        "id": id,
        "userID": userId,
        "ssessionId": sessionId,
        "macAddress": macAddress,
      }));

  //card type
  Future<Result<RevpCardType>> getRevpCardType(
          {required String userId,
          required String sessionId,
          required String macAddress}) async =>
      safeCall(UfnService(await dio).getRevpCardType(AppConfig.apiKey, {
        "action": AppConfig.revpRailcardType,
        "tocid": AppConfig.tocId,
        "userID": userId,
        "ssessionId": sessionId,
        "macAddress": macAddress,
      }));

  Future<Result<ValidateIdentityModel>> validateIdentity(
          {required String userId,
          required String sessionId,
          required String postCode,
          required String address_1,
          required String locality,
          required String address_2,
          required String country,
          required String buildingname,
          required String buildingnumber,
          required String street,
          required String province,
          required String macAddress}) async =>
      safeCall(UfnService(await dio).validateIdentity(AppConfig.apiKey, {
        "action": AppConfig.revpValidateIdentity,
        "tocid": AppConfig.tocId,
        "macAddress": macAddress,
        "ssessionId": sessionId,
        "userID": userId,
        "post_code": postCode,
        "address_1": address_1,
        "locality": locality,
        "address_2": address_2,
        "country": country,
        "buildingname": buildingname,
        "buildingnumber": buildingnumber,
        "street": street,
        "province": province,
      }));

  Future<TicketImageDelete> deleteTicketImage({
    required String macAddress,
    required String ssessionId,
    required String userID,
    required String imagepath,
  }) async =>
      UfnService(await dio).deleteTicketImage(AppConfig.apiKey, {
        "action": AppConfig.gogDeleteTicketImage,
        "tocid": AppConfig.tocId,
        "macAddress": macAddress,
        "ssessionId": ssessionId,
        "userID": userID,
        "imagepath": imagepath,
      });

  Future<Result<dynamic>> uploadRevpTicketImage({
    required String macAddress,
    required String ssessionId,
    required String userID,
    required String ticketImage,
    required String imageFolderName,
  }) async =>
      safeCall(UfnService(await dio).uploadRevpTicketImage(AppConfig.apiKey, {
        "action": AppConfig.gogGetCMSVariablesData,
        "tocid": AppConfig.tocId,
        "macAddress": macAddress,
        "ssessionId": ssessionId,
        "userID": userID,
        "ticketImage": ticketImage,
        "imageFolderName": imageFolderName,
      }));

// Future<Result<SubmitModel>> submitUnpaidFareNotice(Map<String,dynamic> map) async =>
//     safeCall(UfnService(await dio).submitUnpaidFareNotice(AppConfig.apiKey,map));

}
