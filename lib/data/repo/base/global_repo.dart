import 'package:injectable/injectable.dart';
import 'package:railpaytro/constants/app_config.dart';
import '../../model/lookup_model.dart';
import '../../model/print_template_ditales.dart';
import '../../network/result.dart';
import '../../service/global_service/global_servie.dart';
import 'base_repository.dart';

@lazySingleton
class GlobalRepo extends BaseRepository {
  Future<Result<LookupModel>> getLookUpData(
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

  Future<Result<PrintTemplateDitales>> getPrintTemplateDataList({
    required String userID,
    required String macAddress,
    required String ssessionId,
  }) async =>
      safeCall(
          GobalService(await dio).getPrintTemplateDataList(AppConfig.apiKey, {
        "action": AppConfig.getPrintTemplateDataList,
        "tocid": AppConfig.tocId,
        "macAddress": macAddress,
        "ssessionId": ssessionId,
        "userID": userID,
      }));
}
