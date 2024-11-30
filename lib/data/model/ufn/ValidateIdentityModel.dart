import 'Revpidentityarray.dart';

class ValidateIdentityModel {
  ValidateIdentityModel({
    this.revpidentityarray,
    this.status,
    this.tocid,
    this.recordcount,
    this.isrevpenabled,
    this.requiredfieldserror,
  });

  ValidateIdentityModel.fromJson(dynamic json) {
    if (json['REVPIDENTITYARRAY'] != null) {
      revpidentityarray = [];
      json['REVPIDENTITYARRAY'].forEach((v) {
        revpidentityarray!.add(Revpidentityarray.fromJson(v));
      });
    }
    status = json['STATUS'];
    tocid = json['TOCID'];
    recordcount = json['RECORDCOUNT'];
    isrevpenabled = json['ISREVPENABLED'];
    // if (json['REQUIREDFIELDSERROR'] != null) {
    //   requiredfieldserror = [];
    //   json['REQUIREDFIELDSERROR'].forEach((v) {
    //     requiredfieldserror.add(Dynamic.fromJson(v));
    //   });
    // }
  }

  List<Revpidentityarray>? revpidentityarray;
  int? status;
  String? tocid;
  int? recordcount;
  bool? isrevpenabled;
  dynamic requiredfieldserror;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (revpidentityarray != null) {
      map['REVPIDENTITYARRAY'] =
          revpidentityarray!.map((v) => v.toJson()).toList();
    }
    map['STATUS'] = status;
    map['TOCID'] = tocid;
    map['RECORDCOUNT'] = recordcount;
    map['ISREVPENABLED'] = isrevpenabled;
    if (requiredfieldserror != null) {
      map['REQUIREDFIELDSERROR'] =
          requiredfieldserror.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
