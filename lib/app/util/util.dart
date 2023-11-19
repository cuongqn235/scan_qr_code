class Utils {
  Utils._();
  static List<String> processMigrations(List<String> paths) {
    var result = List<String>.from(paths)
        // Filter valid suffix file
        .where((element) => element.endsWith('.sql'))
        .toList();
    result.sort();
    return result;
  }
}
