import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scan_qr_code/app/component/popup/permission/common_bottom_popup_permission.dart';
import 'package:scan_qr_code/app/component/popup/permission/popup.dart';
import 'package:scan_qr_code/app/extensions/context.dart';
import 'package:scan_qr_code/app/extensions/spaces.dart';
import 'package:scan_qr_code/app/gen/assets.gen.dart';

class CameraBottomPopupPermission {
  const CameraBottomPopupPermission({
    this.onNegative,
  });
  final VoidCallback? onNegative;
  static Future<void> show(
    BuildContext context, {
    VoidCallback? onNegative,
    bool isDismissible = true,
  }) {
    return showAppModalBottomSheetV3(
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      context: context,
      child: CommonBottomPopupPermission(
        title: 'TitleCameraPermission'.tr(),
        subTitle: 'SubTitleCameraPermission'.tr(),
        tutorial: Column(
          children: [
            Row(
              children: [
                Assets.images.permission.settingsImage.image(
                  width: 32.w,
                  height: 32.h,
                ),
                spaceW8,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'OpenTheApplication'.tr(),
                      style: context.textTheme.bodyLarge,
                      children: [
                        TextSpan(
                          text: ' ${'Setting'.tr()}',
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            spaceH24,
            Row(
              children: [
                Assets.images.permission.privacyImage.image(
                  width: 32.w,
                  height: 32.h,
                ),
                spaceW8,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'Select'.tr(),
                      style: context.textTheme.bodyLarge,
                      children: [
                        TextSpan(
                          text: 'Privacy&Security'.tr(),
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            spaceH24,
            Row(
              children: [
                Assets.images.permission.cameraImage.image(
                  width: 32.w,
                  height: 32.h,
                ),
                spaceW8,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'Select'.tr(),
                      style: context.textTheme.bodyLarge,
                      children: [
                        TextSpan(
                          text: ' "${'Camera'.tr()}"',
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            spaceH24,
            Row(
              children: [
                Assets.images.permission.toggleImage.image(
                  width: 32.w,
                  height: 32.h,
                ),
                spaceW8,
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'SelectApplicationPermission'.tr(),
                      style: context.textTheme.bodyLarge,
                      children: [
                        TextSpan(
                          text: ' Scan QR Code ',
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'CameraAccess'.tr(),
                          style: context.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        onNegative: onNegative,
      ),
    );
  }
}
