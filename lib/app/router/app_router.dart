import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:scan_qr_code/app/common/page/base_page.dart';
import 'package:scan_qr_code/app/extensions/async.dart';
import 'package:scan_qr_code/app/router/app_page.dart';
import 'package:scan_qr_code/app/router/app_routes.dart';
import 'package:scan_qr_code/app/router/go_router_refresh_stream.dart';
import 'package:scan_qr_code/presentation/bloc/app_bloc.dart';
import 'package:scan_qr_code/presentation/feature/error/error_page.dart';
import 'package:scan_qr_code/presentation/feature/generate/bloc/generate_bloc.dart';
import 'package:scan_qr_code/presentation/feature/generate/page/generate_page.dart';
import 'package:scan_qr_code/presentation/feature/history/bloc/history_bloc.dart';
import 'package:scan_qr_code/presentation/feature/history/page/history_page.dart';
import 'package:scan_qr_code/presentation/feature/home/bloc/home_bloc.dart';
import 'package:scan_qr_code/presentation/feature/home/page/home_page.dart';
import 'package:scan_qr_code/presentation/feature/on_board/ui/on_board_page.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/bloc/app_scan_qr_code_bloc.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/models/app_scan_qr_code_params.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/page/app_scan_qr_code.dart';

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static GoRouter setup(
    StreamController redirectController, {
    Iterable<Stream<dynamic>>? streams,
  }) {
    return GoRouter(
      debugLogDiagnostics: kDebugMode,
      initialLocation: AppRoutes.home.path,
      errorBuilder: (context, state) {
        if (kDebugMode) {
          print(state.error);
        }
        return const ErrorPage();
      },
      refreshListenable: GoRouterRefreshStream(
          redirectController.stream.merge([...(streams ?? [])])),
      redirect: (context, state) async {
        //Step1
        // final isFirstLaunch = context.read<AppBloc>().state.isFirstLaunch;
        // if (isFirstLaunch == true) {
        //   return AppRoutes.onBoard.path;
        // }
        // // // return null;
        // if (state.matchedLocation.compareTo('/') != 0 &&
        //     state.matchedLocation.compareTo(AppRoutes.onBoard.path) != 0) {
        //   return state.fullPath;
        // }
        // return AppRoutes.home.path;
        //Step2
        final isFirstLaunch = context.read<AppBloc>().state.isFirstLaunch;
        final bool loggingIn = state.matchedLocation == AppRoutes.onBoard.path;
        if (isFirstLaunch == true) {
          return AppRoutes.onBoard.path;
        }

        // if the user is logged in but still on the login page, send them to
        // the home page
        if (loggingIn) {
          return AppRoutes.home.path;
        }

        // no need to redirect at all
        return null;
      },
      routes: <RouteBase>[
        GoRoute(
          name: AppRoutes.onBoard.name,
          path: AppRoutes.onBoard.path,
          pageBuilder: (context, state) {
            return AppPage.animatedPage(
              context,
              state,
              const OnBoardPage(),
            );
          },
        ),
        GoRoute(
            name: AppRoutes.home.name,
            path: AppRoutes.home.path,
            pageBuilder: (context, state) {
              return AppPage.animatedPage(
                context,
                state,
                BasePage<HomeBloc, HomeState>(page: const HomePage()),
              );
            },
            redirect: (context, state) async {
              final nextPath = state.fullPath;
              final thisPath = state.matchedLocation;
              if (nextPath != thisPath) {
                return nextPath;
              }
              return state.matchedLocation;
            },
            routes: [
              GoRoute(
                name: AppRoutes.scanQrCode.name,
                path: AppRoutes.scanQrCode.path,
                pageBuilder: (context, state) {
                  final params = state.extra as AppScanQrCodeParams;
                  return AppPage.animatedPage(
                    context,
                    state,
                    BasePage<AppScanQrCodeBloc, AppScanQrCodeState>(
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
                  return AppPage.animatedPage(
                    context,
                    state,
                    BasePage<HistoryBloc, HistoryState>(
                        page: const HistoryPage()),
                  );
                },
              ),
              GoRoute(
                name: AppRoutes.generate.name,
                path: AppRoutes.generate.path,
                pageBuilder: (context, state) {
                  return AppPage.animatedPage(
                    context,
                    state,
                    BasePage<GenerateBloc, GenerateState>(
                        page: const GeneratePage()),
                  );
                },
              ),
            ]),
      ],
    );
  }
}
