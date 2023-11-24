import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scan_qr_code/domain/entities/qr_code_data_entity.dart';
import 'package:scan_qr_code/domain/entities/scan_entity.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/models/app_qr_code_data.dart';

part 'app_scan_data.freezed.dart';

@freezed
class AppScanData with _$AppScanData {
  factory AppScanData({
    required String id,
    required String scanType,
    required DateTime createdAt,
    required AppQrCodeData data,
  }) = _AppScanData;

  factory AppScanData.fromEntity(ScanEntity entity) {
    late AppQrCodeData data;
    entity.qrData.map(
      email: (email) {
        data = AppQrCodeData.email(
          address: email.address,
          body: email.body,
          subject: email.subject,
        );
      },
      phone: (phone) {
        data = AppQrCodeData.phone(
          number: phone.number,
        );
      },
      sms: (sms) {
        data = AppQrCodeData.sms(
          message: sms.message,
          phoneNumber: sms.phoneNumber,
        );
      },
      urlBookmark: (urlBookmark) {
        data = AppQrCodeData.urlBookmark(
          title: urlBookmark.title,
          url: urlBookmark.url,
        );
      },
      wifi: (wifi) {
        data = AppQrCodeData.wifi(
          encryptionType: wifi.encryptionType,
          ssid: wifi.ssid,
          password: wifi.password,
        );
      },
      text: (text) {
        data = AppQrCodeData.text(
          text: text.text,
        );
      },
    );
    return AppScanData(
      id: entity.id,
      scanType: entity.scanType,
      createdAt: entity.createdAt,
      data: data,
    );
  }
}

extension AppScanDataExtension on AppScanData {
  ScanEntity toEntity() {
    return ScanEntity(
      id: id,
      scanType: scanType,
      createdAt: createdAt,
      qrData: data.map(
        email: (value) => QrCodeDataEntity.email(
          address: value.address ?? '',
          body: value.body ?? '',
          subject: value.subject ?? '',
        ),
        phone: (value) => QrCodeDataEntity.phone(
          number: value.number ?? '',
        ),
        sms: (value) => QrCodeDataEntity.sms(
          message: value.message ?? '',
          phoneNumber: value.phoneNumber,
        ),
        urlBookmark: (value) => QrCodeDataEntity.urlBookmark(
          title: value.title ?? '',
          url: value.url,
        ),
        wifi: (value) => QrCodeDataEntity.wifi(
          encryptionType: value.encryptionType,
          ssid: value.ssid ?? '',
          password: value.password ?? '',
        ),
        text: (value) => QrCodeDataEntity.text(
          text: value.text ?? '',
        ),
      ),
    );
  }
}
