import 'package:scan_qr_code/app/util/string.dart';
import 'package:scan_qr_code/data/models/scan/scan_model.dart';
import 'package:scan_qr_code/domain/entities/qr_code_data_entity.dart';

class ScanEntity {
  final String id;
  final String scanType;
  final bool isAdmin;
  final DateTime createdAt;
  final QrCodeDataEntity qrData;

  ScanEntity({
    required this.id,
    required this.scanType,
    required this.isAdmin,
    required this.createdAt,
    required this.qrData,
  });

  factory ScanEntity.fromModel(ScanModel model) {
    late QrCodeDataEntity qrData;
    final qrDate = model.qrData.split('|');
    switch (model.scanType) {
      case 'email':
        qrData = QrCodeDataEntity.email(
          address: qrDate[0].base64Decode,
          body: qrDate[1].base64Decode,
          subject: qrDate[2].base64Decode,
        );
        break;
      case 'phone':
        qrData = QrCodeDataEntity.phone(
          number: qrDate[0].base64Decode,
        );
        break;
      case 'sms':
        qrData = QrCodeDataEntity.sms(
          message: qrDate[0].base64Decode,
          phoneNumber: qrDate[1].base64Decode,
        );
        break;
      case 'urlBookmark':
        qrData = QrCodeDataEntity.urlBookmark(
          title: qrDate[0].base64Decode,
          url: qrDate[1].base64Decode,
        );
        break;
      case 'wifi':
        qrData = QrCodeDataEntity.wifi(
          encryptionType: qrDate[0].base64Decode.isNotEmpty
              ? int.parse(qrDate[0].base64Decode)
              : null,
          ssid: qrDate[1].base64Decode,
          password: qrDate[2].base64Decode,
        );
        break;
      default:
        qrData = QrCodeDataEntity.text(
          text: qrDate[0].base64Decode,
        );
        break;
    }
    return ScanEntity(
      id: model.id,
      scanType: model.scanType,
      isAdmin: model.isAdmin == 1,
      createdAt: model.createdAt,
      qrData: qrData,
    );
  }
}
