import 'package:json_annotation/json_annotation.dart';

part 'station_list_model.g.dart';

@JsonSerializable()
class StationListModel {
  STSESSIONBean? STSESSION;
  List<ASTATIONBean>? ASTATION;
  num? STATUS;
  String? TOCID;
  num? RECORDCOUNT;

  StationListModel(
      {this.STSESSION,
      this.ASTATION,
      this.STATUS,
      this.TOCID,
      this.RECORDCOUNT});

  factory StationListModel.fromJson(Map<String, dynamic> json) =>
      _$StationListModelFromJson(json);

  Map<String, dynamic> toJson() => _$StationListModelToJson(this);
}

@JsonSerializable()
class ASTATIONBean {
  String? code;
  String? value;
  String? toc;

  ASTATIONBean({this.code, this.value, this.toc});

  factory ASTATIONBean.fromJson(Map<String, dynamic> json) =>
      _$ASTATIONBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ASTATIONBeanToJson(this);
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
