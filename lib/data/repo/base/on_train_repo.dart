import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:railpaytro/constants/app_config.dart';
import '../../model/station/service_list_mdel.dart';
import '../../network/result.dart';
import '../../service/on_train_service/service_on_train.dart';
import 'base_repository.dart';

@lazySingleton
class OnTrainRepo extends BaseRepository {
  Future<Result<ServiceListMdel>> getServiceList(
          {required String userID,
          required String ssessionId,
          required String startLocation,
          required String endLocation,
          required String depTime,
          required String macAddress}) async =>
      safeCall(OnTrainService(await dio).getServiceList(AppConfig.apiKey, {
        "action": AppConfig.getServiceList,
        "tocid": AppConfig.tocId,
        "userID": userID,
        "macAddress": macAddress,
        "ssessionId": ssessionId,
        "SSTARTCRS": startLocation,
        "SENDCRS": endLocation,
        "DTDEPARTUREDATE":
            DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
        "DTDEPARTURETIME": depTime,
        "journeyType": '',
      }));
}
