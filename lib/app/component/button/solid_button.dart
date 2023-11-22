import 'package:flutter/material.dart';
import 'package:scan_qr_code/app/extensions/colors.dart';
import 'package:scan_qr_code/app/extensions/context.dart';
import 'package:scan_qr_code/app/extensions/spaces.dart';

enum AppSolidButtonRadius { rounded, circle }

class AppSolidButton extends StatelessWidget {
  const AppSolidButton._({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.onHighlightChanged,
    this.mouseCursor,
    this.textTheme,
    this.textColor = colorWhite,
    this.disabledTextColor = colorWhite,
    this.color,
    this.disabledColor,
    this.splashColor = colorPrimary05,
    this.focusColor = colorPrimary05,
    this.hoverColor = colorPrimary05,
    this.highlightColor = colorPrimary05,
    this.colorBrightness,
    this.elevation = _defaultElevation,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    this.padding = _defaultPadding,
    this.visualDensity,
    this.shape = _defaultShape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.animationDuration,
    this.minWidth,
    this.height,
    this.enableFeedback = true,
    this.child,
  });

  factory AppSolidButton.small(
    String text, {
    Widget? leading,
    AppSolidButtonRadius radiusType = AppSolidButtonRadius.circle,
    Widget? rear,
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHighlightChanged,
    FocusNode? focusNode,
    bool autofocus = false,
    Duration? animationDuration,
    Color? color,
    Color? disabledColor,
    MaterialTapTargetSize? materialTapTargetSize,
    double? minWidth,
    double? minHeight,
    bool enableFeedback = true,
  }) {
    double radius;
    if (radiusType == AppSolidButtonRadius.circle) {
      radius = 16;
    } else {
      radius = 8;
    }
    return AppSolidButton._(
      key: key,
      onPressed: onPressed,
      color: color,
      onLongPress: onLongPress,
      onHighlightChanged: onHighlightChanged,
      focusNode: focusNode,
      autofocus: autofocus,
      disabledColor: disabledColor,
      materialTapTargetSize: materialTapTargetSize,
      animationDuration: animationDuration,
      minWidth: minWidth ?? 100,
      height: minHeight ?? 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      enableFeedback: enableFeedback,
      child: _defaultContent(
        text,
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        leading: leading,
        rear: rear,
      ),
    );
  }

  factory AppSolidButton.medium(
    String text, {
    Widget? leading,
    AppSolidButtonRadius radiusType = AppSolidButtonRadius.circle,
    Widget? rear,
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHighlightChanged,
    MouseCursor? mouseCursor,
    ButtonTextTheme? textTheme,
    FocusNode? focusNode,
    bool autofocus = false,
    Duration? animationDuration,
    Color? color,
    Color? disabledColor,
    Color? textColor,
    MaterialTapTargetSize? materialTapTargetSize,
    double? minWidth,
    bool enableFeedback = true,
  }) {
    double radius;
    if (radiusType == AppSolidButtonRadius.circle) {
      radius = 24;
    } else {
      radius = 16;
    }
    return AppSolidButton._(
      key: key,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      color: color,
      disabledColor: disabledColor,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHighlightChanged: onHighlightChanged,
      mouseCursor: mouseCursor,
      textTheme: textTheme,
      focusNode: focusNode,
      padding: const EdgeInsets.all(12),
      autofocus: autofocus,
      materialTapTargetSize: materialTapTargetSize,
      animationDuration: animationDuration,
      minWidth: minWidth,
      height: 48,
      enableFeedback: enableFeedback,
      child: _defaultContent(
        text,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 24 / 16,
        ),
        leading: leading,
        rear: rear,
      ),
    );
  }

  // factory
  static Widget _defaultLabel(String text, TextStyle textStyle) => Text(
        text,
        style: textStyle,
      );

  static Widget _defaultContent(
    String text, {
    required TextStyle textStyle,
    Widget? leading,
    Widget? rear,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        leading ?? space0,
        () {
          if (leading != null) {
            return spaceW4;
          } else {
            return space0;
          }
        }(),
        _defaultLabel(text, textStyle),
        () {
          if (rear != null) {
            return spaceW4;
          } else {
            return space0;
          }
        }(),
        rear ?? space0,
      ],
    );
  }

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHighlightChanged;
  final MouseCursor? mouseCursor;
  final ButtonTextTheme? textTheme;
  final Color? textColor;
  final Color? disabledTextColor;
  final Color? color;
  final Color? disabledColor;
  final Color? splashColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final double? elevation;
  final double? hoverElevation;
  final double? focusElevation;
  final double? highlightElevation;
  final double? disabledElevation;
  final Brightness? colorBrightness;
  final Widget? child;

  bool get enabled => onPressed != null || onLongPress != null;
  final EdgeInsetsGeometry? padding;
  final VisualDensity? visualDensity;
  final ShapeBorder? shape;
  final Clip clipBehavior;
  final FocusNode? focusNode;
  final bool autofocus;
  final Duration? animationDuration;
  final MaterialTapTargetSize? materialTapTargetSize;
  final double? minWidth;
  final double? height;

  final bool enableFeedback;

  @override
  Widget build(BuildContext context) {
    final primarColor = color ?? context.colorScheme.primary;

    return MaterialButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHighlightChanged: onHighlightChanged,
      mouseCursor: mouseCursor,
      textTheme: textTheme,
      textColor: () {
        final brightness = MediaQuery.of(context).platformBrightness;

        switch (brightness) {
          case Brightness.dark:
            return colorBlack;
          case Brightness.light:
            return colorWhite;
        }
      }(),
      disabledTextColor: disabledTextColor,
      color: enabled ? primarColor : primarColor.withOpacity(0.5),
      disabledColor:
          disabledColor ?? context.theme.primaryColor.withOpacity(0.5),
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      colorBrightness: colorBrightness,
      elevation: elevation,
      focusElevation: focusElevation,
      hoverElevation: hoverElevation,
      highlightElevation: highlightElevation,
      disabledElevation: disabledElevation,
      padding: padding,
      visualDensity: visualDensity,
      shape: shape,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      autofocus: autofocus,
      materialTapTargetSize: materialTapTargetSize,
      animationDuration: animationDuration,
      minWidth: minWidth,
      height: height,
      enableFeedback: enableFeedback,
      child: child,
    );
  }

  static const EdgeInsetsGeometry _defaultPadding = EdgeInsets.all(8);

  static const RoundedRectangleBorder _defaultShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
  );

  static const double _defaultElevation = 0;
}
