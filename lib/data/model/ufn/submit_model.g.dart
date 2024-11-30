// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitModel _$SubmitModelFromJson(Map<String, dynamic> json) => SubmitModel(
      MESSAGE: json['MESSAGE'] as String?,
      STATUS: json['STATUS'] as num?,
      TOCID: json['TOCID'] as String?,
      CASEDETAILS: json['CASEDETAILS'] == null
          ? null
          : CASEDETAILSBean.fromJson(
              json['CASEDETAILS'] as Map<String, dynamic>),
      ISREVPENABLED: json['ISREVPENABLED'] as bool?,
      REQUIREDFIELDSERROR: json['REQUIREDFIELDSERROR'],
      REVP_OFFENDERDESCRIPTIONCAPTURE:
          json['REVP_OFFENDERDESCRIPTIONCAPTURE'] as bool?,
    );

Map<String, dynamic> _$SubmitModelToJson(SubmitModel instance) =>
    <String, dynamic>{
      'MESSAGE': instance.MESSAGE,
      'STATUS': instance.STATUS,
      'TOCID': instance.TOCID,
      'CASEDETAILS': instance.CASEDETAILS,
      'ISREVPENABLED': instance.ISREVPENABLED,
      'REQUIREDFIELDSERROR': instance.REQUIREDFIELDSERROR,
      'REVP_OFFENDERDESCRIPTIONCAPTURE':
          instance.REVP_OFFENDERDESCRIPTIONCAPTURE,
    };

CASEDETAILSBean _$CASEDETAILSBeanFromJson(Map<String, dynamic> json) =>
    CASEDETAILSBean(
      JOURNEY_ID: json['JOURNEY_ID'] as String?,
      CASEDT: json['CASEDT'] as String?,
      CASE_TYPE_ID: json['CASE_TYPE_ID'] as String?,
      CASE_STATUS_ID: json['CASE_STATUS_ID'] as String?,
      CASE_VERIFICATION_TYPE: json['CASE_VERIFICATION_TYPE'] as String?,
      CUSTOMERADDRESSMATCH: json['CUSTOMERADDRESSMATCH'] as num?,
      OFFENDER_ID: json['OFFENDER_ID'] as String?,
      ID: json['ID'] as String?,
      NAMEMATCH: json['NAMEMATCH'] as num?,
      CASENUM: json['CASENUM'] as String?,
    );

Map<String, dynamic> _$CASEDETAILSBeanToJson(CASEDETAILSBean instance) =>
    <String, dynamic>{
      'JOURNEY_ID': instance.JOURNEY_ID,
      'CASEDT': instance.CASEDT,
      'CASE_TYPE_ID': instance.CASE_TYPE_ID,
      'CASE_STATUS_ID': instance.CASE_STATUS_ID,
      'CASE_VERIFICATION_TYPE': instance.CASE_VERIFICATION_TYPE,
      'CUSTOMERADDRESSMATCH': instance.CUSTOMERADDRESSMATCH,
      'OFFENDER_ID': instance.OFFENDER_ID,
      'ID': instance.ID,
      'NAMEMATCH': instance.NAMEMATCH,
      'CASENUM': instance.CASENUM,
    };
