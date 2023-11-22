import 'package:flutter/material.dart';
import 'package:scan_qr_code/app/extensions/context.dart';

class RequiredLabel extends StatelessWidget {
  const RequiredLabel(this._label, {super.key, this.style});
  final String _label;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _label,
          style: style,
        ),
        Text(
          ' *',
          style: TextStyle(color: context.colorScheme.error),
        )
      ],
    );
  }
}
