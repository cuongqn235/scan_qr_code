import 'package:mobile_scanner/mobile_scanner.dart';

extension BarcodeTypeExtension on BarcodeType {
  String get value {
    switch (this) {
      case BarcodeType.email:
        return 'email';
      case BarcodeType.phone:
        return 'phone';
      case BarcodeType.sms:
        return 'sms';
      case BarcodeType.url:
        return 'urlBookmark';
      case BarcodeType.wifi:
        return 'wifi';
      case BarcodeType.text:
        return 'text';
      default:
        return 'text';
    }
  }

  BarcodeType fromValue(String value) {
    switch (value) {
      case 'email':
        return BarcodeType.email;
      case 'phone':
        return BarcodeType.phone;
      case 'sms':
        return BarcodeType.sms;
      case 'urlBookmark':
        return BarcodeType.url;
      case 'wifi':
        return BarcodeType.wifi;
      case 'text':
        return BarcodeType.text;
      default:
        return BarcodeType.text;
    }
  }
}
