import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_qr_code_entity.freezed.dart';

@freezed
class ScanQrCodeEntity with _$ScanQrCodeEntity {
  factory ScanQrCodeEntity.email({
    String? address,
    String? body,
    String? subject,
  }) = _ScanQrCodeEntityEmail;

  factory ScanQrCodeEntity.phone({
    String? number,
  }) = _ScanQrCodeEntityPhone;

  factory ScanQrCodeEntity.sms({
    String? message,
    required String phoneNumber,
  }) = _ScanQrCodeEntitySms;

  factory ScanQrCodeEntity.urlBookmark({
    String? title,
    required String url,
  }) = _ScanQrCodeEntityUrlBookmark;

  factory ScanQrCodeEntity.wifi({
    int? encryptionType,
    String? ssid,
    String? password,
  }) = _ScanQrCodeEntityWifi;
}
// /// Wifi encryption type constants.
// enum EncryptionType {
//   /// Unknown encryption type.
//   none(0),

//   /// Not encrypted.
//   open(1),

//   /// WPA level encryption.
//   wpa(2),

//   /// WEP level encryption.
//   wep(3);

//   const EncryptionType(this.rawValue);

//   factory EncryptionType.fromRawValue(int value) {
//     switch (value) {
//       case 0:
//         return EncryptionType.none;
//       case 1:
//         return EncryptionType.open;
//       case 2:
//         return EncryptionType.wpa;
//       case 3:
//         return EncryptionType.wep;
//       default:
//         throw ArgumentError.value(value, 'value', 'Invalid raw value.');
//     }
//   }

//   /// The raw value for the encryption type.
//   final int rawValue;
// }
