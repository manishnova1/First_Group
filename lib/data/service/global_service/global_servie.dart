import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../constants/app_config.dart';
import '../../model/lookup_model.dart';
import '../../model/print_template_ditales.dart';

part 'global_servie.g.dart';

@RestApi()
abstract class GobalService {
  factory GobalService(Dio dio) = _GobalService;

  //getServiceList
  @GET(AppConfig.endPoint)
  Future<LookupModel> getLookUpData(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);

  @GET(AppConfig.endPoint)
  Future<PrintTemplateDitales> getPrintTemplateDataList(
      @Header('APIKey') String hValue, @Queries() Map<String, dynamic> query);
}
