class StCaseDetailsPrint {
  int? sTATUS;
  List<STCASEDETAILSPRINT>? sTCASEDETAILSPRINT;

  StCaseDetailsPrint({this.sTATUS, this.sTCASEDETAILSPRINT});

  StCaseDetailsPrint.fromJson(Map<String, dynamic> json) {
    sTATUS = json['STATUS'];
    if (json['STCASEDETAILS'] != null) {
      sTCASEDETAILSPRINT = <STCASEDETAILSPRINT>[];
      json['STCASEDETAILS'].forEach((v) {
        sTCASEDETAILSPRINT!.add(new STCASEDETAILSPRINT.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATUS'] = this.sTATUS;
    if (this.sTCASEDETAILSPRINT != null) {
      data['STCASEDETAILS'] =
          this.sTCASEDETAILSPRINT!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class STCASEDETAILSPRINT {
  String? cASETYPECODEPRINT;
  String? cASETYPEIDPRINT;
  dynamic eNABLESTATTUSPRINT;

  STCASEDETAILSPRINT(
      {this.cASETYPECODEPRINT, this.cASETYPEIDPRINT, this.eNABLESTATTUSPRINT});

  STCASEDETAILSPRINT.fromJson(Map<String, dynamic> json) {
    cASETYPECODEPRINT = json['CASETYPECODE'];
    cASETYPEIDPRINT = json['CASETYPEID'];
    eNABLESTATTUSPRINT = json['ENABLESTATTUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CASETYPECODE'] = this.cASETYPECODEPRINT;
    data['CASETYPEID'] = this.cASETYPEIDPRINT;
    data['ENABLESTATTUS'] = this.eNABLESTATTUSPRINT;
    return data;
  }
}
