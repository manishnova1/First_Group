class affectedTOC {
  List<REVPTOCLISTARRAY>? rEVPTOCLISTARRAY;
  int? sTATUS;
  String? tOCID;
  int? rECORDCOUNT;
  bool? iSREVPENABLED;
  List<String>? rEQUIREDFIELDSERROR;

  affectedTOC(
      {this.rEVPTOCLISTARRAY,
      this.sTATUS,
      this.tOCID,
      this.rECORDCOUNT,
      this.iSREVPENABLED,
      this.rEQUIREDFIELDSERROR});

  affectedTOC.fromJson(Map<String, dynamic> json) {
    if (json['REVPTOCLISTARRAY'] != null) {
      rEVPTOCLISTARRAY = <REVPTOCLISTARRAY>[];
      json['REVPTOCLISTARRAY'].forEach((v) {
        rEVPTOCLISTARRAY!.add(new REVPTOCLISTARRAY.fromJson(v));
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
    if (this.rEVPTOCLISTARRAY != null) {
      data['REVPTOCLISTARRAY'] =
          this.rEVPTOCLISTARRAY!.map((v) => v.toJson()).toList();
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

class REVPTOCLISTARRAY {
  String? tocName;

  REVPTOCLISTARRAY({this.tocName});

  REVPTOCLISTARRAY.fromJson(Map<String, dynamic> json) {
    tocName = json['toc_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['toc_name'] = this.tocName;
    return data;
  }
}
