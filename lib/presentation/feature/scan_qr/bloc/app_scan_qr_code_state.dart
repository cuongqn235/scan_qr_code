part of 'app_scan_qr_code_bloc.dart';

@freezed
class AppScanQrCodeState with _$AppScanQrCodeState implements BaseState {
  const factory AppScanQrCodeState({
    @Default(Status.idle()) Status status,
    bool? correctFormat,
    AppQrCodeData? data,
    @Default(true) bool isScanable,
    @Default(false) bool isWrite,
  }) = _AppScanQrCodeState;
}
