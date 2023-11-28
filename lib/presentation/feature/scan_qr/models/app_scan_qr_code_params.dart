import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_scan_qr_code_params.g.dart';

@JsonSerializable()
class AppScanQrCodeParams {
  final bool isInputLink;
  final bool isWrite;
  const AppScanQrCodeParams._(this.isInputLink, this.isWrite);
  factory AppScanQrCodeParams({
    required bool isInputLink,
    required bool isWrite,
  }) {
    return AppScanQrCodeParams._(isInputLink, isWrite);
  }
  factory AppScanQrCodeParams.none() {
    return const AppScanQrCodeParams._(false, false);
  }

  factory AppScanQrCodeParams.fromJson(Map<String, dynamic> json) =>
      _$AppScanQrCodeParamsFromJson(json);
  Map<String, dynamic> toJson() => _$AppScanQrCodeParamsToJson(this);
}
