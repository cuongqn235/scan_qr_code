import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scan_qr_code/app/component/icon_animation.dart';
import 'package:scan_qr_code/app/extensions/context.dart';
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
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.qr_code_2_outlined),
                        Text(
                          'Generate',
                        ),
                      ],
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
                      child: const Column(
                        // crossAxisAlignment: CrossAxisAlignment.enced,
                        children: [
                          Icon(Icons.history),
                          Text(
                            'History',
                          ),
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
            child: InkWell(
              onTap: () {
                context.navigator.pushScanQrcode(
                  AppScanQrCodeParams.none(),
                );
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
