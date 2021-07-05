import 'package:json_annotation/json_annotation.dart';

part 'bill_detail.g.dart';

@JsonSerializable()
class BillDetailData {
  String username;
  String email;
  Map<String, dynamic> billing;
  Map<String, dynamic> shipping;

  BillDetailData({this.username, this.email, this.billing, this.shipping});
  factory BillDetailData.fromJson(Map<String, dynamic> json) => _$BillDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$BillDetailDataToJson(this);
}
