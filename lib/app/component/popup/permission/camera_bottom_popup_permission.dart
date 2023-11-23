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
        title: 'FPHost chưa có quyền truy cập "Camera".',
        subTitle:
            'Cấp quyền truy cập camera để sử dụng tính năng chụp ảnh và quét mã QR',
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
                      text: 'Mở ứng dụng',
                      style: context.textTheme.bodyLarge,
                      children: [
                        TextSpan(
                          text: ' Cài đặt',
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
                      text: 'Chọn',
                      style: context.textTheme.bodyLarge,
                      children: [
                        TextSpan(
                          text: ' “Quyền riêng tư & Bảo mật”',
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
                      text: 'Chọn',
                      style: context.textTheme.bodyLarge,
                      children: [
                        TextSpan(
                          text: ' “Camera”',
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
                      text: 'Chọn phép ứng dụng',
                      style: context.textTheme.bodyLarge,
                      children: [
                        TextSpan(
                          text: ' FPHouse ',
                          style: context.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'truy cập camera',
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
