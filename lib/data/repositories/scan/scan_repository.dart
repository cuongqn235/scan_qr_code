import 'package:injectable/injectable.dart';
import 'package:scan_qr_code/data/models/scan/scan_dao.dart';
import 'package:scan_qr_code/data/models/scan/scan_model.dart';
import 'package:scan_qr_code/domain/entities/qr_code_data_entity.dart';
import 'package:scan_qr_code/domain/entities/scan_entity.dart';
import 'package:scan_qr_code/domain/repositories/scan/i_scan_repository.dart';

@LazySingleton(as: IScanRepository)
class ScanRepository implements IScanRepository {
  final ScanDao _scanDao;
  ScanRepository(this._scanDao);

  @override
  Future<void> addScan(ScanEntity entity) async {
    final model = ScanModel(
      id: entity.id,
      scanType: entity.scanType,
      createdAt: entity.createdAt,
      qrData: entity.qrData.toValue,
    );
    await _scanDao.save(
      model,
    );
  }

  @override
  Future<List<ScanEntity>> getAllScan() async {
    final res = await _scanDao.findAll();
    final scanEntities = res.map(ScanEntity.fromModel).toList();
    return scanEntities;
  }
}
