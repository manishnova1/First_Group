import 'package:json_annotation/json_annotation.dart';

part 'service_list_mdel.g.dart';

@JsonSerializable()
class ServiceListMdel {
  STSESSIONBean? STSESSION;
  String? ENDSTATION;
  String? STARTSTATION;
  num? STATUS;
  num? RECORDCOUNT;
  List<ASERVICELISTBean>? ASERVICELIST;

  ServiceListMdel(
      {this.STSESSION,
      this.ENDSTATION,
      this.STARTSTATION,
      this.STATUS,
      this.RECORDCOUNT,
      this.ASERVICELIST});

  factory ServiceListMdel.fromJson(Map<String, dynamic> json) =>
      _$ServiceListMdelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceListMdelToJson(this);
}

@JsonSerializable()
class ASERVICELISTBean {
  num? DIFFERENCE;
  num? SIGNEDDIFFERENCE;
  String? AET;
  String? NOW;
  String? TRAINIDENTITY;
  String? AAT;
  num? FUTURETRAIN;
  String? RID;
  String? DET;
  String? PTD;
  String? SERVICEID;
  String? SERVICEDATE;
  String? DAT;
  String? TOC;
  String? PTA;

  ASERVICELISTBean(
      {this.DIFFERENCE,
      this.SIGNEDDIFFERENCE,
      this.AET,
      this.NOW,
      this.TRAINIDENTITY,
      this.AAT,
      this.FUTURETRAIN,
      this.RID,
      this.DET,
      this.PTD,
      this.SERVICEID,
      this.SERVICEDATE,
      this.DAT,
      this.TOC,
      this.PTA});

  factory ASERVICELISTBean.fromJson(Map<String, dynamic> json) =>
      _$ASERVICELISTBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ASERVICELISTBeanToJson(this);
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
