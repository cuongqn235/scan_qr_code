import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scan_qr_code/app/extensions/colors.dart';
import 'package:scan_qr_code/app/extensions/context.dart';
import 'package:scan_qr_code/app/extensions/spaces.dart';
import 'package:scan_qr_code/app/gen/assets.gen.dart';

class TitleBottomSheetWrapper extends StatelessWidget {
  const TitleBottomSheetWrapper({
    super.key,
    this.title,
    required this.child,
    this.onCloseTapped,
    this.subtitle,
    this.isShowHeader,
    this.showBottom,
  });

  final String? title;
  final bool? isShowHeader;
  final Widget child;
  final Widget? subtitle;
  final VoidCallback? onCloseTapped;
  final bool? showBottom;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: showBottom ?? false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 8, top: 16),
            child: Visibility(
              visible: isShowHeader ?? true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title ?? '',
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: context
                                .appColorScheme.colorExtendedTextTitleLarge,
                          ),
                        ),
                        spaceH4,
                        subtitle ?? const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  IconButton(
                    iconSize: 8,
                    onPressed: () {
                      if (onCloseTapped == null) {
                        Navigator.pop(context);
                      } else {
                        onCloseTapped!();
                      }
                    },
                    icon: Assets.icons.icXClose.svg(
                        color:
                            context.appColorScheme.colorExtendedIconActive01),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class TitleBottomSheetDraggableWrapper extends StatelessWidget {
  const TitleBottomSheetDraggableWrapper({
    super.key,
    required this.child,
    this.title,
    this.onCloseTapped,
    this.minChildSize = 0.25,
    this.initialChildSize = 0.5,
    this.maxChildSize = 0.95,
  });

  final VoidCallback? onCloseTapped;
  final String? title;
  final Widget child;
  final double minChildSize;
  final double initialChildSize;
  final double maxChildSize;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: minChildSize,
      initialChildSize: initialChildSize,
      maxChildSize: maxChildSize,
      builder: (c, controller) {
        return _wrapper(
          context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: onCloseTapped != null,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 8,
                    top: 16,
                    bottom: 24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title ?? '',
                        style: context.textTheme.titleLarge,
                      ),
                      IconButton(
                        iconSize: 8,
                        onPressed: () {
                          if (onCloseTapped == null) {
                            Navigator.pop(context);
                          } else {
                            onCloseTapped!();
                          }
                        },
                        icon: Assets.icons.icXClose.svg(
                            color: context
                                .appColorScheme.colorExtendedIconActive01),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const BouncingScrollPhysics(),
                  controller: controller,
                  child: child,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _wrapper(BuildContext context, {required Widget child}) => Container(
      decoration: const BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      width: double.infinity,
      child: child,
    );

class TitleBottomSheetAutoHeightWrapper extends StatelessWidget {
  const TitleBottomSheetAutoHeightWrapper({
    super.key,
    required this.child,
    this.title,
    this.subTitle,
    this.subTitleWidget,
    this.onCloseTapped,
    this.minChildSize = 0.4,
    this.initialChildSize = 0.8,
    this.maxChildSize = 0.95,
    this.isHiddenTitleBar = false,
    this.closeBtn,
    this.minimum = const EdgeInsets.only(bottom: 16),
    this.titlePadding,
  });

  final VoidCallback? onCloseTapped;
  final String? title;
  final String? subTitle;
  final Widget? subTitleWidget;
  final Widget child;
  final double minChildSize;
  final double initialChildSize;
  final double maxChildSize;
  final bool isHiddenTitleBar;
  final Widget? closeBtn;
  final EdgeInsets? minimum;
  final double? titlePadding;
  @override
  Widget build(BuildContext context) {
    return _wrapper(
      context,
      child: SafeArea(
        minimum: minimum ?? const EdgeInsets.only(bottom: 16),
        child: Flex(
          mainAxisSize: MainAxisSize.min,
          direction: Axis.vertical,
          children: [
            Visibility(
              visible: !isHiddenTitleBar,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: titlePadding ?? 24,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title ?? '',
                            style: context.textTheme.titleLarge,
                          ),
                          spaceH4,
                          subTitle != null
                              ? Text(
                                  subTitle ?? '',
                                  style: context.textTheme.labelLarge,
                                )
                              : const SizedBox(),
                          if (subTitleWidget != null) subTitleWidget!
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (onCloseTapped == null) {
                          Navigator.pop(context);
                        } else {
                          onCloseTapped!();
                        }
                      },
                      child: Container(
                        child: closeBtn ??
                            Container(
                              alignment: Alignment.centerRight,
                              width: 40,
                              height: 40,
                              child: Assets.icons.icXClose.svg(
                                color: context
                                    .appColorScheme.colorExtendedIconActive01,
                              ),
                            ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Flexible(child: child),
          ],
        ),
      ),
    );
  }
}

class TitleBottomSheetAutoHeightWrapperV2 extends StatelessWidget {
  const TitleBottomSheetAutoHeightWrapperV2({
    super.key,
    required this.child,
    this.title,
    this.onCloseTapped,
    this.minChildSize = 0.4,
    this.initialChildSize = 0.8,
    this.maxChildSize = 0.95,
    this.isHiddenTitleBar = false,
    this.closeBtn,
  });

  final VoidCallback? onCloseTapped;
  final String? title;
  final Widget child;
  final double minChildSize;
  final double initialChildSize;
  final double maxChildSize;
  final bool isHiddenTitleBar;
  final Widget? closeBtn;
  @override
  Widget build(BuildContext context) {
    return _wrapper(
      context,
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Flex(
          mainAxisSize: MainAxisSize.min,
          direction: Axis.vertical,
          children: [
            Visibility(
              visible: !isHiddenTitleBar,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 8.w),
                child: AppBar(
                  title: Text(title ?? ''),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              ),
            ),
            Flexible(child: child),
          ],
        ),
      ),
    );
  }
}
