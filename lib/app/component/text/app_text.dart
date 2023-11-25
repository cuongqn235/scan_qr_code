import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class AppText extends StatelessWidget {
  const AppText(
    this.value, {
    super.key,
    required this.title,
    this.style,
  });
  final String? value;
  final String title;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: (value ?? '').isNotEmpty,
      child: Text(
        '${title.tr()}: $value',
        style: style,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
