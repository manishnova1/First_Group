// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_reference_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaseReferenceModel _$CaseReferenceModelFromJson(Map<String, dynamic> json) =>
    CaseReferenceModel(
      STSESSION: json['STSESSION'] == null
          ? null
          : STSESSIONBean.fromJson(json['STSESSION'] as Map<String, dynamic>),
      STATUS: json['STATUS'] as num?,
      TOCID: json['TOCID'] as String?,
      RECORDCOUNT: json['RECORDCOUNT'] as num?,
      REQUIREDFIELDSERROR: json['REQUIREDFIELDSERROR'],
      REVPREFERENCESARRAY: (json['REVPREFERENCESARRAY'] as List<dynamic>?)
          ?.map((e) =>
              REVPREFERENCESARRAYBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CaseReferenceModelToJson(CaseReferenceModel instance) =>
    <String, dynamic>{
      'STSESSION': instance.STSESSION,
      'STATUS': instance.STATUS,
      'TOCID': instance.TOCID,
      'RECORDCOUNT': instance.RECORDCOUNT,
      'REQUIREDFIELDSERROR': instance.REQUIREDFIELDSERROR,
      'REVPREFERENCESARRAY': instance.REVPREFERENCESARRAY,
    };

REVPREFERENCESARRAYBean _$REVPREFERENCESARRAYBeanFromJson(
        Map<String, dynamic> json) =>
    REVPREFERENCESARRAYBean(
      ISUSED: json['ISUSED'] as num?,
      ISLOCKED: json['ISLOCKED'] as num?,
      CASE_REFERENCE_NO: json['CASE_REFERENCE_NO'] as String?,
    );

Map<String, dynamic> _$REVPREFERENCESARRAYBeanToJson(
        REVPREFERENCESARRAYBean instance) =>
    <String, dynamic>{
      'ISUSED': instance.ISUSED,
      'ISLOCKED': instance.ISLOCKED,
      'CASE_REFERENCE_NO': instance.CASE_REFERENCE_NO,
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
