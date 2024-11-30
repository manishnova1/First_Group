// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toc_selected_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TocSelectedModel _$TocSelectedModelFromJson(Map<String, dynamic> json) =>
    TocSelectedModel(
      toc_name: json['toc_name'] as String?,
      toc_heading: json['toc_heading'] as String?,
      toc_controls: json['toc_controls'] as bool?,
    );

Map<String, dynamic> _$TocSelectedModelToJson(TocSelectedModel instance) =>
    <String, dynamic>{
      'toc_name': instance.toc_name,
      'toc_heading': instance.toc_heading,
      'toc_controls': instance.toc_controls,
    };
