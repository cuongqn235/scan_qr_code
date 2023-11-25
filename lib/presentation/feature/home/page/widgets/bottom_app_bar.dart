import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scan_qr_code/app/component/icon_animation.dart';
import 'package:scan_qr_code/app/extensions/context.dart';
import 'package:scan_qr_code/presentation/feature/home/page/widgets/qr_code_dialog.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/models/app_scan_qr_code_params.dart';

class AppBottomAppBar extends StatelessWidget {
  const AppBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x99000000),
            blurRadius: 46,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 8.w,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Fluttertoast.showToast(
                          msg: 'ComingSoon'.tr(),
                          toastLength: Toast.LENGTH_SHORT,
                        );
                      },
                      child: Column(
                        children: [
                          const Icon(Icons.qr_code_2_outlined),
                          const Text(
                            'Generate',
                          ).tr(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 8.w,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        context.navigator.pushHistory();
                      },
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.enced,
                        children: [
                          const Icon(Icons.history),
                          const Text(
                            'History',
                          ).tr(),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: -35.r,
            child: GestureDetector(
              onTap: () async {
                final res = await context.navigator.pushScanQrcode(
                  AppScanQrCodeParams.none(),
                );
                if (context.mounted && res != null) {
                  await QrCodeDialog.open(context, data: res);
                }
              },
              child: Container(
                width: 70.r,
                height: 70.r,
                padding: EdgeInsets.all(12.r),
                decoration: ShapeDecoration(
                  color: context.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(44),
                  ),
                ),
                child: IconAnimation(
                  iconSize: 70.r,
                  isDisableAnimation: true,
                  isSwitch: true,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
