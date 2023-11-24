import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scan_qr_code/app/gen/assets.gen.dart';

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

  SvgGenImage get getIcon {
    switch (this) {
      case BarcodeType.email:
        return Assets.icons.icEmail;
      case BarcodeType.phone:
        return Assets.icons.icPhone;
      case BarcodeType.sms:
        return Assets.icons.icSms;
      case BarcodeType.url:
        return Assets.icons.icUrl;
      case BarcodeType.wifi:
        return Assets.icons.icWifi;
      case BarcodeType.text:
        return Assets.icons.icText;
      default:
        return Assets.icons.icText;
    }
  }
}
