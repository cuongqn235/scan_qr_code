import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scan_qr_code/app/extensions/context.dart';
import 'package:scan_qr_code/app/gen/assets.gen.dart';

class IconAnimation extends StatefulWidget {
  final double iconSize;
  final bool isDisableAnimation;
  final bool isSwitch;
  final bool isDisableScanLine;
  final bool isEnableAnimationScanLine;
  const IconAnimation({
    super.key,
    required this.iconSize,
    this.isDisableAnimation = false,
    this.isSwitch = false,
    this.isDisableScanLine = false,
    this.isEnableAnimationScanLine = false,
  });

  @override
  State<IconAnimation> createState() => _IconAnimationState();
}

class _IconAnimationState extends State<IconAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> aniamtion;

  late AnimationController controller2;
  late Animation<double> aniamtion2;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    aniamtion = CurvedAnimation(parent: controller, curve: Curves.elasticOut);

    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    aniamtion2 = Tween(begin: 0.0, end: 1.0).animate(controller2);
    if (widget.isEnableAnimationScanLine) {
      controller2.repeat(reverse: true);
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.forward();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    if (widget.isSwitch) {
      brightness =
          brightness == Brightness.dark ? Brightness.light : Brightness.dark;
    }
    late Widget child;
    switch (brightness) {
      case Brightness.dark:
        child = (widget.isDisableScanLine
                ? Assets.images.icScanDart
                : Assets.images.splashDark)
            .image(
          width: widget.iconSize,
          height: widget.iconSize,
        );
      case Brightness.light:
        child = (widget.isDisableScanLine
                ? Assets.images.icScanLight
                : Assets.images.splashLight)
            .image(
          width: widget.iconSize,
          height: widget.iconSize,
        );
    }
    if (widget.isEnableAnimationScanLine) {
      return AnimatedBuilder(
        animation: aniamtion2,
        builder: (context, w) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                child,
                Positioned(
                  top: () {
                    if (aniamtion2.status == AnimationStatus.reverse) {
                      return aniamtion2.value * widget.iconSize;
                    } else {
                      return aniamtion2.value * widget.iconSize -
                          (widget.iconSize / 3);
                    }
                  }(),
                  left: 0,
                  right: 0,
                  child: Container(
                    height: widget.iconSize / 3,
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      borderRadius: () {
                        if (aniamtion2.status == AnimationStatus.reverse) {
                          return BorderRadius.only(
                              topRight: Radius.circular(8.r),
                              topLeft: Radius.circular(8.r));
                        } else {
                          return BorderRadius.only(
                              bottomLeft: Radius.circular(8.r),
                              bottomRight: Radius.circular(8.r));
                        }
                      }(),
                      gradient: LinearGradient(
                        colors: () {
                          if (aniamtion2.status == AnimationStatus.reverse) {
                            return [
                              context.colorScheme.primary,
                              context.colorScheme.primary.withOpacity(0.2),
                            ];
                          } else {
                            return [
                              context.colorScheme.primary.withOpacity(0.2),
                              context.colorScheme.primary,
                            ];
                          }
                        }(),
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );
    }
    if (widget.isDisableAnimation) {
      return child;
    }

    return ScaleTransition(
      scale: aniamtion,
      child: child,
    );
  }
}
