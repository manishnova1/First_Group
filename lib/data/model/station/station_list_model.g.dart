// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationListModel _$StationListModelFromJson(Map<String, dynamic> json) =>
    StationListModel(
      STSESSION: json['STSESSION'] == null
          ? null
          : STSESSIONBean.fromJson(json['STSESSION'] as Map<String, dynamic>),
      ASTATION: (json['ASTATION'] as List<dynamic>?)
          ?.map((e) => ASTATIONBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      STATUS: json['STATUS'] as num?,
      TOCID: json['TOCID'] as String?,
      RECORDCOUNT: json['RECORDCOUNT'] as num?,
    );

Map<String, dynamic> _$StationListModelToJson(StationListModel instance) =>
    <String, dynamic>{
      'STSESSION': instance.STSESSION,
      'ASTATION': instance.ASTATION,
      'STATUS': instance.STATUS,
      'TOCID': instance.TOCID,
      'RECORDCOUNT': instance.RECORDCOUNT,
    };

ASTATIONBean _$ASTATIONBeanFromJson(Map<String, dynamic> json) => ASTATIONBean(
      code: json['code'] as String?,
      value: json['value'] as String?,
      toc: json['toc'] as String?,
    );

Map<String, dynamic> _$ASTATIONBeanToJson(ASTATIONBean instance) =>
    <String, dynamic>{
      'code': instance.code,
      'value': instance.value,
      'toc': instance.toc,
    };

STSESSIONBean _$STSESSIONBeanFromJson(Map<String, dynamic> json) =>
    STSESSIONBean(
      SSESSIONID: json['SSESSIONID'] as String?,
      SSESSIONTYPE: json['SSESSIONTYPE'] as String?,
    );

Map<String, dynamic> _$STSESSIONBeanToJson(STSESSIONBean instance) =>
    <String, dynamic>{
      'SSESSIONID': instance.SSESSIONID,
      'SSESSIONTYPE': instance.SSESSIONTYPE,
    };
