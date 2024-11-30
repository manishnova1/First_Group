import 'package:json_annotation/json_annotation.dart';

part 'print_template_ditales.g.dart';

@JsonSerializable()
class PrintTemplateDitales {
  dynamic STSESSION;
  List<PRINTTEMPLATEBean>? PRINTTEMPLATE;
  num? STATUS;
  String? TOCID;
  num? RECORDCOUNT;
  dynamic REQUIREDFIELDSERROR;

  PrintTemplateDitales(
      {this.STSESSION,
      this.PRINTTEMPLATE,
      this.STATUS,
      this.TOCID,
      this.RECORDCOUNT,
      this.REQUIREDFIELDSERROR});

  factory PrintTemplateDitales.fromJson(Map<String, dynamic> json) =>
      _$PrintTemplateDitalesFromJson(json);

  Map<String, dynamic> toJson() => _$PrintTemplateDitalesToJson(this);
}

@JsonSerializable()
class PRINTTEMPLATEBean {
  dynamic ACTIVE;
  String? CONTENTS;
  String? TITLE;
  String? CASETYPE;

  PRINTTEMPLATEBean({this.ACTIVE, this.CONTENTS, this.TITLE, this.CASETYPE});

  factory PRINTTEMPLATEBean.fromJson(Map<String, dynamic> json) =>
      _$PRINTTEMPLATEBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PRINTTEMPLATEBeanToJson(this);
}
//this.CASETYPE
