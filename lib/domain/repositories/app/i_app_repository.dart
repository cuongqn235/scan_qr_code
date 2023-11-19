abstract class IAppRepository {
  bool get isFirstLaunch;
  Future<void> saveFirstLaunch();

  Future<void> clearAllData();
}
