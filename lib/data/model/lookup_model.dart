import 'package:json_annotation/json_annotation.dart';

import 'lookup_model.dart';
import 'lookup_model.dart';

part 'lookup_model.g.dart';

@JsonSerializable()
class LookupModel {
  List<REASON_FOR_ISSUE_FOR_PCNBean>? REASON_FOR_ISSUE_FOR_PCN;
  List<REASON_FOR_ISSUE_FOR_MG11Bean>? REASON_FOR_ISSUE_FOR_MG11;

  dynamic REVPCLASSESARRAY;
  List<PERSON_TITLEBean>? PERSON_TITLE;
  List<PERSON_FACIAL_HAIR_TYPEBean>? PERSON_FACIAL_HAIR_TYPE;
  List<CASE_ISSUE_CANCEL_REASONBean>? CASE_ISSUE_CANCEL_REASON;
  List<PERSON_BUILDBean>? PERSON_BUILD;
  List<CASE_REASON_FOR_ISSUEBean>? CASE_REASON_FOR_ISSUE;
  List<PERSON_HAIR_COLOURBean>? PERSON_HAIR_COLOUR;
  List<CASE_VERIFICATION_TYPEBean>? CASE_VERIFICATION_TYPE;
  num? STATUS;
  String? TOCID;
  List<OCCUPATIONBean>? OCCUPATION;
  List<PERSON_EYE_COLOURBean>? PERSON_EYE_COLOUR;
  List<PERSON_GLASSESBean>? PERSON_GLASSES;
  List<PERSON_ETHNICITYBean>? PERSON_ETHNICITY;
  bool? ISREVPENABLED;
  dynamic REQUIREDFIELDSERROR;
  List<CASE_CLASSESBean>? CASE_CLASSES;

  LookupModel(
      {this.REASON_FOR_ISSUE_FOR_PCN,
      this.REASON_FOR_ISSUE_FOR_MG11,
      this.REVPCLASSESARRAY,
      this.PERSON_TITLE,
      this.PERSON_FACIAL_HAIR_TYPE,
      this.CASE_ISSUE_CANCEL_REASON,
      this.PERSON_BUILD,
      this.CASE_REASON_FOR_ISSUE,
      this.PERSON_HAIR_COLOUR,
      this.CASE_VERIFICATION_TYPE,
      this.STATUS,
      this.TOCID,
      this.OCCUPATION,
      this.PERSON_EYE_COLOUR,
      this.PERSON_GLASSES,
      this.PERSON_ETHNICITY,
      this.ISREVPENABLED,
      this.REQUIREDFIELDSERROR,
      this.CASE_CLASSES});

  factory LookupModel.fromJson(Map<String, dynamic> json) =>
      _$LookupModelFromJson(json);

  Map<String, dynamic> toJson() => _$LookupModelToJson(this);
}

@JsonSerializable()
class CASE_CLASSESBean {
  String? lookup_type_id;
  String? lookup_data_value;
  String? lookup_data_id;
  dynamic OrderBy;
  String? name;
  num? active;

  CASE_CLASSESBean(
      {this.lookup_type_id,
      this.lookup_data_value,
      this.lookup_data_id,
      this.OrderBy,
      this.name,
      this.active});

  factory CASE_CLASSESBean.fromJson(Map<String, dynamic> json) =>
      _$CASE_CLASSESBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CASE_CLASSESBeanToJson(this);
}

@JsonSerializable()
class PERSON_GLASSESBean {
  String? lookup_type_id;
  String? lookup_data_value;
  String? lookup_data_id;
  dynamic OrderBy;
  String? name;
  num? active;

  PERSON_GLASSESBean(
      {this.lookup_type_id,
      this.lookup_data_value,
      this.lookup_data_id,
      this.OrderBy,
      this.name,
      this.active});

  factory PERSON_GLASSESBean.fromJson(Map<String, dynamic> json) =>
      _$PERSON_GLASSESBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PERSON_GLASSESBeanToJson(this);
}

