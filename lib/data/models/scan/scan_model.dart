import 'package:json_annotation/json_annotation.dart';
import 'package:scan_qr_code/app/helper/freezed/freezed_annotation.dart';
import 'package:scan_qr_code/data/providers/local/dao/base_model.dart';
part 'scan_model.g.dart';

@JsonSerializable()
class ScanModel extends AppBaseModel {
  ScanModel({
    this.id,
    required this.qrCodeData,
    required this.createdAt,
  });
  final int? id;
  final String qrCodeData;
  @DateTimeConverterFromString()
  final DateTime createdAt;

  static const table = 'scan';

  factory ScanModel.fromJson(Map<String, dynamic> json) =>
      _$ScanModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ScanModelToJson(this);
}
