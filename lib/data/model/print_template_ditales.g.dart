// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'print_template_ditales.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrintTemplateDitales _$PrintTemplateDitalesFromJson(
        Map<String, dynamic> json) =>
    PrintTemplateDitales(
      STSESSION: json['STSESSION'],
      PRINTTEMPLATE: (json['PRINTTEMPLATE'] as List<dynamic>?)
          ?.map((e) => PRINTTEMPLATEBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      STATUS: json['STATUS'] as num?,
      TOCID: json['TOCID'] as String?,
      RECORDCOUNT: json['RECORDCOUNT'] as num?,
      REQUIREDFIELDSERROR: json['REQUIREDFIELDSERROR'],
    );

Map<String, dynamic> _$PrintTemplateDitalesToJson(
        PrintTemplateDitales instance) =>
    <String, dynamic>{
      'STSESSION': instance.STSESSION,
      'PRINTTEMPLATE': instance.PRINTTEMPLATE,
      'STATUS': instance.STATUS,
      'TOCID': instance.TOCID,
      'RECORDCOUNT': instance.RECORDCOUNT,
      'REQUIREDFIELDSERROR': instance.REQUIREDFIELDSERROR,
    };

PRINTTEMPLATEBean _$PRINTTEMPLATEBeanFromJson(Map<String, dynamic> json) =>
    PRINTTEMPLATEBean(
      ACTIVE: json['ACTIVE'],
      CONTENTS: json['CONTENTS'] as String?,
      TITLE: json['TITLE'] as String?,
      CASETYPE: json['CASETYPE'] as String?,
    );

Map<String, dynamic> _$PRINTTEMPLATEBeanToJson(PRINTTEMPLATEBean instance) =>
    <String, dynamic>{
      'ACTIVE': instance.ACTIVE,
      'CONTENTS': instance.CONTENTS,
      'TITLE': instance.TITLE,
      'CASETYPE': instance.CASETYPE,
    };
