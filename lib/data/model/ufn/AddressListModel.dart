class AddressListModel {
  AddressListModel({
    this.addressList,
  });

  AddressListModel.fromJson(dynamic json) {
    if (json != null && json.length > 0) {
      addressList = [];
      json.forEach((v) {
        addressList!.add(DataAddress.fromJson(v));
      });
    } else {
      addressList = [];
    }
  }

  dynamic addressList;
}

class DataAddress {
  DataAddress({
    String? descriptionaddress,
    String? id,
    String? type,
    String? postcode,
  }) {
    _descriptionaddress = descriptionaddress;
    _id = id;
    _type = type;
    _postcode = postcode;
  }

  DataAddress.fromJson(dynamic json) {
    _descriptionaddress = json['DESCRIPTIONADDRESS'];
    _id = json['ID'];
    _type = json['TYPE'];
    _postcode = json['POSTCODE'];
  }

  String? _descriptionaddress;
  String? _id;
  String? _type;
  String? _postcode;

  String? get descriptionaddress => _descriptionaddress;

  String? get id => _id;

  String? get type => _type;

  String? get postcode => _postcode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['DESCRIPTIONADDRESS'] = _descriptionaddress;
    map['ID'] = _id;
    map['TYPE'] = _type;
    map['POSTCODE'] = _postcode;
    return map;
  }
}
