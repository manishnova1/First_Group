class revpirDetailsModel {
  List<REVPIRDETAILSARRAY>? rEVPIRDETAILSARRAY;
  int? sTATUS;
  String? tOCID;
  int? rECORDCOUNT;
  bool? iSREVPENABLED;
  List<String>? rEQUIREDFIELDSERROR;

  revpirDetailsModel(
      {this.rEVPIRDETAILSARRAY,
      this.sTATUS,
      this.tOCID,
      this.rECORDCOUNT,
      this.iSREVPENABLED,
      this.rEQUIREDFIELDSERROR});

  revpirDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['REVPIRDETAILSARRAY'] != null) {
      rEVPIRDETAILSARRAY = <REVPIRDETAILSARRAY>[];
      json['REVPIRDETAILSARRAY'].forEach((v) {
        rEVPIRDETAILSARRAY!.add(new REVPIRDETAILSARRAY.fromJson(v));
      });
    }
    sTATUS = json['STATUS'];
    tOCID = json['TOCID'];
    rECORDCOUNT = json['RECORDCOUNT'];
    iSREVPENABLED = json['ISREVPENABLED'];
    if (json['REQUIREDFIELDSERROR'] != null) {
      rEQUIREDFIELDSERROR = <String>[];
      json['REQUIREDFIELDSERROR'].forEach((v) {
        rEQUIREDFIELDSERROR!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rEVPIRDETAILSARRAY != null) {
      data['REVPIRDETAILSARRAY'] =
          this.rEVPIRDETAILSARRAY!.map((v) => v.toJson()).toList();
    }
    data['STATUS'] = this.sTATUS;
    data['TOCID'] = this.tOCID;
    data['RECORDCOUNT'] = this.rECORDCOUNT;
    data['ISREVPENABLED'] = this.iSREVPENABLED;
    if (this.rEQUIREDFIELDSERROR != null) {
      data['REQUIREDFIELDSERROR'] =
          this.rEQUIREDFIELDSERROR!.map((v) => v).toList();
    }
    return data;
  }
}

class REVPIRDETAILSARRAY {
  String? emailAddress;
  String? preConfermationMessage;
  String? confermationMessage;
  String? tOCID;
  String? iD;

  REVPIRDETAILSARRAY(
      {this.emailAddress,
      this.preConfermationMessage,
      this.confermationMessage,
      this.tOCID,
      this.iD});

  REVPIRDETAILSARRAY.fromJson(Map<String, dynamic> json) {
    emailAddress = json['EmailAddress'];
    preConfermationMessage = json['PreConfermationMessage'];
    confermationMessage = json['ConfermationMessage'];
    tOCID = json['TOC_ID'];
    iD = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmailAddress'] = this.emailAddress;
    data['PreConfermationMessage'] = this.preConfermationMessage;
    data['ConfermationMessage'] = this.confermationMessage;
    data['TOC_ID'] = this.tOCID;
    data['ID'] = this.iD;
    return data;
  }
}
