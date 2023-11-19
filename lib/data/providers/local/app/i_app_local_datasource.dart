abstract class IAppLocalDatasource {
  bool get isFirstLaunch;
  Future<void> saveFirstLaunch();
  Future<void> clearAllData();
}
