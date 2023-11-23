part of 'app_scan_qr_code_bloc.dart';

sealed class AppScanQrCodeEvent {}

class CaptureScanQrcode extends AppScanQrCodeEvent {
  CaptureScanQrcode(this.data);
  Barcode data;
}

class AppScanQrCodeEventClearResult extends AppScanQrCodeEvent {}
