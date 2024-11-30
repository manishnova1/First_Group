class IssuingHistoryIRModel {
  String? mESSAGE;
  String? sTATUS;
  String? tOCID;
  List<STCASEDETAILS_IR>? sTCASEDETAILS_IR;
  bool? iSREVPENABLED;
  List<String>? rEQUIREDFIELDSERROR;

  IssuingHistoryIRModel(
      {this.mESSAGE,
      this.sTATUS,
      this.tOCID,
      this.sTCASEDETAILS_IR,
      this.iSREVPENABLED,
      this.rEQUIREDFIELDSERROR});

  IssuingHistoryIRModel.fromJson(Map<String, dynamic> json) {
    mESSAGE = json['MESSAGE'];
    sTATUS = json['STATUS'].toString();
    tOCID = json['TOCID'];
    if (json['STCASEDETAILS'] != null) {
      sTCASEDETAILS_IR = <STCASEDETAILS_IR>[];
      json['STCASEDETAILS'].forEach((v) {
        sTCASEDETAILS_IR!.add(new STCASEDETAILS_IR.fromJson(v));
      });
    }
    iSREVPENABLED = json['ISREVPENABLED'];
    if (json['REQUIREDFIELDSERROR'] != null) {
      rEQUIREDFIELDSERROR = [];
      json['REQUIREDFIELDSERROR'].forEach((v) {
        rEQUIREDFIELDSERROR!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MESSAGE'] = this.mESSAGE;
    data['STATUS'] = this.sTATUS;
    data['TOCID'] = this.tOCID;
    if (this.sTCASEDETAILS_IR != null) {
      data['STCASEDETAILS'] =
          this.sTCASEDETAILS_IR!.map((v) => v.toJson()).toList();
    }
    data['ISREVPENABLED'] = this.iSREVPENABLED;
    if (this.rEQUIREDFIELDSERROR != null) {
      data['REQUIREDFIELDSERROR'] =
          this.rEQUIREDFIELDSERROR!.map((v) => v).toList();
    }
    return data;
  }
}

class STCASEDETAILS_IR {
  String? cREATEDDT;
  String? cASECREATEDTIMEDIFF;
  String? cASEACTION;
  String? pEPORT;
  String? cASEID;
  String? cREATEDTIME;
  String? cASENUM;

  STCASEDETAILS_IR(
      {this.cREATEDDT,
      this.cASECREATEDTIMEDIFF,
      this.cASEACTION,
      this.pEPORT,
      this.cASEID,
      this.cREATEDTIME,
      this.cASENUM});

  STCASEDETAILS_IR.fromJson(Map<String, dynamic> json) {
    cREATEDDT = json['CREATEDDT'];
    cASECREATEDTIMEDIFF = json['CASECREATEDTIMEDIFF'].toString();
    cASEACTION = json['CASEACTION'];
    pEPORT = json['PEPORT'];
    cASEID = json['CASEID'];
    cREATEDTIME = json['CREATEDTIME'];
    cASENUM = json['CASENUM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CREATEDDT'] = this.cREATEDDT;
    data['CASECREATEDTIMEDIFF'] = this.cASECREATEDTIMEDIFF;
    data['CASEACTION'] = this.cASEACTION;
    data['PEPORT'] = this.pEPORT;
    data['CASEID'] = this.cASEID;
    data['CREATEDTIME'] = this.cREATEDTIME;
    data['CASENUM'] = this.cASENUM;
    return data;
  }
}
