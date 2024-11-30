import 'package:injectable/injectable.dart';
import 'package:railpaytro/constants/app_config.dart';
import 'package:railpaytro/data/service/auth_service/service_station.dart';

import '../../model/car_parking_penalty/location_car_park.dart';
import '../../model/station/revp_station_model.dart';
import '../../model/station/station_list_model.dart';
import '../../network/result.dart';
import 'base_repository.dart';

@lazySingleton
class StationRepo extends BaseRepository {
  //Get Station List
  Future<Result<StationListModel>> getStationList(
          {required String ssessionId,
          required String userID,
          required String macAddress}) async =>
      safeCall(StationService(await dio).getStationList(AppConfig.apiKey, {
        "action": AppConfig.gogGetStationList,
        "ssessionId": ssessionId,
        "userID": userID,
        "macAddress": macAddress,
        "tocid": AppConfig.tocId,
        "station": "",
      }));

  //Get Revp Station List
  Future<Result<RevpStationModel>> getRevpStationList(
          {required String ssessionId,
          required String userID,
          required String macAddress}) async =>
      safeCall(StationService(await dio).getRevpStationList(AppConfig.apiKey, {
        "action": AppConfig.revpGetRevpStationList,
        "ssessionId": ssessionId,
        "userID": userID,
        "macAddress": macAddress,
        "tocid": AppConfig.tocId,
        "station": "",
      }));

  //Get Revp Station List
  Future<Result<Carparklocationmodel>> getParkingLocationList(
          {required String ssessionId,
          required String userID,
          required String macAddress}) async =>
      safeCall(
          StationService(await dio).getParkingLocationList(AppConfig.apiKey, {
        "action": AppConfig.revpListParkingLocations,
        "ssessionId": ssessionId,
        "userID": userID,
        "macAddress": macAddress,
        "tocid": AppConfig.tocId,
        "station": "",
      }));
}
