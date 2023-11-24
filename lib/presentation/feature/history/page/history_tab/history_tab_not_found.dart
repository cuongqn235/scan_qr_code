import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scan_qr_code/app/extensions/context.dart';
import 'package:scan_qr_code/app/extensions/spaces.dart';
import 'package:scan_qr_code/app/gen/assets.gen.dart';

class HistoryTabNotFound extends StatelessWidget {
  const HistoryTabNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: !context.isDark,
          child: Assets.images.notFoundLight.image(
            width: (1.sw / 3) * 2,
            height: (1.sw / 3) * 2,
          ),
        ),
        Visibility(
          visible: context.isDark,
          child: Assets.images.notFoundDark.image(
            width: (1.sw / 3) * 2,
            height: (1.sw / 3) * 2,
          ),
        ),
        spaceH8,
        Text(
          'Not found',
          style: context.textTheme.titleMedium,
        ),
      ],
    );
  }
}
