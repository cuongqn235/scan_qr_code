import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scan_qr_code/app/component/icon_animation.dart';
import 'package:scan_qr_code/app/extensions/colors.dart';
import 'package:scan_qr_code/app/inject_dependency/inject_dependency.dart';
import 'package:scan_qr_code/presentation/feature/home/bloc/home_bloc.dart';
import 'package:scan_qr_code/presentation/feature/home/page/widgets/bottom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final HomeBloc homeBloc;
  @override
  void initState() {
    super.initState();
    homeBloc = getIt<HomeBloc>()..add(HomeEventOnStart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: Stack(
        children: [
          SizedBox.expand(
            child: ColoredBox(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          SafeArea(
            // bottom: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 200.r,
                      height: 200.r,
                      child: IconAnimation(
                        iconSize: 200.r,
                        isDisableAnimation: true,
                        isDisableScanLine: true,
                        isEnableAnimationScanLine: true,
                      ),
                    ),
                  ),
                ),
                const AppBottomAppBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
