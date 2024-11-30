// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaseHistoryModel _$CaseHistoryModelFromJson(Map<String, dynamic> json) =>
    CaseHistoryModel(
      MESSAGE: json['MESSAGE'] as String?,
      STATUS: json['STATUS'] as num?,
      TOCID: json['TOCID'] as String?,
      STCASEDETAILS: (json['STCASEDETAILS'] as List<dynamic>?)
          ?.map((e) => STCASEDETAILSBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      ISREVPENABLED: json['ISREVPENABLED'] as bool?,
      REQUIREDFIELDSERROR: json['REQUIREDFIELDSERROR'],
    );

Map<String, dynamic> _$CaseHistoryModelToJson(CaseHistoryModel instance) =>
    <String, dynamic>{
      'MESSAGE': instance.MESSAGE,
      'STATUS': instance.STATUS,
      'TOCID': instance.TOCID,
      'STCASEDETAILS': instance.STCASEDETAILS,
      'ISREVPENABLED': instance.ISREVPENABLED,
      'REQUIREDFIELDSERROR': instance.REQUIREDFIELDSERROR,
    };

STCASEDETAILSBean _$STCASEDETAILSBeanFromJson(Map<String, dynamic> json) =>
    STCASEDETAILSBean(
      CREATEDDT: json['CREATEDDT'] as String?,
      CASECREATEDTIMEDIFF: json['CASECREATEDTIMEDIFF'] as num?,
      CASEACTION: json['CASEACTION'] as String?,
      STATUSDESC: json['STATUSDESC'] as String?,
      CASEID: json['CASEID'] as String?,
      CASETYPE: json['CASETYPE'] as String?,
      CREATEDTIME: json['CREATEDTIME'] as String?,
      CASENUM: json['CASENUM'] as String?,
    );

Map<String, dynamic> _$STCASEDETAILSBeanToJson(STCASEDETAILSBean instance) =>
    <String, dynamic>{
      'CREATEDDT': instance.CREATEDDT,
      'CASECREATEDTIMEDIFF': instance.CASECREATEDTIMEDIFF,
      'CASEACTION': instance.CASEACTION,
      'STATUSDESC': instance.STATUSDESC,
      'CASEID': instance.CASEID,
      'CASETYPE': instance.CASETYPE,
      'CREATEDTIME': instance.CREATEDTIME,
      'CASENUM': instance.CASENUM,
    };
