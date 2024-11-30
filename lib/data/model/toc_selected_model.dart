import 'package:json_annotation/json_annotation.dart';

part 'toc_selected_model.g.dart';

@JsonSerializable()
class TocSelectedModel {
  String? toc_name;
  String? toc_heading;
  bool? toc_controls;
  bool? isSelectedIr;

  TocSelectedModel(
      {this.toc_name,
      this.toc_heading,
      this.isSelectedIr = false,
      this.toc_controls});

  factory TocSelectedModel.fromJson(Map<String, dynamic> json) =>
      _$TocSelectedModelFromJson(json);

  Map<String, dynamic> toJson() => _$TocSelectedModelToJson(this);
}
