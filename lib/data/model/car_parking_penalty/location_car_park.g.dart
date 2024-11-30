// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_car_park.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Carparklocationmodel _$CarparklocationmodelFromJson(
        Map<String, dynamic> json) =>
    Carparklocationmodel(
      STATUS: json['STATUS'] as num?,
      TOCID: json['TOCID'] as String?,
      RECORDCOUNT: json['RECORDCOUNT'] as num?,
      ISREVPENABLED: json['ISREVPENABLED'] as bool?,
      REQUIREDFIELDSERROR: json['REQUIREDFIELDSERROR'],
      REVPPARKINGLOCATIONSARRAY: (json['REVPPARKINGLOCATIONSARRAY']
              as List<dynamic>?)
          ?.map((e) =>
              REVPPARKINGLOCATIONSARRAYBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CarparklocationmodelToJson(
        Carparklocationmodel instance) =>
    <String, dynamic>{
      'STATUS': instance.STATUS,
      'TOCID': instance.TOCID,
      'RECORDCOUNT': instance.RECORDCOUNT,
      'ISREVPENABLED': instance.ISREVPENABLED,
      'REQUIREDFIELDSERROR': instance.REQUIREDFIELDSERROR,
      'REVPPARKINGLOCATIONSARRAY': instance.REVPPARKINGLOCATIONSARRAY,
    };

REVPPARKINGLOCATIONSARRAYBean _$REVPPARKINGLOCATIONSARRAYBeanFromJson(
        Map<String, dynamic> json) =>
    REVPPARKINGLOCATIONSARRAYBean(
      carpark_location_id: json['carpark_location_id'] as String?,
      location_name: json['location_name'] as String?,
      station_id: json['station_id'] as String?,
      station_name: json['station_name'] as String?,
      order: json['order'] as num?,
    );

Map<String, dynamic> _$REVPPARKINGLOCATIONSARRAYBeanToJson(
        REVPPARKINGLOCATIONSARRAYBean instance) =>
    <String, dynamic>{
      'carpark_location_id': instance.carpark_location_id,
      'location_name': instance.location_name,
      'station_id': instance.station_id,
      'station_name': instance.station_name,
      'order': instance.order,
    };
