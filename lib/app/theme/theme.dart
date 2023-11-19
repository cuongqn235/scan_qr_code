import 'package:flutter/material.dart';
import 'package:scan_qr_code/app/extensions/colors.dart';
import 'package:scan_qr_code/app/extensions/context.dart';
import 'package:scan_qr_code/app/extensions/typography.dart';
import 'package:scan_qr_code/app/theme/color_scheme.dart';
import 'package:scan_qr_code/app/theme/input_decoration_theme.dart';

class AppTheme {
  static DividerThemeData get _customDividerThemeData => const DividerThemeData(
        thickness: 1,
        space: 1,
        color: Color(0xFFEFF1EF),
      );

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: colorWhite,
        // fontFamily: FontFamily.nunitoSans,
        colorScheme: appLightColorScheme,
        inputDecorationTheme: inputDecorationTheme,
        textTheme: customizeTextTheme(colorBlack),
        dividerTheme: _customDividerThemeData,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: appLightColorScheme.primary,
          foregroundColor: colorWhite,
        ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          iconTheme: IconThemeData(
            color: appLightColorScheme.primary,
          ),
          titleTextStyle: context.textTheme.titleLarge
              ?.copyWith(color: appLightColorScheme.primary),
          color: appLightColorScheme.surface,
          elevation: 0,
        ),
        chipTheme: const ChipThemeData(
          side: BorderSide.none,
        ));
  }

  static ThemeData darkTheme(
    BuildContext context,
  ) {
    return ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        // fontFamily: FontFamily.nunitoSans,
        scaffoldBackgroundColor: const Color(0xff121212),
        colorScheme: appDarkColorScheme,
        inputDecorationTheme: inputDecorationTheme,
        textTheme: customizeTextTheme(colorWhite),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: appDarkColorScheme.primary,
          foregroundColor: colorWhite,
        ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          iconTheme: IconThemeData(
            color: appDarkColorScheme.primary,
          ),
          titleTextStyle: context.textTheme.titleLarge
              ?.copyWith(color: appDarkColorScheme.primary),
          color: appDarkColorScheme.surface,
        ));
  }
}
