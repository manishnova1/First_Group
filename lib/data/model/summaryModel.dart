class summaryModel {
  String? cASETYPECODE;
  String? tOTALAMOUNTDUE;
  String? tOTALAMOUNTPAID;
  String? cASETYPEDESCRIPTION;
  String? cASECOUNT;
  String? tOTALAMOUNTISSUED;

  summaryModel(
      {this.cASETYPECODE,
      this.tOTALAMOUNTDUE,
      this.tOTALAMOUNTPAID,
      this.cASETYPEDESCRIPTION,
      this.cASECOUNT,
      this.tOTALAMOUNTISSUED});

  summaryModel.fromJson(Map<String, dynamic> json) {
    cASETYPECODE = json['CASETYPECODE'].toString();
    tOTALAMOUNTDUE = json['TOTALAMOUNTDUE'].toString();
    tOTALAMOUNTPAID = json['TOTALAMOUNTPAID'].toString();
    cASETYPEDESCRIPTION = json['CASETYPEDESCRIPTION'].toString();
    cASECOUNT = json['CASECOUNT'].toString();
    tOTALAMOUNTISSUED = json['TOTALAMOUNTISSUED'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CASETYPECODE'] = this.cASETYPECODE;
    data['TOTALAMOUNTDUE'] = this.tOTALAMOUNTDUE;
    data['TOTALAMOUNTPAID'] = this.tOTALAMOUNTPAID;
    data['CASETYPEDESCRIPTION'] = this.cASETYPEDESCRIPTION;
    data['CASECOUNT'] = this.cASECOUNT;
    data['TOTALAMOUNTISSUED'] = this.tOTALAMOUNTISSUED;
    return data;
  }
}
