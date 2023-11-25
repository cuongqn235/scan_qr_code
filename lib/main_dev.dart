import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scan_qr_code/app/inject_dependency/inject_dependency.dart';
import 'package:scan_qr_code/presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    configureDependencies(),
    ScreenUtil.ensureScreenSize(),
    EasyLocalization.ensureInitialized(),
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const App(),
    ),
  );
}
