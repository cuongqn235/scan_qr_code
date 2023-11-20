import 'package:flutter/material.dart';
import 'package:scan_qr_code/app/gen/assets.gen.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      // backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Center(
          child: _IconAnimation(
            iconSize: 150,
          ),
        ),
      ),
    );
  }
}

class _IconAnimation extends StatefulWidget {
  final double iconSize;
  const _IconAnimation({super.key, required this.iconSize});

  @override
  State<_IconAnimation> createState() => __IconAnimationState();
}

class __IconAnimationState extends State<_IconAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> aniamtion;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    aniamtion = CurvedAnimation(parent: controller, curve: Curves.elasticOut);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.forward();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: aniamtion,
      child: () {
        final brightness = MediaQuery.of(context).platformBrightness;
        switch (brightness) {
          case Brightness.dark:
            return Assets.images.splashDark.image(
              width: widget.iconSize,
              height: widget.iconSize,
            );
          case Brightness.light:
            return Assets.images.splashLight.image(
              width: widget.iconSize,
              height: widget.iconSize,
            );
        }
      }(),
    );
  }
}
