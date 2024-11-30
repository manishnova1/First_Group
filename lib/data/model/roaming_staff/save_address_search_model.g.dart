// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_address_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveAddressSearchModel _$SaveAddressSearchModelFromJson(
        Map<String, dynamic> json) =>
    SaveAddressSearchModel(
      MESSAGE: json['MESSAGE'] as String?,
      STATUS: json['STATUS'] as num?,
      TOCID: json['TOCID'] as String?,
      ISREVPENABLED: json['ISREVPENABLED'] as bool?,
      REQUIREDFIELDSERROR: json['REQUIREDFIELDSERROR'],
    );

Map<String, dynamic> _$SaveAddressSearchModelToJson(
        SaveAddressSearchModel instance) =>
    <String, dynamic>{
      'MESSAGE': instance.MESSAGE,
      'STATUS': instance.STATUS,
      'TOCID': instance.TOCID,
      'ISREVPENABLED': instance.ISREVPENABLED,
      'REQUIREDFIELDSERROR': instance.REQUIREDFIELDSERROR,
    };
