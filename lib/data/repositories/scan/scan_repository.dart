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
      isAdmin: entity.isAdmin ? 1 : 0,
      createdAt: entity.createdAt,
      qrData: entity.qrData.toValue,
    );
    await _scanDao.save(
      model,
    );
  }

  @override
  Future<List<ScanEntity>> getAllScan(bool? input) async {
    late List<ScanModel> res;
    if (input == null) {
      res = await _scanDao.findAll();
    } else {
      res = await _scanDao.fetchScanModelByIsAdmin(input);
    }
    final scanEntities = res.map(ScanEntity.fromModel).toList();
    return scanEntities;
  }
}
