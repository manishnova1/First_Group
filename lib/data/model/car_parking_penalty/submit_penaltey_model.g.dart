// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_penaltey_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitPenalteyModel _$SubmitPenalteyModelFromJson(Map<String, dynamic> json) =>
    SubmitPenalteyModel(
      MESSAGE: json['MESSAGE'] as String?,
      STATUS: json['STATUS'] as num?,
      TOCID: json['TOCID'] as String?,
      CASEDETAILS: json['CASEDETAILS'] == null
          ? null
          : CASEDETAILSBean.fromJson(
              json['CASEDETAILS'] as Map<String, dynamic>),
      ISREVPENABLED: json['ISREVPENABLED'] as bool?,
      REQUIREDFIELDSERROR: json['REQUIREDFIELDSERROR'],
    );

Map<String, dynamic> _$SubmitPenalteyModelToJson(
        SubmitPenalteyModel instance) =>
    <String, dynamic>{
      'MESSAGE': instance.MESSAGE,
      'STATUS': instance.STATUS,
      'TOCID': instance.TOCID,
      'CASEDETAILS': instance.CASEDETAILS,
      'ISREVPENABLED': instance.ISREVPENABLED,
      'REQUIREDFIELDSERROR': instance.REQUIREDFIELDSERROR,
    };

CASEDETAILSBean _$CASEDETAILSBeanFromJson(Map<String, dynamic> json) =>
    CASEDETAILSBean(
      CASEDT: json['CASEDT'] as String?,
      CASE_TYPE_ID: json['CASE_TYPE_ID'] as String?,
      CASE_STATUS_ID: json['CASE_STATUS_ID'] as String?,
      COLOUR: json['COLOUR'] as String?,
      MODEL: json['MODEL'] as String?,
      REGISTRATION_NO: json['REGISTRATION_NO'] as String?,
      LOCATION: json['LOCATION'] as String?,
      CASE_VERIFICATION_TYPE: json['CASE_VERIFICATION_TYPE'] as String?,
      PHOTOS: json['PHOTOS'] as String?,
      MAKE: json['MAKE'] as String?,
      OFFENCES: json['OFFENCES'] as String?,
      VEHICLE_ID: json['VEHICLE_ID'] as String?,
      CUSTOMERADDRESSMATCH: json['CUSTOMERADDRESSMATCH'] as num?,
      OFFENCE_DT: json['OFFENCE_DT'] as String?,
      OFFENCETIME: json['OFFENCETIME'] as String?,
      ID: json['ID'] as String?,
      CASENUM: json['CASENUM'] as String?,
      NAMEMATCH: json['NAMEMATCH'] as num?,
    );

Map<String, dynamic> _$CASEDETAILSBeanToJson(CASEDETAILSBean instance) =>
    <String, dynamic>{
      'CASEDT': instance.CASEDT,
      'CASE_TYPE_ID': instance.CASE_TYPE_ID,
      'CASE_STATUS_ID': instance.CASE_STATUS_ID,
      'COLOUR': instance.COLOUR,
      'MODEL': instance.MODEL,
      'REGISTRATION_NO': instance.REGISTRATION_NO,
      'LOCATION': instance.LOCATION,
      'CASE_VERIFICATION_TYPE': instance.CASE_VERIFICATION_TYPE,
      'PHOTOS': instance.PHOTOS,
      'MAKE': instance.MAKE,
      'OFFENCES': instance.OFFENCES,
      'VEHICLE_ID': instance.VEHICLE_ID,
      'CUSTOMERADDRESSMATCH': instance.CUSTOMERADDRESSMATCH,
      'OFFENCE_DT': instance.OFFENCE_DT,
      'OFFENCETIME': instance.OFFENCETIME,
      'ID': instance.ID,
      'CASENUM': instance.CASENUM,
      'NAMEMATCH': instance.NAMEMATCH,
    };
