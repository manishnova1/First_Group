import 'package:injectable/injectable.dart';
import 'package:railpaytro/constants/app_config.dart';
import '../../model/lookup_model.dart';
import '../../model/print_template_ditales.dart';
import '../../network/result.dart';
import '../../service/global_service/global_servie.dart';
import 'base_repository.dart';

@lazySingleton
class OfflineRepo extends BaseRepository {
  Future<Result<dynamic>> syncPostRequest(
          {required String userID,
          required String sessionId,
          required String macAddress}) async =>
      safeCall(GobalService(await dio).getLookUpData(AppConfig.apiKey, {
        "action": AppConfig.revpListLookUPData,
        "tocid": AppConfig.tocId,
        "userID": userID,
        "macAddress": macAddress,
        "ssessionid": sessionId,
      }));

  Future<Result<dynamic>> syncGetRequest(
          {required String userID,
          required String sessionId,
          required String macAddress}) async =>
      safeCall(GobalService(await dio).getLookUpData(AppConfig.apiKey, {
        "action": AppConfig.revpListLookUPData,
        "tocid": AppConfig.tocId,
        "userID": userID,
        "macAddress": macAddress,
        "ssessionid": sessionId,
      }));
}
