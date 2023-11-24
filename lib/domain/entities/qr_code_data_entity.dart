import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scan_qr_code/app/util/string.dart';

part 'qr_code_data_entity.freezed.dart';
part 'qr_code_data_entity.g.dart';

@Freezed(
  toJson: true,
  fromJson: true,
  copyWith: true,
)
class QrCodeDataEntity with _$QrCodeDataEntity {
  factory QrCodeDataEntity.email({
    @Default('') String address,
    @Default('') String body,
    @Default('') String subject,
  }) = _QrCodeDataEntityEmail;

  factory QrCodeDataEntity.phone({
    @Default('') String number,
  }) = _QrCodeDataEntityPhone;

  factory QrCodeDataEntity.sms({
    @Default('') String message,
    required String phoneNumber,
  }) = _QrCodeDataEntitySms;

  factory QrCodeDataEntity.urlBookmark({
    @Default('') String title,
    required String url,
  }) = _QrCodeDataEntityUrlBookmark;

  factory QrCodeDataEntity.wifi({
    int? encryptionType,
    @Default('') String ssid,
    @Default('') String password,
  }) = _QrCodeDataEntityWifi;

  factory QrCodeDataEntity.text({
    @Default('') String text,
  }) = _QrCodeDataEntityText;
}

extension QrCodeDataEntityMapper on QrCodeDataEntity {
  String get toValue => when(
        email: (address, body, subject) =>
            '${address.toBase64}|${body.toBase64}|${subject.toBase64}',
        phone: (number) => number.toBase64,
        sms: (message, phoneNumber) =>
            '${message.toBase64}|${phoneNumber.toBase64}',
        urlBookmark: (title, url) => '${title.toBase64}|${url.toBase64}',
        wifi: (encryptionType, ssid, password) =>
            '${encryptionType.toString().toBase64}|${ssid.toBase64}|${password.toBase64}',
        text: (text) => text.toBase64,
      );
}
