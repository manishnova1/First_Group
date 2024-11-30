import 'package:json_annotation/json_annotation.dart';

part 'location_car_park.g.dart';

@JsonSerializable()
class Carparklocationmodel {
  num? STATUS;
  String? TOCID;
  num? RECORDCOUNT;
  bool? ISREVPENABLED;
  dynamic REQUIREDFIELDSERROR;
  List<REVPPARKINGLOCATIONSARRAYBean>? REVPPARKINGLOCATIONSARRAY;

  Carparklocationmodel(
      {this.STATUS,
      this.TOCID,
      this.RECORDCOUNT,
      this.ISREVPENABLED,
      this.REQUIREDFIELDSERROR,
      this.REVPPARKINGLOCATIONSARRAY});

  factory Carparklocationmodel.fromJson(Map<String, dynamic> json) =>
      _$CarparklocationmodelFromJson(json);

  Map<String, dynamic> toJson() => _$CarparklocationmodelToJson(this);
}

//
@JsonSerializable()
class REVPPARKINGLOCATIONSARRAYBean {
  String? carpark_location_id;
  String? location_name;
  String? station_id;
  String? station_name;
  num? order;

  REVPPARKINGLOCATIONSARRAYBean(
      {this.carpark_location_id,
      this.location_name,
      this.station_id,
      this.station_name,
      this.order});

  factory REVPPARKINGLOCATIONSARRAYBean.fromJson(Map<String, dynamic> json) =>
      _$REVPPARKINGLOCATIONSARRAYBeanFromJson(json);

  Map<String, dynamic> toJson() => _$REVPPARKINGLOCATIONSARRAYBeanToJson(this);
}
