class StationsModel {
  String? id;
  String? name;
  String? crm;
  String? nlc;

  StationsModel({this.id, this.name, this.crm, this.nlc});

  factory StationsModel.fromJson(Map<String, dynamic> json) {
    return StationsModel(
      id: json["id"],
      name: json["name"],
      crm: json["crm"],
      nlc: json["nlc"],
    );
  }
}
