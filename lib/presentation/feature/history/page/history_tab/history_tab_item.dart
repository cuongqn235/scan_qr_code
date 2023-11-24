import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scan_qr_code/app/extensions/context.dart';
import 'package:scan_qr_code/app/extensions/spaces.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/models/app_qr_code_data.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/models/app_scan_data.dart';

class HistoryTabItem extends StatelessWidget {
  const HistoryTabItem({super.key, required this.scanData});
  final AppScanData scanData;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: HistoryTabItemBody(
              data: scanData.data,
            ),
          ),
          spaceW8,
          HistoryTabItemIcon(
            data: scanData.data,
          ),
        ],
      ),
    );
  }
}

class HistoryTabItemBody extends StatelessWidget {
  const HistoryTabItemBody({super.key, required this.data});
  final AppQrCodeData data;
  @override
  Widget build(BuildContext context) {
    return data.map(
        email: (value) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(value.address ?? 'Chưa có dữ liệu'),
                spaceH4,
                Text(value.body ?? 'Chưa có dữ liệu'),
                spaceH4,
                Text(value.subject ?? 'Chưa có dữ liệu'),
              ],
            ),
        phone: (value) => const Icon(Icons.phone_enabled_outlined),
        sms: (value) => const Icon(Icons.sms_outlined),
        urlBookmark: (value) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(value.url,
                    style: context.textTheme.bodyMedium?.copyWith(
                      decoration: TextDecoration.underline,
                    )),
                spaceH4,
                Text(value.title ?? 'Chưa có dữ liệu'),
              ],
            ),
        wifi: (value) => const Icon(Icons.wifi_2_bar_outlined),
        text: (value) => const SizedBox.shrink());
  }
}

class HistoryTabItemIcon extends StatelessWidget {
  const HistoryTabItemIcon({super.key, required this.data});
  final AppQrCodeData data;
  @override
  Widget build(BuildContext context) {
    return data.map(
        email: (value) => const Icon(Icons.email_outlined),
        phone: (value) => const Icon(Icons.phone_enabled_outlined),
        sms: (value) => const Icon(Icons.sms_outlined),
        urlBookmark: (value) => const Icon(Icons.link),
        wifi: (value) => const Icon(Icons.wifi_2_bar_outlined),
        text: (value) => const SizedBox.shrink());
  }
}
