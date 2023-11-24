import 'package:flutter/material.dart';
import 'package:scan_qr_code/app/extensions/colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({
    super.key,
    this.baseColor = colorGray01,
    this.highlightColor = colorWhite,
    this.height = double.infinity,
    this.width = double.infinity,
    this.shapeBorder = const RoundedRectangleBorder(),
    this.child,
  });

  final Color baseColor;
  final Color highlightColor;
  final double height;
  final double width;
  final ShapeBorder shapeBorder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: child ??
          Container(
            height: height,
            width: width,
            decoration: ShapeDecoration(
              color: baseColor,
              shape: shapeBorder,
            ),
          ),
    );
  }
}
