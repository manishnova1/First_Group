import 'package:json_annotation/json_annotation.dart';

part 'revp_validateldentity_model.g.dart';

@JsonSerializable()
class RevpValidateldentityModel {
  List<REVPIDENTITYARRAYBean>? REVPIDENTITYARRAY;
  num? STATUS;
  String? TOCID;
  num? RECORDCOUNT;
  bool? ISREVPENABLED;
  dynamic? REQUIREDFIELDSERROR;

  RevpValidateldentityModel(
      {this.REVPIDENTITYARRAY,
      this.STATUS,
      this.TOCID,
      this.RECORDCOUNT,
      this.ISREVPENABLED,
      this.REQUIREDFIELDSERROR});

  factory RevpValidateldentityModel.fromJson(Map<String, dynamic> json) =>
      _$RevpValidateldentityModelFromJson(json);

  Map<String, dynamic> toJson() => _$RevpValidateldentityModelToJson(this);
}

@JsonSerializable()
class REVPIDENTITYARRAYBean {
  String? LASTNAME;
  String? FIRSTNAME;
  String? MIDDLENAME;
  String? TITLE;

  REVPIDENTITYARRAYBean(
      {this.LASTNAME, this.FIRSTNAME, this.MIDDLENAME, this.TITLE});

  factory REVPIDENTITYARRAYBean.fromJson(Map<String, dynamic> json) =>
      _$REVPIDENTITYARRAYBeanFromJson(json);

  Map<String, dynamic> toJson() => _$REVPIDENTITYARRAYBeanToJson(this);
}
