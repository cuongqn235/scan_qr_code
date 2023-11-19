import 'package:injectable/injectable.dart';
import 'package:scan_qr_code/data/models/scan/scan_model.dart';
import 'package:scan_qr_code/data/providers/local/dao/base_dao.dart';

@singleton
class ScanDao extends AppBaseDaoImpl<ScanModel> {
  ScanDao({
    required super.sqlite,
  }) : super(tableName: ScanModel.table);
  @override
  ScanModel jsonToEntity(Map<String, Object?> json) {
    return ScanModel.fromJson(json);
  }

  Future<ScanModel?> fetchScanModel(String id) async {
    final result = await sqlite.rawQuery(
      'SELECT * FROM $tableName WHERE id = ?',
      [id],
    );
    final entities = result.map(jsonToEntity).toList();
    if (entities.isEmpty) {
      return null;
    }
    return entities.first;
  }
}
