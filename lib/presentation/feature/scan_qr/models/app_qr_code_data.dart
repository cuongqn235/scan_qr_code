import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scan_qr_code/domain/entities/qr_code_data_entity.dart';

part 'app_qr_code_data.freezed.dart';

@freezed
class AppQrCodeData with _$AppQrCodeData {
  factory AppQrCodeData.email({
    String? address,
    String? body,
    String? subject,
  }) = _AppQrCodeDataEmail;

  factory AppQrCodeData.phone({
    String? number,
  }) = _AppQrCodeDataPhone;

  factory AppQrCodeData.sms({
    String? message,
    required String phoneNumber,
  }) = _AppQrCodeDataSms;

  factory AppQrCodeData.urlBookmark({
    String? title,
    required String url,
  }) = _AppQrCodeDataUrlBookmark;

  factory AppQrCodeData.wifi({
    int? encryptionType,
    String? ssid,
    String? password,
  }) = _AppQrCodeDataWifi;
  factory AppQrCodeData.text({
    String? text,
  }) = _AppQrCodeDataText;
}

extension AppQrCodeDataMapper on AppQrCodeData {
  QrCodeDataEntity toEntity() {
    return map(
      email: (email) {
        return QrCodeDataEntity.email(
          address: email.address ?? '',
          body: email.body ?? '',
          subject: email.subject ?? '',
        );
      },
      phone: (phone) {
        return QrCodeDataEntity.phone(
          number: phone.number ?? '',
        );
      },
      sms: (sms) {
        return QrCodeDataEntity.sms(
          message: sms.message ?? '',
          phoneNumber: sms.phoneNumber,
        );
      },
      urlBookmark: (urlBookmark) {
        return QrCodeDataEntity.urlBookmark(
          title: urlBookmark.title ?? '',
          url: urlBookmark.url,
        );
      },
      wifi: (wifi) {
        return QrCodeDataEntity.wifi(
          encryptionType: wifi.encryptionType,
          ssid: wifi.ssid ?? '',
          password: wifi.password ?? '',
        );
      },
      text: (text) {
        return QrCodeDataEntity.text(
          text: text.text ?? '',
        );
      },
    );
  }
}
