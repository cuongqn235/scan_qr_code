import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPage {
  static Page open<T>({
    LocalKey? key,
    required Widget child,
  }) {
    if (Platform.isAndroid) {
      return MaterialPage<T>(child: child, key: key);
    } else {
      return CupertinoPage<T>(child: child, key: key);
    }
  }
}
