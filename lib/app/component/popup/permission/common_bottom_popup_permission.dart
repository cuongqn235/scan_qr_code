import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scan_qr_code/app/component/button/solid_button.dart';
import 'package:scan_qr_code/app/component/popup/permission/popup.dart';
import 'package:scan_qr_code/app/extensions/context.dart';
import 'package:scan_qr_code/app/extensions/spaces.dart';

class CommonBottomPopupPermission extends StatelessWidget {
  const CommonBottomPopupPermission({
    super.key,
    this.onNegative,
    required this.title,
    required this.subTitle,
    this.tutorial,
  });

  final VoidCallback? onNegative;
  final String title;
  final String subTitle;
  final Widget? tutorial;
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String subTitle,
    Widget? tutorial,
    VoidCallback? onNegative,
    bool isDismissible = true,
  }) {
    return showAppModalBottomSheetV3(
      isDismissible: isDismissible,
      context: context,
      child: CommonBottomPopupPermission(
        onNegative: onNegative,
        subTitle: subTitle,
        title: title,
        tutorial: tutorial,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            16.r,
          ),
        ),
        color: context.appColorScheme.backgroundLight,
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: context.textTheme.titleMedium?.copyWith(
                color: context.appColorScheme.titleMediumLight,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            spaceH8,
            Text(
              subTitle,
              style: context.textTheme.bodyMedium?.copyWith(),
              textAlign: TextAlign.center,
            ),
            if (tutorial != null && Platform.isIOS) ...[
              spaceH24,
              tutorial!,
            ],
            spaceH32,
            SizedBox(
              width: double.infinity,
              child: AppSolidButton.medium(
                'Chuyển tới cài đặt',
                onPressed: openAppSettings,
              ),
            ),
            spaceH8,
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onNegative?.call();
                },
                child: Text(
                  'Không đồng ý',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
