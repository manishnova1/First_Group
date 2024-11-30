import 'package:json_annotation/json_annotation.dart';

part 'submit_penaltey_model.g.dart';

@JsonSerializable()
class SubmitPenalteyModel {
  String? MESSAGE;
  num? STATUS;
  String? TOCID;
  CASEDETAILSBean? CASEDETAILS;
  bool? ISREVPENABLED;
  dynamic REQUIREDFIELDSERROR;

  SubmitPenalteyModel(
      {this.MESSAGE,
      this.STATUS,
      this.TOCID,
      this.CASEDETAILS,
      this.ISREVPENABLED,
      this.REQUIREDFIELDSERROR});

  factory SubmitPenalteyModel.fromJson(Map<String, dynamic> json) =>
      _$SubmitPenalteyModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitPenalteyModelToJson(this);
}

@JsonSerializable()
class CASEDETAILSBean {
  String? CASEDT;
  String? CASE_TYPE_ID;
  String? CASE_STATUS_ID;
  String? COLOUR;
  String? MODEL;
  String? REGISTRATION_NO;
  String? LOCATION;
  String? CASE_VERIFICATION_TYPE;
  String? PHOTOS;
  String? MAKE;
  String? OFFENCES;
  String? VEHICLE_ID;
  num? CUSTOMERADDRESSMATCH;
  String? OFFENCE_DT;
  String? OFFENCETIME;
  String? ID;
  String? CASENUM;
  num? NAMEMATCH;

  CASEDETAILSBean(
      {this.CASEDT,
      this.CASE_TYPE_ID,
      this.CASE_STATUS_ID,
      this.COLOUR,
      this.MODEL,
      this.REGISTRATION_NO,
      this.LOCATION,
      this.CASE_VERIFICATION_TYPE,
      this.PHOTOS,
      this.MAKE,
      this.OFFENCES,
      this.VEHICLE_ID,
      this.CUSTOMERADDRESSMATCH,
      this.OFFENCE_DT,
      this.OFFENCETIME,
      this.ID,
      this.CASENUM,
      this.NAMEMATCH});

  factory CASEDETAILSBean.fromJson(Map<String, dynamic> json) =>
      _$CASEDETAILSBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CASEDETAILSBeanToJson(this);
}
