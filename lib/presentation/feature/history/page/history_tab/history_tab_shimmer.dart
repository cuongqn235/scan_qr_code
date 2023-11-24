import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scan_qr_code/app/component/shimmer/shimmer_effect.dart';
import 'package:scan_qr_code/app/extensions/colors.dart';
import 'package:scan_qr_code/app/extensions/context.dart';
import 'package:scan_qr_code/app/extensions/spaces.dart';

class HistoryTabShimmer extends StatelessWidget {
  const HistoryTabShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 44),
      child: Column(
        children: [
          spaceH16,
          _buildItem(context),
          spaceH16,
          _buildItem(context),
          spaceH16,
          _buildItem(context),
          spaceH16,
          _buildItem(context),
          spaceH16,
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context) {
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerEffect(
                    child: ColoredBox(
                  color: colorWhite,
                  child: Text('Chưa có dữ liệu'),
                )),
                spaceH4,
                const ShimmerEffect(
                  child: ColoredBox(
                    color: colorWhite,
                    child: Text('Chưa có dữ liệu'),
                  ),
                ),
              ],
            ),
          ),
          spaceW8,
          const ShimmerEffect(
              child: Icon(
            Icons.sms_outlined,
            color: colorWhite,
          )),
        ],
      ),
    );
  }
}
