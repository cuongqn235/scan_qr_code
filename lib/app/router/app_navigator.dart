﻿import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scan_qr_code/app/router/app_routes.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/models/app_scan_qr_code_params.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/models/app_qr_code_data.dart';

abstract class AppNavigator {
  void pushOnBoard();
  void pushHome();
  Future<AppQrCodeData?> pushScanQrcode(AppScanQrCodeParams params);
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
  Future<AppQrCodeData?> pushScanQrcode(AppScanQrCodeParams params) async {
    final res = await context.push<AppQrCodeData?>(
      // '${AppRoutes.home.path}/${AppRoutes.scanQrCode.path}',
      AppRoutes.scanQrCode.path,
      extra: params,
    );
    return res;
  }

  @override
  void pushHistory() {
    context.push(
      // '${AppRoutes.home.path}/${AppRoutes.history.path}',
      AppRoutes.history.path,
    );
  }
}
