import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:scan_qr_code/app/extensions/async.dart';
import 'package:scan_qr_code/app/router/app_routes.dart';
import 'package:scan_qr_code/app/router/go_router_refresh_stream.dart';
import 'package:scan_qr_code/presentation/feature/error/error_page.dart';
import 'package:scan_qr_code/presentation/feature/home/page/home_page.dart';
import 'package:scan_qr_code/presentation/feature/on_board/ui/on_board_page.dart';

class AppRouter {
  static GoRouter router(
    StreamController redirectController, {
    FutureOr<String?> Function(BuildContext, GoRouterState)? redirect,
  }) {
    return GoRouter(
      debugLogDiagnostics: kDebugMode,
      initialLocation: AppRoutes.onBoard.path,
      errorBuilder: (context, state) {
        if (kDebugMode) {
          print(state.error);
        }
        return const ErrorPage();
      },
      refreshListenable: GoRouterRefreshStream(redirectController.stream.merge([
        // authBloc.stream,
      ])),
      redirect: redirect,
      routes: [
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
            return const CupertinoPage(
              child: HomePage(),
            );
          },
        ),
      ],
    );
  }
}
