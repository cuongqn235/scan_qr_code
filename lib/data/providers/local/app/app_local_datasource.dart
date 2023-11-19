import 'package:injectable/injectable.dart';
import 'package:scan_qr_code/data/providers/local/app/i_app_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: IAppLocalDatasource)
class AppLocalDatasource implements IAppLocalDatasource {
  final String _irstLaunch = 'FIRST_LAUCH';
  final SharedPreferences sPres;
  AppLocalDatasource(this.sPres);
  @override
  bool get isFirstLaunch => sPres.getBool(_irstLaunch) ?? true;

  @override
  Future<void> saveFirstLaunch() async {
    await sPres.setBool(_irstLaunch, false);
  }

  @override
  Future<void> clearAllData() {
    return sPres.clear();
  }
}
