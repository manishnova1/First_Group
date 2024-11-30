import 'package:json_annotation/json_annotation.dart';

part 'revp_station_model.g.dart';

@JsonSerializable()
class RevpStationModel {
  dynamic STSESSION;
  List<AREVPSTATIONBean>? ASTATION;
  num? STATUS;
  String? TOCID;
  num? RECORDCOUNT;
  dynamic REQUIREDFIELDSERROR;

  RevpStationModel(
      {this.STSESSION,
      this.ASTATION,
      this.STATUS,
      this.TOCID,
      this.RECORDCOUNT,
      this.REQUIREDFIELDSERROR});

  factory RevpStationModel.fromJson(Map<String, dynamic> json) =>
      _$RevpStationModelFromJson(json);

  Map<String, dynamic> toJson() => _$RevpStationModelToJson(this);
}

@JsonSerializable()
class AREVPSTATIONBean {
  dynamic NLC_CODE;
  String? STATION_NAME;
  dynamic ORDER;
  String? CRS_CODE;
  String? CASETYPES;

  AREVPSTATIONBean(
      {this.NLC_CODE,
      this.STATION_NAME,
      this.ORDER,
      this.CRS_CODE,
      this.CASETYPES});

  factory AREVPSTATIONBean.fromJson(Map<String, dynamic> json) =>
      _$AREVPSTATIONBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AREVPSTATIONBeanToJson(this);
}
