import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  String? ISGOGAPPUSER;
  String? IS_SSO_LOGIN;
  String? DEFAULTREVENUEPROTECTIONTEAM;
  String? REVPAPPADDITIONALADMINFEEAMOUNT;
  bool? IS_TESTNOTICE;
  String? RAILPAYSTATIONTYPE;
  String? SMARTCARDNUMBERINITIAL;
  String? PTTLABELLONG;
  String? GOGAUTOCLOSESESSIONTIMEOUT;
  bool? IS_ISSUEHISTORY_ISSUER;
  bool? IS_UNPAID_FARE_ISSUER;
  bool? IS_CAR_PARKING_PENALTY_ISSUER;
  num? STATUS;
  bool? ISPTTAPPSCANNER;
  bool? ISIRISSUER;
  String? TOCID;
  bool? INTELLIGENCEREPORTENABLED;
  String? REVPPAYMENTDEADLINEDATE;
  STUSERBean? STUSER;
  String? SMARTCARDFIELDAPP;
  bool? ISREVPENABLED;
  bool? ISGOGENABLED;
  bool? ISPTTENABLED;
  bool? ISREVPOFFENDERDESCRIPTIONCAPTURE;
  String? REVPZEROFARETICKETENABLED;
  String? TOCPRIVACYPOLICYLINK;
  bool? IS_PENALTY_FARE_ISSUER;
  bool? IS_MG11;
  bool? IS_REVP_MASTER;
  String? PKEY;
  STCONFIGBean? STCONFIG;
  bool? IS_UNPAID_FARE_ISSUERHT;
  String? REVPAPPLANGUAGEENABLED;
  bool? IS_COUNTER_PASSENGER_USER;
  String? PTTADVANCEDDAYS;
  String? PTTLABELSHORT;
  bool? ISPTTAPPISSUER;
  dynamic REQUIREDFIELDSERROR;
  dynamic PFNEWCALCULATIONSTARTDATE;
  dynamic PFN_DISCOUNTED_DAYS;
  dynamic PFN_DISCOUNT_PERCENTAGE;
  dynamic PFN_TOTAL_PENALTY;

  LoginModel(
      {this.IS_SSO_LOGIN,
      this.DEFAULTREVENUEPROTECTIONTEAM,
      this.PFN_DISCOUNT_PERCENTAGE,
      this.IS_TESTNOTICE,
      this.INTELLIGENCEREPORTENABLED,
      this.PFNEWCALCULATIONSTARTDATE,
      this.PFN_DISCOUNTED_DAYS,
      this.PFN_TOTAL_PENALTY,
      this.ISGOGAPPUSER,
      this.REVPAPPADDITIONALADMINFEEAMOUNT,
      this.RAILPAYSTATIONTYPE,
      this.SMARTCARDNUMBERINITIAL,
      this.PTTLABELLONG,
      this.GOGAUTOCLOSESESSIONTIMEOUT,
      this.IS_ISSUEHISTORY_ISSUER,
      this.IS_UNPAID_FARE_ISSUER,
      this.IS_CAR_PARKING_PENALTY_ISSUER,
      this.STATUS,
      this.ISPTTAPPSCANNER,
      this.ISIRISSUER,
      this.TOCID,
      this.REVPPAYMENTDEADLINEDATE,
      this.STUSER,
      this.SMARTCARDFIELDAPP,
      this.ISREVPENABLED,
      this.ISGOGENABLED,
      this.ISPTTENABLED,
      this.ISREVPOFFENDERDESCRIPTIONCAPTURE,
      this.REVPZEROFARETICKETENABLED,
      this.TOCPRIVACYPOLICYLINK,
      this.IS_PENALTY_FARE_ISSUER,
      this.IS_MG11,
      this.IS_REVP_MASTER,
      this.PKEY,
      this.STCONFIG,
      this.IS_UNPAID_FARE_ISSUERHT,
      this.REVPAPPLANGUAGEENABLED,
      this.IS_COUNTER_PASSENGER_USER,
      this.PTTADVANCEDDAYS,
      this.PTTLABELSHORT,
      this.ISPTTAPPISSUER,
      this.REQUIREDFIELDSERROR});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

@JsonSerializable()
class STCONFIGBean {
  String? SAPPSESSIONID;
  String? SAPIURL;

  STCONFIGBean({this.SAPPSESSIONID, this.SAPIURL});

  factory STCONFIGBean.fromJson(Map<String, dynamic> json) =>
      _$STCONFIGBeanFromJson(json);

  Map<String, dynamic> toJson() => _$STCONFIGBeanToJson(this);
}

@JsonSerializable()
class STUSERBean {
  num? REMAININGLIMIT;
  num? DAYLEFTFORCHANGEPASSWORD;
  num? SINGLETRANSACTIONLIMIT;
  String? MACADRESS;
  String? SFORENAME;
  num? PASSWORDCHANGEFREQUENCY;
  String? ID;
  String? SEMAILADDRESS;
  num? DAILYTRANSACTIONLIMIT;
  String? SUSERNAME;
  String? SSURNAME;

  STUSERBean(
      {this.REMAININGLIMIT,
      this.DAYLEFTFORCHANGEPASSWORD,
      this.SINGLETRANSACTIONLIMIT,
      this.MACADRESS,
      this.SFORENAME,
      this.PASSWORDCHANGEFREQUENCY,
      this.ID,
      this.SEMAILADDRESS,
      this.DAILYTRANSACTIONLIMIT,
      this.SUSERNAME,
      this.SSURNAME});

  factory STUSERBean.fromJson(Map<String, dynamic> json) =>
      _$STUSERBeanFromJson(json);

  Map<String, dynamic> toJson() => _$STUSERBeanToJson(this);
}
