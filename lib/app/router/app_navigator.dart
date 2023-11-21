import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scan_qr_code/app/router/app_routes.dart';

abstract class AppNavigator {
  void pushOnBoard();
  void pushHome();
}

class AppNavigatorImpl implements AppNavigator {
  final BuildContext context;

  AppNavigatorImpl(this.context);

  @override
  void pushOnBoard() {
    context.pushNamed(
      AppRoutes.onBoard.name,
      // extra: args,
    );
  }

  @override
  void pushHome() {
    context.pushNamed(
      AppRoutes.home.name,
      // extra: args,
    );
  }
}
