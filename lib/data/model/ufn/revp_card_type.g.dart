// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revp_card_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RevpCardType _$RevpCardTypeFromJson(Map<String, dynamic> json) => RevpCardType(
      REVPRAILCARDTYPEARRAY: (json['REVPRAILCARDTYPEARRAY'] as List<dynamic>?)
          ?.map((e) =>
              REVPRAILCARDTYPEARRAYBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      STATUS: json['STATUS'] as num?,
      TOCID: json['TOCID'] as String?,
      RECORDCOUNT: json['RECORDCOUNT'] as num?,
      ISREVPENABLED: json['ISREVPENABLED'] as bool?,
      REQUIREDFIELDSERROR: json['REQUIREDFIELDSERROR'],
    );

Map<String, dynamic> _$RevpCardTypeToJson(RevpCardType instance) =>
    <String, dynamic>{
      'REVPRAILCARDTYPEARRAY': instance.REVPRAILCARDTYPEARRAY,
      'STATUS': instance.STATUS,
      'TOCID': instance.TOCID,
      'RECORDCOUNT': instance.RECORDCOUNT,
      'ISREVPENABLED': instance.ISREVPENABLED,
      'REQUIREDFIELDSERROR': instance.REQUIREDFIELDSERROR,
    };

REVPRAILCARDTYPEARRAYBean _$REVPRAILCARDTYPEARRAYBeanFromJson(
        Map<String, dynamic> json) =>
    REVPRAILCARDTYPEARRAYBean(
      revpRailCardType: json['revpRailCardType'] as String?,
      revpRailCardTypeID: json['revpRailCardTypeID'] as String?,
      revpRailcardID: json['revpRailcardID'] as String?,
      revpRailcard: json['revpRailcard'] as String?,
      revpSection: json['revpSection'] as String?,
    );

Map<String, dynamic> _$REVPRAILCARDTYPEARRAYBeanToJson(
        REVPRAILCARDTYPEARRAYBean instance) =>
    <String, dynamic>{
      'revpRailCardType': instance.revpRailCardType,
      'revpRailCardTypeID': instance.revpRailCardTypeID,
      'revpRailcardID': instance.revpRailcardID,
      'revpRailcard': instance.revpRailcard,
      'revpSection': instance.revpSection,
    };
