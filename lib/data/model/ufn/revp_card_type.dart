import 'package:json_annotation/json_annotation.dart';

part 'revp_card_type.g.dart';

@JsonSerializable()
class RevpCardType {
  List<REVPRAILCARDTYPEARRAYBean>? REVPRAILCARDTYPEARRAY;
  num? STATUS;
  String? TOCID;
  num? RECORDCOUNT;
  bool? ISREVPENABLED;
  dynamic REQUIREDFIELDSERROR;

  RevpCardType(
      {this.REVPRAILCARDTYPEARRAY,
      this.STATUS,
      this.TOCID,
      this.RECORDCOUNT,
      this.ISREVPENABLED,
      this.REQUIREDFIELDSERROR});

  factory RevpCardType.fromJson(Map<String, dynamic> json) =>
      _$RevpCardTypeFromJson(json);

  Map<String, dynamic> toJson() => _$RevpCardTypeToJson(this);
}

@JsonSerializable()
class REVPRAILCARDTYPEARRAYBean {
  String? revpRailCardType;
  String? revpRailCardTypeID;
  String? revpRailcardID;
  String? revpRailcard;
  String? revpSection;

  REVPRAILCARDTYPEARRAYBean(
      {this.revpRailCardType,
      this.revpRailCardTypeID,
      this.revpRailcardID,
      this.revpRailcard,
      this.revpSection});

  factory REVPRAILCARDTYPEARRAYBean.fromJson(Map<String, dynamic> json) =>
      _$REVPRAILCARDTYPEARRAYBeanFromJson(json);

  Map<String, dynamic> toJson() => _$REVPRAILCARDTYPEARRAYBeanToJson(this);
}
