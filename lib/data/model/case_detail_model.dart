class StCaseDetails {
  int? sTATUS;
  List<STCASEDETAILS>? sTCASEDETAILS;

  StCaseDetails({this.sTATUS, this.sTCASEDETAILS});

  StCaseDetails.fromJson(Map<String, dynamic> json) {
    sTATUS = json['STATUS'];
    if (json['STCASEDETAILS'] != null) {
      sTCASEDETAILS = <STCASEDETAILS>[];
      json['STCASEDETAILS'].forEach((v) {
        sTCASEDETAILS!.add(new STCASEDETAILS.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS'] = this.sTATUS;
    if (this.sTCASEDETAILS != null) {
      data['STCASEDETAILS'] =
          this.sTCASEDETAILS!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class STCASEDETAILS {
  String? cASETYPECODE;
  String? cASETYPEID;
  dynamic eNABLESTATTUS;

  STCASEDETAILS({this.cASETYPECODE, this.cASETYPEID, this.eNABLESTATTUS});

  STCASEDETAILS.fromJson(Map<String, dynamic> json) {
    cASETYPECODE = json['CASETYPECODE'];
    cASETYPEID = json['CASETYPEID'];
    eNABLESTATTUS = json['ENABLESTATTUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CASETYPECODE'] = this.cASETYPECODE;
    data['CASETYPEID'] = this.cASETYPEID;
    data['ENABLESTATTUS'] = this.eNABLESTATTUS;
    return data;
  }
}
