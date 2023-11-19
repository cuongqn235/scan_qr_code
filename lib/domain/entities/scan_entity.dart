import 'package:scan_qr_code/data/models/scan/scan_model.dart';

class JokeEntity {
  JokeEntity({
    required this.id,
    required this.qrCodeData,
    required this.createdAt,
  });
  final int id;
  final String qrCodeData;
  final DateTime createdAt;
  factory JokeEntity.fromModel(ScanModel model) {
    return JokeEntity(
      id: model.id!,
      qrCodeData: model.qrCodeData,
      createdAt: model.createdAt,
    );
  }
}
