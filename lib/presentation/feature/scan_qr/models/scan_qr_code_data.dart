import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_qr_code_data.freezed.dart';

@freezed
class ScanQrCodeData with _$ScanQrCodeData {
  factory ScanQrCodeData.email({
    String? address,
    String? body,
    String? subject,
  }) = _ScanQrCodeDataEmail;

  factory ScanQrCodeData.phone({
    String? number,
  }) = _ScanQrCodeDataPhone;

  factory ScanQrCodeData.sms({
    String? message,
    required String phoneNumber,
  }) = _ScanQrCodeDataSms;

  factory ScanQrCodeData.urlBookmark({
    String? title,
    required String url,
  }) = _ScanQrCodeDataUrlBookmark;

  factory ScanQrCodeData.wifi({
    int? encryptionType,
    String? ssid,
    String? password,
  }) = _ScanQrCodeDataWifi;
  factory ScanQrCodeData.text({
    String? text,
  }) = _ScanQrCodeDataText;
}
