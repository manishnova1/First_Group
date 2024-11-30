import 'package:json_annotation/json_annotation.dart';

part 'car_parking_penalty.g.dart';

@JsonSerializable()
class CarParkingPenalty {
  num? STATUS;
  String? TOCID;
  bool? ISREVPENABLED;
  dynamic REQUIREDFIELDSERROR;
  List<REVPVEHICLEDATAARRAYBean>? REVPVEHICLEDATAARRAY;

  CarParkingPenalty(
      {this.STATUS,
      this.TOCID,
      this.ISREVPENABLED,
      this.REQUIREDFIELDSERROR,
      this.REVPVEHICLEDATAARRAY});

  factory CarParkingPenalty.fromJson(Map<String, dynamic> json) =>
      _$CarParkingPenaltyFromJson(json);

  Map<String, dynamic> toJson() => _$CarParkingPenaltyToJson(this);
}

@JsonSerializable()
class REVPVEHICLEDATAARRAYBean {
  String? COLOUR;
  String? MODEL;
  String? MAKE;

  REVPVEHICLEDATAARRAYBean({this.COLOUR, this.MODEL, this.MAKE});

  factory REVPVEHICLEDATAARRAYBean.fromJson(Map<String, dynamic> json) =>
      _$REVPVEHICLEDATAARRAYBeanFromJson(json);

  Map<String, dynamic> toJson() => _$REVPVEHICLEDATAARRAYBeanToJson(this);
}
