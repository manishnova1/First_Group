// class RevpCardType {
//   RevpCardType({
//       this.revprailcardtypearray,
//       this.status,
//       this.tocid,
//       this.recordcount,
//       this.isrevpenabled,
//       this.requiredfieldserror,});
//
//   RevpCardType.fromJson(dynamic json) {
//     if (json['REVPRAILCARDTYPEARRAY'] != null) {
//       revprailcardtypearray = [];
//       json['REVPRAILCARDTYPEARRAY'].forEach((v) {
//         revprailcardtypearray!.add(Revprailcardtypearray.fromJson(v));
//       });
//     }
//     status = json['STATUS'];
//     tocid = json['TOCID'];
//     recordcount = json['RECORDCOUNT'];
//     isrevpenabled = json['ISREVPENABLED'];
//     // if (json['REQUIREDFIELDSERROR'] != null) {
//     //   requiredfieldserror = [];
//     //   json['REQUIREDFIELDSERROR'].forEach((v) {
//     //     requiredfieldserror.add(Dynamic.fromJson(v));
//     //   });
//     // }
//   }
//   List<Revprailcardtypearray>? revprailcardtypearray;
//   int? status;
//   String? tocid;
//   int? recordcount;
//   bool? isrevpenabled;
//   List<dynamic>? requiredfieldserror;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (revprailcardtypearray != null) {
//       map['REVPRAILCARDTYPEARRAY'] = revprailcardtypearray!.map((v) => v.toJson()).toList();
//     }
//     map['STATUS'] = status;
//     map['TOCID'] = tocid;
//     map['RECORDCOUNT'] = recordcount;
//     map['ISREVPENABLED'] = isrevpenabled;
//     if (requiredfieldserror != null) {
//       map['REQUIREDFIELDSERROR'] = requiredfieldserror!.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
//
// class Revprailcardtypearray {
//   Revprailcardtypearray({
//     this.revpRailCardType,
//     this.revpRailCardTypeID,
//     this.revpRailcardID,
//     this.revpRailcard,});
//
//   Revprailcardtypearray.fromJson(dynamic json) {
//     revpRailCardType = json['revpRailCardType'];
//     revpRailCardTypeID = json['revpRailCardTypeID'];
//     revpRailcardID = json['revpRailcardID'];
//     revpRailcard = json['revpRailcard'];
//   }
//   String? revpRailCardType;
//   String? revpRailCardTypeID;
//   String? revpRailcardID;
//   String? revpRailcard;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['revpRailCardType'] = revpRailCardType;
//     map['revpRailCardTypeID'] = revpRailCardTypeID;
//     map['revpRailcardID'] = revpRailcardID;
//     map['revpRailcard'] = revpRailcard;
//     return map;
//   }
//
// }
