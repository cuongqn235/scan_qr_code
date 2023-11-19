import 'package:injectable/injectable.dart';
import 'package:scan_qr_code/data/providers/local/app/i_app_local_datasource.dart';

import 'package:scan_qr_code/domain/repositories/app/i_app_repository.dart';

@LazySingleton(as: IAppRepository)
class AppRepository implements IAppRepository {
  final IAppLocalDatasource _appLocalDatasource;
  AppRepository(this._appLocalDatasource);
  @override
  bool get isFirstLaunch => _appLocalDatasource.isFirstLaunch;

  @override
  Future<void> saveFirstLaunch() {
    return _appLocalDatasource.saveFirstLaunch();
  }

  @override
  Future<void> clearAllData() async {
    return _appLocalDatasource.clearAllData();
  }
}