@JsonSerializable()
class PERSON_ETHNICITYBean {
  String? lookup_type_id;
  String? lookup_data_value;
  String? lookup_data_id;
  dynamic OrderBy;
  String? name;
  num? active;

  PERSON_ETHNICITYBean(
      {this.lookup_type_id,
      this.lookup_data_value,
      this.lookup_data_id,
      this.OrderBy,
      this.name,
      this.active});

  factory PERSON_ETHNICITYBean.fromJson(Map<String, dynamic> json) =>
      _$PERSON_ETHNICITYBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PERSON_ETHNICITYBeanToJson(this);
}

@JsonSerializable()
class PERSON_EYE_COLOURBean {
  String? lookup_type_id;
  String? lookup_data_value;
  String? lookup_data_id;
  dynamic OrderBy;
  String? name;
  num? active;

  PERSON_EYE_COLOURBean(
      {this.lookup_type_id,
      this.lookup_data_value,
      this.lookup_data_id,
      this.OrderBy,
      this.name,
      this.active});

  factory PERSON_EYE_COLOURBean.fromJson(Map<String, dynamic> json) =>
      _$PERSON_EYE_COLOURBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PERSON_EYE_COLOURBeanToJson(this);
}

@JsonSerializable()
class OCCUPATIONBean {
  String? lookup_type_id;
  String? lookup_data_value;
  String? lookup_data_id;
  dynamic OrderBy;
  String? name;
  num? active;

  OCCUPATIONBean(
      {this.lookup_type_id,
      this.lookup_data_value,
      this.lookup_data_id,
      this.OrderBy,
      this.name,
      this.active});

  factory OCCUPATIONBean.fromJson(Map<String, dynamic> json) =>
      _$OCCUPATIONBeanFromJson(json);

  Map<String, dynamic> toJson() => _$OCCUPATIONBeanToJson(this);
}

@JsonSerializable()
class CASE_VERIFICATION_TYPEBean {
  String? lookup_type_id;
  String? lookup_data_value;
  String? lookup_data_id;
  dynamic OrderBy;
  String? name;
  num? active;

  CASE_VERIFICATION_TYPEBean(
      {this.lookup_type_id,
      this.lookup_data_value,
      this.lookup_data_id,
      this.OrderBy,
      this.name,
      this.active});

  factory CASE_VERIFICATION_TYPEBean.fromJson(Map<String, dynamic> json) =>
      _$CASE_VERIFICATION_TYPEBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CASE_VERIFICATION_TYPEBeanToJson(this);
}

@JsonSerializable()
class PERSON_HAIR_COLOURBean {
  String? lookup_type_id;
  String? lookup_data_value;
  String? lookup_data_id;
  dynamic? OrderBy;
  String? name;
  num? active;

  PERSON_HAIR_COLOURBean(
      {this.lookup_type_id,
      this.lookup_data_value,
      this.lookup_data_id,
      this.OrderBy,
      this.name,
      this.active});

  factory PERSON_HAIR_COLOURBean.fromJson(Map<String, dynamic> json) =>
      _$PERSON_HAIR_COLOURBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PERSON_HAIR_COLOURBeanToJson(this);
}

@JsonSerializable()
class CASE_REASON_FOR_ISSUEBean {
  String? lookup_type_id;
  String? lookup_data_value;
  String? lookup_data_id;
  dynamic? OrderBy;
  String? name;
  num? active;

  CASE_REASON_FOR_ISSUEBean(
      {this.lookup_type_id,
      this.lookup_data_value,
      this.lookup_data_id,
      this.OrderBy,
      this.name,
      this.active});

  factory CASE_REASON_FOR_ISSUEBean.fromJson(Map<String, dynamic> json) =>
      _$CASE_REASON_FOR_ISSUEBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CASE_REASON_FOR_ISSUEBeanToJson(this);
}

@JsonSerializable()
class REASON_FOR_ISSUE_FOR_MG11Bean {
  String? lookup_type_id;
  String? lookup_data_value;
  String? lookup_data_id;
  dynamic? OrderBy;
  String? name;
  num? active;

