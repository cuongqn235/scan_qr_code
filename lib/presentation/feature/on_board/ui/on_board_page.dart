import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scan_qr_code/app/component/button/solid_button.dart';
import 'package:scan_qr_code/app/extensions/colors.dart';
import 'package:scan_qr_code/app/extensions/context.dart';
import 'package:scan_qr_code/app/extensions/spaces.dart';
import 'package:scan_qr_code/app/gen/assets.gen.dart';
import 'package:scan_qr_code/presentation/bloc/app_bloc.dart';

class OnBoardPage extends StatelessWidget {
  const OnBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: () {
                  final brightness = MediaQuery.of(context).platformBrightness;
                  switch (brightness) {
                    case Brightness.dark:
                      return Assets.images.splashDark.image(
                        width: 200.r,
                        height: 200.r,
                      );
                    case Brightness.light:
                      return Assets.images.splashLight.image(
                        width: 200.r,
                        height: 200.r,
                      );
                  }
                }(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'GoAndEnjoyOurFeaturesForFreeAndMakeYourLifeEasyWithUs',
                textAlign: TextAlign.center,
                style:
                    context.textTheme.bodyMedium?.copyWith(color: colorWhite),
              ).tr(),
            ),
            spaceH16,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: AppSolidButton.medium(
                'LetUsStart'.tr(),
                onPressed: () {
                  context.read<AppBloc>().add(AppEventEndOnboard());
                  // context.navigator.pushHome();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
