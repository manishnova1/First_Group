// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_parking_penalty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarParkingPenalty _$CarParkingPenaltyFromJson(Map<String, dynamic> json) =>
    CarParkingPenalty(
      STATUS: json['STATUS'] as num?,
      TOCID: json['TOCID'] as String?,
      ISREVPENABLED: json['ISREVPENABLED'] as bool?,
      REQUIREDFIELDSERROR: json['REQUIREDFIELDSERROR'],
      REVPVEHICLEDATAARRAY: (json['REVPVEHICLEDATAARRAY'] as List<dynamic>?)
          ?.map((e) =>
              REVPVEHICLEDATAARRAYBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CarParkingPenaltyToJson(CarParkingPenalty instance) =>
    <String, dynamic>{
      'STATUS': instance.STATUS,
      'TOCID': instance.TOCID,
      'ISREVPENABLED': instance.ISREVPENABLED,
      'REQUIREDFIELDSERROR': instance.REQUIREDFIELDSERROR,
      'REVPVEHICLEDATAARRAY': instance.REVPVEHICLEDATAARRAY,
    };

REVPVEHICLEDATAARRAYBean _$REVPVEHICLEDATAARRAYBeanFromJson(
        Map<String, dynamic> json) =>
    REVPVEHICLEDATAARRAYBean(
      COLOUR: json['COLOUR'] as String?,
      MODEL: json['MODEL'] as String?,
      MAKE: json['MAKE'] as String?,
    );

Map<String, dynamic> _$REVPVEHICLEDATAARRAYBeanToJson(
        REVPVEHICLEDATAARRAYBean instance) =>
    <String, dynamic>{
      'COLOUR': instance.COLOUR,
      'MODEL': instance.MODEL,
      'MAKE': instance.MAKE,
    };
