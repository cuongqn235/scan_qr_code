import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'inject_dependency.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<void> configureDependencies() => init(getIt);
