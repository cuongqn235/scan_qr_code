import 'package:scan_qr_code/domain/entities/scan_entity.dart';

abstract class IScanRepository {
  Future<void> addScan(ScanEntity entity);
  Future<List<ScanEntity>> getAllScan();
}
