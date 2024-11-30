// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revp_validateldentity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RevpValidateldentityModel _$RevpValidateldentityModelFromJson(
        Map<String, dynamic> json) =>
    RevpValidateldentityModel(
      REVPIDENTITYARRAY: (json['REVPIDENTITYARRAY'] as List<dynamic>?)
          ?.map(
              (e) => REVPIDENTITYARRAYBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      STATUS: json['STATUS'] as num?,
      TOCID: json['TOCID'] as String?,
      RECORDCOUNT: json['RECORDCOUNT'] as num?,
      ISREVPENABLED: json['ISREVPENABLED'] as bool?,
      REQUIREDFIELDSERROR: json['REQUIREDFIELDSERROR'],
    );

Map<String, dynamic> _$RevpValidateldentityModelToJson(
        RevpValidateldentityModel instance) =>
    <String, dynamic>{
      'REVPIDENTITYARRAY': instance.REVPIDENTITYARRAY,
      'STATUS': instance.STATUS,
      'TOCID': instance.TOCID,
      'RECORDCOUNT': instance.RECORDCOUNT,
      'ISREVPENABLED': instance.ISREVPENABLED,
      'REQUIREDFIELDSERROR': instance.REQUIREDFIELDSERROR,
    };

REVPIDENTITYARRAYBean _$REVPIDENTITYARRAYBeanFromJson(
        Map<String, dynamic> json) =>
    REVPIDENTITYARRAYBean(
      LASTNAME: json['LASTNAME'] as String?,
      FIRSTNAME: json['FIRSTNAME'] as String?,
      MIDDLENAME: json['MIDDLENAME'] as String?,
      TITLE: json['TITLE'] as String?,
    );

Map<String, dynamic> _$REVPIDENTITYARRAYBeanToJson(
        REVPIDENTITYARRAYBean instance) =>
    <String, dynamic>{
      'LASTNAME': instance.LASTNAME,
      'FIRSTNAME': instance.FIRSTNAME,
      'MIDDLENAME': instance.MIDDLENAME,
      'TITLE': instance.TITLE,
    };
