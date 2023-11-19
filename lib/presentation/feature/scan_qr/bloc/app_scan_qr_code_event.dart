abstract class AppScanQrCodeEvent {}

class CaptureScanQrcode extends AppScanQrCodeEvent {
  CaptureScanQrcode(this.qrCode);

  String qrCode;
}
