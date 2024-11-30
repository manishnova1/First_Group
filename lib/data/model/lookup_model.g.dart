// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lookup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LookupModel _$LookupModelFromJson(Map<String, dynamic> json) => LookupModel(
      REASON_FOR_ISSUE_FOR_PCN: (json['REASON_FOR_ISSUE_FOR_PCN']
              as List<dynamic>?)
          ?.map((e) =>
              REASON_FOR_ISSUE_FOR_PCNBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      REASON_FOR_ISSUE_FOR_MG11: (json['REASON_FOR_ISSUE_FOR_MG11']
              as List<dynamic>?)
          ?.map((e) =>
              REASON_FOR_ISSUE_FOR_MG11Bean.fromJson(e as Map<String, dynamic>))
          .toList(),
      REVPCLASSESARRAY: json['REVPCLASSESARRAY'],
      PERSON_TITLE: (json['PERSON_TITLE'] as List<dynamic>?)
          ?.map((e) => PERSON_TITLEBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      PERSON_FACIAL_HAIR_TYPE: (json['PERSON_FACIAL_HAIR_TYPE']
              as List<dynamic>?)
          ?.map((e) =>
              PERSON_FACIAL_HAIR_TYPEBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      CASE_ISSUE_CANCEL_REASON: (json['CASE_ISSUE_CANCEL_REASON']
              as List<dynamic>?)
          ?.map((e) =>
              CASE_ISSUE_CANCEL_REASONBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      PERSON_BUILD: (json['PERSON_BUILD'] as List<dynamic>?)
          ?.map((e) => PERSON_BUILDBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      CASE_REASON_FOR_ISSUE: (json['CASE_REASON_FOR_ISSUE'] as List<dynamic>?)
          ?.map((e) =>
              CASE_REASON_FOR_ISSUEBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      PERSON_HAIR_COLOUR: (json['PERSON_HAIR_COLOUR'] as List<dynamic>?)
          ?.map(
              (e) => PERSON_HAIR_COLOURBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      CASE_VERIFICATION_TYPE: (json['CASE_VERIFICATION_TYPE'] as List<dynamic>?)
          ?.map((e) =>
              CASE_VERIFICATION_TYPEBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      STATUS: json['STATUS'] as num?,
      TOCID: json['TOCID'] as String?,
      OCCUPATION: (json['OCCUPATION'] as List<dynamic>?)
          ?.map((e) => OCCUPATIONBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      PERSON_EYE_COLOUR: (json['PERSON_EYE_COLOUR'] as List<dynamic>?)
          ?.map(
              (e) => PERSON_EYE_COLOURBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      PERSON_GLASSES: (json['PERSON_GLASSES'] as List<dynamic>?)
          ?.map((e) => PERSON_GLASSESBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      PERSON_ETHNICITY: (json['PERSON_ETHNICITY'] as List<dynamic>?)
          ?.map((e) => PERSON_ETHNICITYBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      ISREVPENABLED: json['ISREVPENABLED'] as bool?,
      REQUIREDFIELDSERROR: json['REQUIREDFIELDSERROR'],
      CASE_CLASSES: (json['CASE_CLASSES'] as List<dynamic>?)
          ?.map((e) => CASE_CLASSESBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LookupModelToJson(LookupModel instance) =>
    <String, dynamic>{
      'REASON_FOR_ISSUE_FOR_PCN': instance.REASON_FOR_ISSUE_FOR_PCN,
      'REASON_FOR_ISSUE_FOR_MG11': instance.REASON_FOR_ISSUE_FOR_MG11,
      'REVPCLASSESARRAY': instance.REVPCLASSESARRAY,
      'PERSON_TITLE': instance.PERSON_TITLE,
      'PERSON_FACIAL_HAIR_TYPE': instance.PERSON_FACIAL_HAIR_TYPE,
      'CASE_ISSUE_CANCEL_REASON': instance.CASE_ISSUE_CANCEL_REASON,
      'PERSON_BUILD': instance.PERSON_BUILD,
      'CASE_REASON_FOR_ISSUE': instance.CASE_REASON_FOR_ISSUE,
      'PERSON_HAIR_COLOUR': instance.PERSON_HAIR_COLOUR,
      'CASE_VERIFICATION_TYPE': instance.CASE_VERIFICATION_TYPE,
      'STATUS': instance.STATUS,
      'TOCID': instance.TOCID,
      'OCCUPATION': instance.OCCUPATION,
      'PERSON_EYE_COLOUR': instance.PERSON_EYE_COLOUR,
      'PERSON_GLASSES': instance.PERSON_GLASSES,
      'PERSON_ETHNICITY': instance.PERSON_ETHNICITY,
      'ISREVPENABLED': instance.ISREVPENABLED,
      'REQUIREDFIELDSERROR': instance.REQUIREDFIELDSERROR,
      'CASE_CLASSES': instance.CASE_CLASSES,
    };

CASE_CLASSESBean _$CASE_CLASSESBeanFromJson(Map<String, dynamic> json) =>
    CASE_CLASSESBean(
      lookup_type_id: json['lookup_type_id'] as String?,
      lookup_data_value: json['lookup_data_value'] as String?,
      lookup_data_id: json['lookup_data_id'] as String?,
      OrderBy: json['OrderBy'],
      name: json['name'] as String?,
      active: json['active'] as num?,
    );

Map<String, dynamic> _$CASE_CLASSESBeanToJson(CASE_CLASSESBean instance) =>
    <String, dynamic>{
      'lookup_type_id': instance.lookup_type_id,
      'lookup_data_value': instance.lookup_data_value,
      'lookup_data_id': instance.lookup_data_id,
      'OrderBy': instance.OrderBy,
      'name': instance.name,
      'active': instance.active,
    };

PERSON_GLASSESBean _$PERSON_GLASSESBeanFromJson(Map<String, dynamic> json) =>
    PERSON_GLASSESBean(
      lookup_type_id: json['lookup_type_id'] as String?,
      lookup_data_value: json['lookup_data_value'] as String?,
      lookup_data_id: json['lookup_data_id'] as String?,
      OrderBy: json['OrderBy'],
      name: json['name'] as String?,
      active: json['active'] as num?,
    );

Map<String, dynamic> _$PERSON_GLASSESBeanToJson(PERSON_GLASSESBean instance) =>
    <String, dynamic>{
      'lookup_type_id': instance.lookup_type_id,
      'lookup_data_value': instance.lookup_data_value,
      'lookup_data_id': instance.lookup_data_id,
      'OrderBy': instance.OrderBy,
      'name': instance.name,
      'active': instance.active,
    };

PERSON_ETHNICITYBean _$PERSON_ETHNICITYBeanFromJson(
        Map<String, dynamic> json) =>
    PERSON_ETHNICITYBean(
      lookup_type_id: json['lookup_type_id'] as String?,
      lookup_data_value: json['lookup_data_value'] as String?,
      lookup_data_id: json['lookup_data_id'] as String?,
      OrderBy: json['OrderBy'],
      name: json['name'] as String?,
      active: json['active'] as num?,
    );

Map<String, dynamic> _$PERSON_ETHNICITYBeanToJson(
        PERSON_ETHNICITYBean instance) =>
    <String, dynamic>{
      'lookup_type_id': instance.lookup_type_id,
      'lookup_data_value': instance.lookup_data_value,
      'lookup_data_id': instance.lookup_data_id,
      'OrderBy': instance.OrderBy,
      'name': instance.name,
      'active': instance.active,
    };

PERSON_EYE_COLOURBean _$PERSON_EYE_COLOURBeanFromJson(
        Map<String, dynamic> json) =>
    PERSON_EYE_COLOURBean(
      lookup_type_id: json['lookup_type_id'] as String?,
      lookup_data_value: json['lookup_data_value'] as String?,
      lookup_data_id: json['lookup_data_id'] as String?,
      OrderBy: json['OrderBy'],
      name: json['name'] as String?,
      active: json['active'] as num?,
    );

Map<String, dynamic> _$PERSON_EYE_COLOURBeanToJson(
        PERSON_EYE_COLOURBean instance) =>
    <String, dynamic>{
      'lookup_type_id': instance.lookup_type_id,
      'lookup_data_value': instance.lookup_data_value,
      'lookup_data_id': instance.lookup_data_id,
      'OrderBy': instance.OrderBy,
      'name': instance.name,
      'active': instance.active,
    };

OCCUPATIONBean _$OCCUPATIONBeanFromJson(Map<String, dynamic> json) =>
    OCCUPATIONBean(
      lookup_type_id: json['lookup_type_id'] as String?,
      lookup_data_value: json['lookup_data_value'] as String?,
      lookup_data_id: json['lookup_data_id'] as String?,
      OrderBy: json['OrderBy'],
      name: json['name'] as String?,
      active: json['active'] as num?,
    );

Map<String, dynamic> _$OCCUPATIONBeanToJson(OCCUPATIONBean instance) =>
    <String, dynamic>{
      'lookup_type_id': instance.lookup_type_id,
      'lookup_data_value': instance.lookup_data_value,
      'lookup_data_id': instance.lookup_data_id,
      'OrderBy': instance.OrderBy,
      'name': instance.name,
      'active': instance.active,
    };

CASE_VERIFICATION_TYPEBean _$CASE_VERIFICATION_TYPEBeanFromJson(
        Map<String, dynamic> json) =>
    CASE_VERIFICATION_TYPEBean(
      lookup_type_id: json['lookup_type_id'] as String?,
      lookup_data_value: json['lookup_data_value'] as String?,
      lookup_data_id: json['lookup_data_id'] as String?,
      OrderBy: json['OrderBy'],
      name: json['name'] as String?,
      active: json['active'] as num?,
    );

Map<String, dynamic> _$CASE_VERIFICATION_TYPEBeanToJson(
        CASE_VERIFICATION_TYPEBean instance) =>
    <String, dynamic>{
      'lookup_type_id': instance.lookup_type_id,
      'lookup_data_value': instance.lookup_data_value,
      'lookup_data_id': instance.lookup_data_id,
      'OrderBy': instance.OrderBy,
      'name': instance.name,
      'active': instance.active,
    };

PERSON_HAIR_COLOURBean _$PERSON_HAIR_COLOURBeanFromJson(
        Map<String, dynamic> json) =>
    PERSON_HAIR_COLOURBean(
      lookup_type_id: json['lookup_type_id'] as String?,
      lookup_data_value: json['lookup_data_value'] as String?,
      lookup_data_id: json['lookup_data_id'] as String?,
      OrderBy: json['OrderBy'],
      name: json['name'] as String?,
      active: json['active'] as num?,
    );

Map<String, dynamic> _$PERSON_HAIR_COLOURBeanToJson(
        PERSON_HAIR_COLOURBean instance) =>
    <String, dynamic>{
      'lookup_type_id': instance.lookup_type_id,
      'lookup_data_value': instance.lookup_data_value,
      'lookup_data_id': instance.lookup_data_id,
      'OrderBy': instance.OrderBy,
      'name': instance.name,
      'active': instance.active,
    };

CASE_REASON_FOR_ISSUEBean _$CASE_REASON_FOR_ISSUEBeanFromJson(
        Map<String, dynamic> json) =>
    CASE_REASON_FOR_ISSUEBean(
      lookup_type_id: json['lookup_type_id'] as String?,
      lookup_data_value: json['lookup_data_value'] as String?,
      lookup_data_id: json['lookup_data_id'] as String?,
      OrderBy: json['OrderBy'],
      name: json['name'] as String?,
      active: json['active'] as num?,
    );

Map<String, dynamic> _$CASE_REASON_FOR_ISSUEBeanToJson(
        CASE_REASON_FOR_ISSUEBean instance) =>
    <String, dynamic>{
      'lookup_type_id': instance.lookup_type_id,
      'lookup_data_value': instance.lookup_data_value,
      'lookup_data_id': instance.lookup_data_id,
      'OrderBy': instance.OrderBy,
      'name': instance.name,
      'active': instance.active,
    };

REASON_FOR_ISSUE_FOR_MG11Bean _$REASON_FOR_ISSUE_FOR_MG11BeanFromJson(
        Map<String, dynamic> json) =>
    REASON_FOR_ISSUE_FOR_MG11Bean(
      lookup_type_id: json['lookup_type_id'] as String?,
      lookup_data_value: json['lookup_data_value'] as String?,
      lookup_data_id: json['lookup_data_id'] as String?,
      OrderBy: json['OrderBy'],
      name: json['name'] as String?,
      active: json['active'] as num?,
    );

Map<String, dynamic> _$REASON_FOR_ISSUE_FOR_MG11BeanToJson(
        REASON_FOR_ISSUE_FOR_MG11Bean instance) =>
    <String, dynamic>{
      'lookup_type_id': instance.lookup_type_id,
      'lookup_data_value': instance.lookup_data_value,
      'lookup_data_id': instance.lookup_data_id,
      'OrderBy': instance.OrderBy,
      'name': instance.name,
      'active': instance.active,
    };

PERSON_BUILDBean _$PERSON_BUILDBeanFromJson(Map<String, dynamic> json) =>
    PERSON_BUILDBean(
      lookup_type_id: json['lookup_type_id'] as String?,
      lookup_data_value: json['lookup_data_value'] as String?,
      lookup_data_id: json['lookup_data_id'] as String?,
      OrderBy: json['OrderBy'],
      name: json['name'] as String?,
      active: json['active'] as num?,
    );

Map<String, dynamic> _$PERSON_BUILDBeanToJson(PERSON_BUILDBean instance) =>
    <String, dynamic>{
      'lookup_type_id': instance.lookup_type_id,
      'lookup_data_value': instance.lookup_data_value,
      'lookup_data_id': instance.lookup_data_id,
      'OrderBy': instance.OrderBy,
      'name': instance.name,
      'active': instance.active,
    };

CASE_ISSUE_CANCEL_REASONBean _$CASE_ISSUE_CANCEL_REASONBeanFromJson(
        Map<String, dynamic> json) =>
    CASE_ISSUE_CANCEL_REASONBean(
      lookup_type_id: json['lookup_type_id'] as String?,
      lookup_data_value: json['lookup_data_value'] as String?,
      lookup_data_id: json['lookup_data_id'] as String?,
      OrderBy: json['OrderBy'],
      name: json['name'] as String?,
      active: json['active'] as num?,
    );

Map<String, dynamic> _$CASE_ISSUE_CANCEL_REASONBeanToJson(
        CASE_ISSUE_CANCEL_REASONBean instance) =>
    <String, dynamic>{
      'lookup_type_id': instance.lookup_type_id,
      'lookup_data_value': instance.lookup_data_value,
      'lookup_data_id': instance.lookup_data_id,
      'OrderBy': instance.OrderBy,
      'name': instance.name,
      'active': instance.active,
    };

PERSON_FACIAL_HAIR_TYPEBean _$PERSON_FACIAL_HAIR_TYPEBeanFromJson(
        Map<String, dynamic> json) =>
    PERSON_FACIAL_HAIR_TYPEBean(
      lookup_type_id: json['lookup_type_id'] as String?,
      lookup_data_value: json['lookup_data_value'] as String?,
      lookup_data_id: json['lookup_data_id'] as String?,
      OrderBy: json['OrderBy'],
      name: json['name'] as String?,
      active: json['active'] as num?,
    );

Map<String, dynamic> _$PERSON_FACIAL_HAIR_TYPEBeanToJson(
        PERSON_FACIAL_HAIR_TYPEBean instance) =>
    <String, dynamic>{
      'lookup_type_id': instance.lookup_type_id,
      'lookup_data_value': instance.lookup_data_value,
      'lookup_data_id': instance.lookup_data_id,
      'OrderBy': instance.OrderBy,
      'name': instance.name,
      'active': instance.active,
    };

PERSON_TITLEBean _$PERSON_TITLEBeanFromJson(Map<String, dynamic> json) =>
    PERSON_TITLEBean(
      lookup_type_id: json['lookup_type_id'] as String?,
      lookup_data_value: json['lookup_data_value'] as String?,
      lookup_data_id: json['lookup_data_id'] as String?,
      OrderBy: json['OrderBy'],
      name: json['name'] as String?,
      active: json['active'] as num?,
    );

Map<String, dynamic> _$PERSON_TITLEBeanToJson(PERSON_TITLEBean instance) =>
    <String, dynamic>{
      'lookup_type_id': instance.lookup_type_id,
      'lookup_data_value': instance.lookup_data_value,
      'lookup_data_id': instance.lookup_data_id,
      'OrderBy': instance.OrderBy,
      'name': instance.name,
      'active': instance.active,
    };

REASON_FOR_ISSUE_FOR_PCNBean _$REASON_FOR_ISSUE_FOR_PCNBeanFromJson(
        Map<String, dynamic> json) =>
    REASON_FOR_ISSUE_FOR_PCNBean(
      lookup_type_id: json['lookup_type_id'] as String?,
      lookup_data_value: json['lookup_data_value'] as String?,
      lookup_data_id: json['lookup_data_id'] as String?,
      OrderBy: json['OrderBy'],
      name: json['name'] as String?,
      active: json['active'] as num?,
    );

Map<String, dynamic> _$REASON_FOR_ISSUE_FOR_PCNBeanToJson(
        REASON_FOR_ISSUE_FOR_PCNBean instance) =>
    <String, dynamic>{
      'lookup_type_id': instance.lookup_type_id,
      'lookup_data_value': instance.lookup_data_value,
      'lookup_data_id': instance.lookup_data_id,
      'OrderBy': instance.OrderBy,
      'name': instance.name,
      'active': instance.active,
    };
