import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../constants/app_config.dart';
import '../../model/auth/login_model.dart';
import '../../model/station/service_list_mdel.dart';

part 'service_on_train.g.dart';

@RestApi()
abstract class OnTrainService {
  factory OnTrainService(Dio dio) = _OnTrainService;

  //getServiceList
  @GET(AppConfig.endPoint)
  Future<ServiceListMdel> getServiceList(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);
}
