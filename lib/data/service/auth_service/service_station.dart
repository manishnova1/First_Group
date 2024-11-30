import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../constants/app_config.dart';
import '../../model/car_parking_penalty/location_car_park.dart';
import '../../model/station/revp_station_model.dart';
import '../../model/station/station_list_model.dart';

part 'service_station.g.dart';

@RestApi()
abstract class StationService {
  factory StationService(Dio dio) = _StationService;

  @GET(AppConfig.endPoint)
  Future<StationListModel> getStationList(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> prem);

  @GET(AppConfig.endPoint)
  Future<RevpStationModel> getRevpStationList(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> prem);

  @GET(AppConfig.endPoint)
  Future<Carparklocationmodel> getParkingLocationList(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> prem);
}
