import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scan_qr_code/app/component/icon_animation.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Center(
          child: IconAnimation(
            iconSize: 150.r,
          ),
        ),
      ),
    );
  }
}
