import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scan_qr_code/app/helper/freezed/freezed_annotation.dart';
import 'package:scan_qr_code/data/providers/local/dao/base_model.dart';

part 'scan_model.freezed.dart';
part 'scan_model.g.dart';

@freezed
class ScanModel extends AppBaseModel with _$ScanModel {
  factory ScanModel({
    required String id,
    required String scanType,
    @DateTimeConverterFromString() required DateTime createdAt,
    required String qrData,
  }) = _ScanModel;

  factory ScanModel.fromJson(Map<String, dynamic> json) =>
      _$ScanModelFromJson(json);

  static const table = 'scan';
}
