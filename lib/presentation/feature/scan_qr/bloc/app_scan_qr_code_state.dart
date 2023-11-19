import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_scan_qr_code_state.freezed.dart';

@freezed
class AppScanQrCodeState
// extends AppScreenState
    with
        _$AppScanQrCodeState
// implements INeedLoading
{
  const factory AppScanQrCodeState({
    // @Default(null) UIError? error,
    @Default(false) bool showLoading,
    @Default(false) bool correctFormat,
    ScanQrCodeData? scanQrCodeData,
    // ScanQrCodeData? pasteResult,
    @Default(true) bool isScanable,
    @Default(false) bool isWrite,
  }) = _AppScanQrCodeState;
}

@freezed
class ScanQrCodeData with _$ScanQrCodeData {
  const factory ScanQrCodeData.data({
    // required EstateBasicInfo info,
    required String qrId,
  }) = _ScanQrCodeDataEstateContract;

  // const factory ScanQrCodeData.qrContract({
  //   required EstateBasicInfo? info,
  //   required String qrId,
  // }) = _ScanQrCodeDataQrContract;

  // const factory ScanQrCodeData.estateId({
  //   required String estateId,
  // }) = _ScanQrCodeDataEstateId;

  // const factory ScanQrCodeData.qrId({
  //   String? estateId,
  //   required String qrId,
  // }) = _qrId;

  // const factory ScanQrCodeData.booking({required String qrCode}) = _booking;

  // const factory ScanQrCodeData.other({
  //   required String qrCode,
  // }) = _ScanQrCodeDataEther;

  // const factory ScanQrCodeData.event({
  //   required String eventId,
  // }) = _ScanQrCodeDataEvent;
}
