import 'package:json_annotation/json_annotation.dart';

part 'case_reference_model.g.dart';

@JsonSerializable()
class CaseReferenceModel {
  STSESSIONBean? STSESSION;
  num? STATUS;
  String? TOCID;
  num? RECORDCOUNT;
  dynamic REQUIREDFIELDSERROR;
  List<REVPREFERENCESARRAYBean>? REVPREFERENCESARRAY;

  CaseReferenceModel(
      {this.STSESSION,
      this.STATUS,
      this.TOCID,
      this.RECORDCOUNT,
      this.REQUIREDFIELDSERROR,
      this.REVPREFERENCESARRAY});

  factory CaseReferenceModel.fromJson(Map<String, dynamic> json) =>
      _$CaseReferenceModelFromJson(json);

  Map<String, dynamic> toJson() => _$CaseReferenceModelToJson(this);
}

@JsonSerializable()
class REVPREFERENCESARRAYBean {
  num? ISUSED;
  num? ISLOCKED;
  String? CASE_REFERENCE_NO;

  REVPREFERENCESARRAYBean({this.ISUSED, this.ISLOCKED, this.CASE_REFERENCE_NO});

  factory REVPREFERENCESARRAYBean.fromJson(Map<String, dynamic> json) =>
      _$REVPREFERENCESARRAYBeanFromJson(json);

  Map<String, dynamic> toJson() => _$REVPREFERENCESARRAYBeanToJson(this);
}

@JsonSerializable()
class STSESSIONBean {
  String? SSESSIONID;
  String? SSESSIONTYPE;

  STSESSIONBean({this.SSESSIONID, this.SSESSIONTYPE});

  factory STSESSIONBean.fromJson(Map<String, dynamic> json) =>
      _$STSESSIONBeanFromJson(json);

  Map<String, dynamic> toJson() => _$STSESSIONBeanToJson(this);
}
