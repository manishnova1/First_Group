import 'package:json_annotation/json_annotation.dart';

part 'save_address_search_model.g.dart';

@JsonSerializable()
class SaveAddressSearchModel {
  String? MESSAGE;
  num? STATUS;
  String? TOCID;
  bool? ISREVPENABLED;
  dynamic? REQUIREDFIELDSERROR;

  SaveAddressSearchModel(
      {this.MESSAGE,
      this.STATUS,
      this.TOCID,
      this.ISREVPENABLED,
      this.REQUIREDFIELDSERROR});

  factory SaveAddressSearchModel.fromJson(Map<String, dynamic> json) =>
      _$SaveAddressSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$SaveAddressSearchModelToJson(this);
}
