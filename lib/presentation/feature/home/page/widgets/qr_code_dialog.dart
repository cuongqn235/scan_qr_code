import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scan_qr_code/app/extensions/context.dart';
import 'package:scan_qr_code/presentation/feature/history/page/history_tab/history_tab_item.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/models/app_qr_code_data.dart';

class QrCodeDialog extends StatelessWidget {
  const QrCodeDialog({super.key, required this.data});
  final AppQrCodeData data;
  static Future<void> open(
    BuildContext context, {
    required AppQrCodeData data,
  }) async {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          contentPadding: EdgeInsets.zero,
          alignment: Alignment.center,
          actionsPadding: EdgeInsets.zero,
          actionsOverflowAlignment: OverflowBarAlignment.center,
          content: QrCodeDialog(
            data: data,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HistoryTabItem(
          data: data,
        ),
        TextButton(
          child: Text(
            'Back'.tr(),
            style: context.textTheme.titleSmall
                ?.copyWith(color: context.colorScheme.error),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     TextButton(
        //       child: Text(
        //         'Back',
        //         style: context.textTheme.titleSmall
        //             ?.copyWith(color: context.colorScheme.error),
        //       ),
        //       onPressed: () {
        //         Navigator.of(context).pop();
        //       },
        //     ),
        //     TextButton(
        //       onPressed: () async {
        //         data.maybeMap(
        //             orElse: () => const SizedBox.shrink(),
        //             urlBookmark: (data) {
        //               launchUrl(
        //                 Uri.parse(data.url),
        //               );
        //             });

        //         context.justBack();
        //       },
        //       child: Row(
        //         children: [
        //           Icon(
        //             Icons.link,
        //             size: 32.r,
        //           ),
        //           spaceW8,
        //           Text(
        //             'Open',
        //             style: context.textTheme.titleSmall?.copyWith(
        //               color: context.colorScheme.primary,
        //               fontWeight: bold,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
