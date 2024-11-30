class Revpidentityarray {
  Revpidentityarray({
    this.lastname,
    this.firstname,
    this.middlename,
    this.title,
  });

  Revpidentityarray.fromJson(dynamic json) {
    lastname = json['LASTNAME'];
    firstname = json['FIRSTNAME'];
    middlename = json['MIDDLENAME'];
    title = json['TITLE'];
  }

  String? lastname;
  String? firstname;
  String? middlename;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['LASTNAME'] = lastname;
    map['FIRSTNAME'] = firstname;
    map['MIDDLENAME'] = middlename;
    map['TITLE'] = title;
    return map;
  }
}
