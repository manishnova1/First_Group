// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reason_for_issue_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReasonForIssueModel _$ReasonForIssueModelFromJson(Map<String, dynamic> json) =>
    ReasonForIssueModel(
      STATUS: json['STATUS'] as num?,
      TOCID: json['TOCID'] as String?,
      RECORDCOUNT: json['RECORDCOUNT'] as num?,
      ISREVPENABLED: json['ISREVPENABLED'] as bool?,
      REQUIREDFIELDSERROR: json['REQUIREDFIELDSERROR'],
      REVPOFFENCESARRAY: (json['REVPOFFENCESARRAY'] as List<dynamic>?)
          ?.map(
              (e) => REVPOFFENCESARRAYBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReasonForIssueModelToJson(
        ReasonForIssueModel instance) =>
    <String, dynamic>{
      'STATUS': instance.STATUS,
      'TOCID': instance.TOCID,
      'RECORDCOUNT': instance.RECORDCOUNT,
      'ISREVPENABLED': instance.ISREVPENABLED,
      'REQUIREDFIELDSERROR': instance.REQUIREDFIELDSERROR,
      'REVPOFFENCESARRAY': instance.REVPOFFENCESARRAY,
    };

REVPOFFENCESARRAYBean _$REVPOFFENCESARRAYBeanFromJson(
        Map<String, dynamic> json) =>
    REVPOFFENCESARRAYBean(
      lookup_type_id: json['lookup_type_id'] as String?,
      lookup_data_value: json['lookup_data_value'] as String?,
    );

Map<String, dynamic> _$REVPOFFENCESARRAYBeanToJson(
        REVPOFFENCESARRAYBean instance) =>
    <String, dynamic>{
      'lookup_type_id': instance.lookup_type_id,
      'lookup_data_value': instance.lookup_data_value,
    };
