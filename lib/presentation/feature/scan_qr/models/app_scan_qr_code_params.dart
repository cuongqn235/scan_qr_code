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
}
