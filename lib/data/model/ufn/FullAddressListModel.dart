class FullAddressListModel {
  FullAddressListModel({
    this.addressList,
  });

  FullAddressListModel.fromJson(dynamic json) {
    if (json != null && json.length > 0) {
      addressList = [];
      json.forEach((v) {
        addressList!.add(DataFullAddress.fromJson(v));
      });
    } else {
      addressList = [];
    }
  }

  dynamic addressList;
}

class DataFullAddress {
  DataFullAddress({
    this.postalcode,
    this.line1,
    this.countryname,
    this.provincename,
    this.street,
    this.id,
    this.buildingname,
    this.buildingnumber,
    this.city,
    this.description,
    this.line2,
  });

  DataFullAddress.fromJson(dynamic json) {
    postalcode = json['POSTALCODE'];
    line1 = json['LINE1'];
    countryname = json['COUNTRYNAME'];
    provincename = json['PROVINCENAME'];
    street = json['STREET'];
    id = json['ID'];
    buildingname = json['BUILDINGNAME'];
    buildingnumber = json['BUILDINGNUMBER'];
    city = json['CITY'];
    description = json['DESCRIPTION'];
    line2 = json['LINE2'];
  }

  String? postalcode;
  String? line1;
  String? countryname;
  String? provincename;
  String? street;
  String? id;
  String? buildingname;
  String? buildingnumber;
  String? city;
  String? description;
  String? line2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['POSTALCODE'] = postalcode;
    map['LINE1'] = line1;
    map['COUNTRYNAME'] = countryname;
    map['PROVINCENAME'] = provincename;
    map['STREET'] = street;
    map['ID'] = id;
    map['BUILDINGNAME'] = buildingname;
    map['BUILDINGNUMBER'] = buildingnumber;
    map['CITY'] = city;
    map['DESCRIPTION'] = description;
    map['LINE2'] = line2;
    return map;
  }
}
