import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:scan_qr_code/app/common/page/base_page.dart';
import 'package:scan_qr_code/app/router/app_routes.dart';
import 'package:scan_qr_code/app/router/go_router_refresh_stream.dart';
import 'package:scan_qr_code/presentation/feature/error/error_page.dart';
import 'package:scan_qr_code/presentation/feature/history/bloc/history_bloc.dart';
import 'package:scan_qr_code/presentation/feature/history/page/history_page.dart';
import 'package:scan_qr_code/presentation/feature/home/bloc/home_bloc.dart';
import 'package:scan_qr_code/presentation/feature/home/page/home_page.dart';
import 'package:scan_qr_code/presentation/feature/on_board/ui/on_board_page.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/bloc/app_scan_qr_code_bloc.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/bloc/app_scan_qr_code_state.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/models/app_scan_qr_code_params.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/page/app_scan_qr_code.dart';
import 'package:scan_qr_code/presentation/feature/splash/splash_page.dart';

class AppRouter {
  static GoRouter router(
    StreamController redirectController, {
    FutureOr<String?> Function(BuildContext, GoRouterState)? redirect,
  }) {
    return GoRouter(
      debugLogDiagnostics: kDebugMode,
      initialLocation: '/',
      errorBuilder: (context, state) {
        if (kDebugMode) {
          print(state.error);
        }
        return const ErrorPage();
      },
      refreshListenable: GoRouterRefreshStream(redirectController.stream),
      redirect: redirect,
      routes: [
        GoRoute(
          name: AppRoutes.splash.name,
          path: AppRoutes.splash.path,
          pageBuilder: (context, state) {
            return const CupertinoPage(
              child: SplashPage(),
            );
          },
        ),
        GoRoute(
          name: AppRoutes.onBoard.name,
          path: AppRoutes.onBoard.path,
          pageBuilder: (context, state) {
            return const CupertinoPage(
              child: OnBoardPage(),
            );
          },
        ),
        GoRoute(
          name: AppRoutes.home.name,
          path: AppRoutes.home.path,
          pageBuilder: (context, state) {
            return CupertinoPage(
              key: state.pageKey,
              child: BasePage<HomeBloc, HomeState>(page: const HomePage()),
            );
          },
        ),
        GoRoute(
          name: AppRoutes.scanQrCode.name,
          path: AppRoutes.scanQrCode.path,
          pageBuilder: (context, state) {
            final params = state.extra as AppScanQrCodeParams;
            return CupertinoPage(
              key: state.pageKey,
              child: BasePage<AppScanQrCodeBloc, AppScanQrCodeState>(
                  page: AppScanQrCodePage(
                params: params,
              )),
            );
          },
        ),
        GoRoute(
          name: AppRoutes.history.name,
          path: AppRoutes.history.path,
          pageBuilder: (context, state) {
            return CupertinoPage(
              key: state.pageKey,
              child: BasePage<HistoryBloc, HistoryState>(
                  page: const HistoryPage()),
            );
          },
        ),
      ],
    );
  }
}