  REASON_FOR_ISSUE_FOR_MG11Bean(
      {this.lookup_type_id,
      this.lookup_data_value,
      this.lookup_data_id,
      this.OrderBy,
      this.name,
      this.active});

  factory REASON_FOR_ISSUE_FOR_MG11Bean.fromJson(Map<String, dynamic> json) =>
      _$REASON_FOR_ISSUE_FOR_MG11BeanFromJson(json);

  Map<String, dynamic> toJson() => _$REASON_FOR_ISSUE_FOR_MG11BeanToJson(this);
}

@JsonSerializable()
class PERSON_BUILDBean {
  String? lookup_type_id;
  String? lookup_data_value;
  String? lookup_data_id;
  dynamic? OrderBy;
  String? name;
  num? active;

  PERSON_BUILDBean(
      {this.lookup_type_id,
      this.lookup_data_value,
      this.lookup_data_id,
      this.OrderBy,
      this.name,
      this.active});

  factory PERSON_BUILDBean.fromJson(Map<String, dynamic> json) =>
      _$PERSON_BUILDBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PERSON_BUILDBeanToJson(this);
}

@JsonSerializable()
class CASE_ISSUE_CANCEL_REASONBean {
  String? lookup_type_id;
  String? lookup_data_value;
  String? lookup_data_id;
  dynamic OrderBy;
  String? name;
  num? active;

  CASE_ISSUE_CANCEL_REASONBean(
      {this.lookup_type_id,
      this.lookup_data_value,
      this.lookup_data_id,
      this.OrderBy,
      this.name,
      this.active});

  factory CASE_ISSUE_CANCEL_REASONBean.fromJson(Map<String, dynamic> json) =>
      _$CASE_ISSUE_CANCEL_REASONBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CASE_ISSUE_CANCEL_REASONBeanToJson(this);
}

@JsonSerializable()
class PERSON_FACIAL_HAIR_TYPEBean {
  String? lookup_type_id;
  String? lookup_data_value;
  String? lookup_data_id;
  dynamic OrderBy;
  String? name;
  num? active;

  PERSON_FACIAL_HAIR_TYPEBean(
      {this.lookup_type_id,
      this.lookup_data_value,
      this.lookup_data_id,
      this.OrderBy,
      this.name,
      this.active});

  factory PERSON_FACIAL_HAIR_TYPEBean.fromJson(Map<String, dynamic> json) =>
      _$PERSON_FACIAL_HAIR_TYPEBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PERSON_FACIAL_HAIR_TYPEBeanToJson(this);
}

@JsonSerializable()
class PERSON_TITLEBean {
  String? lookup_type_id;
  String? lookup_data_value;
  String? lookup_data_id;
  dynamic OrderBy;
  String? name;
  num? active;

  PERSON_TITLEBean(
      {this.lookup_type_id,
      this.lookup_data_value,
      this.lookup_data_id,
      this.OrderBy,
      this.name,
      this.active});

  factory PERSON_TITLEBean.fromJson(Map<String, dynamic> json) =>
      _$PERSON_TITLEBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PERSON_TITLEBeanToJson(this);
}

@JsonSerializable()
class REASON_FOR_ISSUE_FOR_PCNBean {
  String? lookup_type_id;
  String? lookup_data_value;
  String? lookup_data_id;
  dynamic OrderBy;
  String? name;
  num? active;

  REASON_FOR_ISSUE_FOR_PCNBean(
      {this.lookup_type_id,
      this.lookup_data_value,
      this.lookup_data_id,
      this.OrderBy,
      this.name,
      this.active});

  factory REASON_FOR_ISSUE_FOR_PCNBean.fromJson(Map<String, dynamic> json) =>
      _$REASON_FOR_ISSUE_FOR_PCNBeanFromJson(json);

  Map<String, dynamic> toJson() => _$REASON_FOR_ISSUE_FOR_PCNBeanToJson(this);
}
