// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revp_station_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RevpStationModel _$RevpStationModelFromJson(Map<String, dynamic> json) =>
    RevpStationModel(
      STSESSION: json['STSESSION'],
      ASTATION: (json['ASTATION'] as List<dynamic>?)
          ?.map((e) => AREVPSTATIONBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      STATUS: json['STATUS'] as num?,
      TOCID: json['TOCID'] as String?,
      RECORDCOUNT: json['RECORDCOUNT'] as num?,
      REQUIREDFIELDSERROR: json['REQUIREDFIELDSERROR'],
    );

Map<String, dynamic> _$RevpStationModelToJson(RevpStationModel instance) =>
    <String, dynamic>{
      'STSESSION': instance.STSESSION,
      'ASTATION': instance.ASTATION,
      'STATUS': instance.STATUS,
      'TOCID': instance.TOCID,
      'RECORDCOUNT': instance.RECORDCOUNT,
      'REQUIREDFIELDSERROR': instance.REQUIREDFIELDSERROR,
    };

AREVPSTATIONBean _$AREVPSTATIONBeanFromJson(Map<String, dynamic> json) =>
    AREVPSTATIONBean(
      NLC_CODE: json['NLC_CODE'],
      STATION_NAME: json['STATION_NAME'] as String?,
      ORDER: json['ORDER'],
      CRS_CODE: json['CRS_CODE'] as String?,
      CASETYPES: json['CASETYPES'] as String?,
    );

Map<String, dynamic> _$AREVPSTATIONBeanToJson(AREVPSTATIONBean instance) =>
    <String, dynamic>{
      'NLC_CODE': instance.NLC_CODE,
      'STATION_NAME': instance.STATION_NAME,
      'ORDER': instance.ORDER,
      'CRS_CODE': instance.CRS_CODE,
      'CASETYPES': instance.CASETYPES,
    };
