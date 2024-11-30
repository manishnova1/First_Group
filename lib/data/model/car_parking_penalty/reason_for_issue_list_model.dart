import 'package:json_annotation/json_annotation.dart';

part 'reason_for_issue_list_model.g.dart';

@JsonSerializable()
class ReasonForIssueModel {
  num? STATUS;
  String? TOCID;
  num? RECORDCOUNT;
  bool? ISREVPENABLED;
  dynamic REQUIREDFIELDSERROR;
  List<REVPOFFENCESARRAYBean>? REVPOFFENCESARRAY;

  ReasonForIssueModel(
      {this.STATUS,
      this.TOCID,
      this.RECORDCOUNT,
      this.ISREVPENABLED,
      this.REQUIREDFIELDSERROR,
      this.REVPOFFENCESARRAY});

  factory ReasonForIssueModel.fromJson(Map<String, dynamic> json) =>
      _$ReasonForIssueModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReasonForIssueModelToJson(this);
}

//nakdan
@JsonSerializable()
class REVPOFFENCESARRAYBean {
  String? lookup_type_id;
  String? lookup_data_value;

  REVPOFFENCESARRAYBean({this.lookup_type_id, this.lookup_data_value});

  factory REVPOFFENCESARRAYBean.fromJson(Map<String, dynamic> json) =>
      _$REVPOFFENCESARRAYBeanFromJson(json);

  Map<String, dynamic> toJson() => _$REVPOFFENCESARRAYBeanToJson(this);
}
