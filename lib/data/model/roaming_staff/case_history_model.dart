import 'package:json_annotation/json_annotation.dart';

part 'case_history_model.g.dart';

@JsonSerializable()
class CaseHistoryModel {
  String? MESSAGE;
  num? STATUS;
  String? TOCID;
  List<STCASEDETAILSBean>? STCASEDETAILS;
  bool? ISREVPENABLED;
  dynamic? REQUIREDFIELDSERROR;

  CaseHistoryModel(
      {this.MESSAGE,
      this.STATUS,
      this.TOCID,
      this.STCASEDETAILS,
      this.ISREVPENABLED,
      this.REQUIREDFIELDSERROR});

  factory CaseHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$CaseHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CaseHistoryModelToJson(this);
}

@JsonSerializable()
class STCASEDETAILSBean {
  String? CREATEDDT;
  num? CASECREATEDTIMEDIFF;
  String? CASEACTION;
  String? STATUSDESC;
  String? CASEID;
  String? CASETYPE;
  String? CREATEDTIME;
  String? CASENUM;

  STCASEDETAILSBean(
      {this.CREATEDDT,
      this.CASECREATEDTIMEDIFF,
      this.CASEACTION,
      this.STATUSDESC,
      this.CASEID,
      this.CASETYPE,
      this.CREATEDTIME,
      this.CASENUM});

  factory STCASEDETAILSBean.fromJson(Map<String, dynamic> json) =>
      _$STCASEDETAILSBeanFromJson(json);

  Map<String, dynamic> toJson() => _$STCASEDETAILSBeanToJson(this);
}
