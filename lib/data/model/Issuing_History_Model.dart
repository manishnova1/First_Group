class Issuing_History {
  String? mESSAGE;
  int? sTATUS;
  String? tOCID;
  List<STCASEDETAILS>? sTCASEDETAILS;
  bool? iSREVPENABLED;
  List<String>? rEQUIREDFIELDSERROR;

  Issuing_History(
      {this.mESSAGE,
        this.sTATUS,
        this.tOCID,
        this.sTCASEDETAILS,
        this.iSREVPENABLED,
        this.rEQUIREDFIELDSERROR});

  Issuing_History.fromJson(Map<String, dynamic> json) {
    mESSAGE = json['MESSAGE'];
    sTATUS = json['STATUS'];
    tOCID = json['TOCID'];
    if (json['STCASEDETAILS'] != null) {
      sTCASEDETAILS = <STCASEDETAILS>[];
      json['STCASEDETAILS'].forEach((v) {
        sTCASEDETAILS!.add(new STCASEDETAILS.fromJson(v));
      });
    }
    iSREVPENABLED = json['ISREVPENABLED'];
    if (json['REQUIREDFIELDSERROR'] != null) {
      rEQUIREDFIELDSERROR =[];
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
    if (this.sTCASEDETAILS != null) {
      data['STCASEDETAILS'] =
          this.sTCASEDETAILS!.map((v) => v.toJson()).toList();
    }
    data['ISREVPENABLED'] = this.iSREVPENABLED;
    if (this.rEQUIREDFIELDSERROR != null) {
      data['REQUIREDFIELDSERROR'] =
          this.rEQUIREDFIELDSERROR!.map((v) => v).toList();
    }
    return data;
  }
}

class STCASEDETAILS {
  String? cREATEDDT;
  String? cASECREATEDTIMEDIFF;
  String? cASEACTION;
  String? sTATUSDESC;
  String? cASEID;
  String? cASETYPE;
  String? cREATEDTIME;
  String? cASENUM;
  String? cLOSUREREASONDESC;


  STCASEDETAILS(
      {this.cREATEDDT,
        this.cASECREATEDTIMEDIFF,
        this.cASEACTION,
        this.sTATUSDESC,
        this.cASEID,
        this.cASETYPE,
        this.cREATEDTIME,
        this.cASENUM,
        this.cLOSUREREASONDESC,
      });

  STCASEDETAILS.fromJson(Map<String, dynamic> json) {
    cREATEDDT = json['CREATEDDT'];
    cASECREATEDTIMEDIFF = json['CASECREATEDTIMEDIFF'].toString();
    cASEACTION = json['CASEACTION'];
    sTATUSDESC = json['STATUSDESC'];
    cASEID = json['CASEID'];
    cASETYPE = json['CASETYPE'];
    cREATEDTIME = json['CREATEDTIME'];
    cASENUM = json['CASENUM'];
    cLOSUREREASONDESC = json['CLOSUREREASONDESC'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CREATEDDT'] = this.cREATEDDT;
    data['CASECREATEDTIMEDIFF'] = this.cASECREATEDTIMEDIFF;
    data['CASEACTION'] = this.cASEACTION;
    data['STATUSDESC'] = this.sTATUSDESC;
    data['CASEID'] = this.cASEID;
    data['CASETYPE'] = this.cASETYPE;
    data['CREATEDTIME'] = this.cREATEDTIME;
    data['CASENUM'] = this.cASENUM;
    data['CLOSUREREASONDESC'] = this.cLOSUREREASONDESC;
    return data;
  }
}