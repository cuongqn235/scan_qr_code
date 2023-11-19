import 'package:injectable/injectable.dart';
import 'package:scan_qr_code/data/models/scan/scan_dao.dart';
import 'package:scan_qr_code/domain/repositories/scan/i_scan_repository.dart';

@LazySingleton(as: IScanRepository)
class ScanRepository implements IScanRepository {
  final ScanDao _ScanDao;
  ScanRepository(this._ScanDao);
}
