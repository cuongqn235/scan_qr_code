import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scan_qr_code/app/router/app_routes.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/models/app_scan_qr_code_params.dart';

abstract class AppNavigator {
  void pushOnBoard();
  void pushHome();
  void pushScanQrcode(AppScanQrCodeParams params);
  void pushHistory();
}

class AppNavigatorImpl implements AppNavigator {
  final BuildContext context;

  AppNavigatorImpl(this.context);

  @override
  void pushOnBoard() {
    context.push(
      AppRoutes.onBoard.path,
      // extra: args,
    );
  }

  @override
  void pushHome() {
    context.push(
      AppRoutes.home.path,
      // extra: args,
    );
  }

  @override
  void pushScanQrcode(AppScanQrCodeParams params) {
    context.push(
      AppRoutes.scanQrCode.path,
      extra: params,
    );
  }

  @override
  void pushHistory() {
    context.push(
      AppRoutes.history.path,
    );
  }
}
