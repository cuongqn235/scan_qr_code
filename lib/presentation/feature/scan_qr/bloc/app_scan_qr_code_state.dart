import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scan_qr_code/app/common/application/base_state.dart';
import 'package:scan_qr_code/app/common/model/status.dart';

part 'app_scan_qr_code_state.freezed.dart';

@freezed
class AppScanQrCodeState with _$AppScanQrCodeState implements BaseState {
  const factory AppScanQrCodeState({
    @Default(Status.idle()) Status status,
    @Default(false) bool correctFormat,
    ScanQrCodeData? scanQrCodeData,
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
