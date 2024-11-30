import 'package:json_annotation/json_annotation.dart';

part 'submit_model.g.dart';

@JsonSerializable()
class SubmitModel {
  String? MESSAGE;
  num? STATUS;
  String? TOCID;
  CASEDETAILSBean? CASEDETAILS;
  bool? ISREVPENABLED;
  dynamic REQUIREDFIELDSERROR;
  bool? REVP_OFFENDERDESCRIPTIONCAPTURE;

  SubmitModel(
      {this.MESSAGE,
      this.STATUS,
      this.TOCID,
      this.CASEDETAILS,
      this.ISREVPENABLED,
      this.REQUIREDFIELDSERROR,
      this.REVP_OFFENDERDESCRIPTIONCAPTURE});

  factory SubmitModel.fromJson(Map<String, dynamic> json) =>
      _$SubmitModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitModelToJson(this);
}

@JsonSerializable()
class CASEDETAILSBean {
  String? JOURNEY_ID;
  String? CASEDT;
  String? CASE_TYPE_ID;
  String? CASE_STATUS_ID;
  String? CASE_VERIFICATION_TYPE;
  num? CUSTOMERADDRESSMATCH;
  String? OFFENDER_ID;
  String? ID;
  num? NAMEMATCH;
  String? CASENUM;

  CASEDETAILSBean(
      {this.JOURNEY_ID,
      this.CASEDT,
      this.CASE_TYPE_ID,
      this.CASE_STATUS_ID,
      this.CASE_VERIFICATION_TYPE,
      this.CUSTOMERADDRESSMATCH,
      this.OFFENDER_ID,
      this.ID,
      this.NAMEMATCH,
      this.CASENUM});

  factory CASEDETAILSBean.fromJson(Map<String, dynamic> json) =>
      _$CASEDETAILSBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CASEDETAILSBeanToJson(this);
}
