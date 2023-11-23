import 'dart:async';

import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:scan_qr_code/app/inject_dependency/inject_dependency.dart';
import 'package:scan_qr_code/app/router/app_router.dart';
import 'package:scan_qr_code/app/router/app_routes.dart';
import 'package:scan_qr_code/app/theme/theme.dart';
import 'package:scan_qr_code/presentation/bloc/app_bloc.dart';
import 'package:scan_qr_code/presentation/feature/splash/splash_page.dart';
import 'package:scan_qr_code/presentation/initial/initial_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => getIt<AppBloc>(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => getIt<InitialCubit>(),
        ),
      ],
      child: const _MyApp(),
    );
  }
}

class _MyApp extends StatefulWidget {
  const _MyApp({super.key});

  @override
  State<_MyApp> createState() => __MyAppState();
}

class __MyAppState extends State<_MyApp> {
  late final Completer processIntital;
  late final AppBloc appBloc;
  late final GoRouter appRouter;
  late final StreamController redirectController;

  @override
  void initState() {
    super.initState();
    appBloc = context.read<AppBloc>();
    processIntital = Completer();
    redirectController = StreamController.broadcast();
    appRouter = AppRouter.router(
      redirectController,
      redirect: (context, state) async {
        if (appBloc.state.isFirstLaunch == true) {
          return AppRoutes.onBoard.path;
        }
        if ((state.fullPath ?? '').isEmpty) {
          return AppRoutes.splash.path;
        }
        final allRoutes = AppRoutes.values
            .where(
              (element) => ![
                AppRoutes.splash,
                AppRoutes.onBoard,
              ].contains(element),
            )
            .map((e) => e.path)
            .toList();
        final path = allRoutes.firstWhere(
          (element) => element == state.fullPath,
          orElse: () => AppRoutes.home.path,
        );
        return path;
        // if ((state.fullPath ?? '').isNotEmpty) {
        //   final path = [
        //     AppRoutes.home.path,
        //     AppRoutes.scanQrCode.path,
        //   ].firstWhere(
        //     (element) => element == state.fullPath,
        //     orElse: () => AppRoutes.home.path,
        //   );
        //   return path;
        // } else {
        //   return null;
        // }
      },
    );
    intitial();
  }

  void intitial() {
    context.read<InitialCubit>().start();
    appBloc.add(AppEventInitial());
    Future.wait([
      processIntital.future,
    ]).then((value) {
      if (mounted) {
        // appBloc.add(AppEventEndOnboard());
        context.read<InitialCubit>().end();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AppBloc, AppState>(
          listenWhen: (previous, current) =>
              previous.isFirstLaunch == null && current.isFirstLaunch != null,
          listener: (context, state) {
            if (state.isFirstLaunch != null && !processIntital.isCompleted) {
              processIntital.complete();
            }
          },
        ),
        BlocListener<AppBloc, AppState>(
          listenWhen: (previous, current) =>
              previous.isFirstLaunch != current.isFirstLaunch &&
              current.isFirstLaunch == false,
          listener: (context, state) {
            redirectController.add(dartz.unit);
          },
        ),
      ],
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) {
            return MaterialApp.router(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.system,
              theme: AppTheme.lightTheme(context),
              darkTheme: AppTheme.darkTheme(context),
              routeInformationParser: appRouter.routeInformationParser,
              routerDelegate: appRouter.routerDelegate,
              routeInformationProvider: appRouter.routeInformationProvider,
              builder: (context, child) {
                return LoaderOverlay(
                  child: BlocSelector<InitialCubit, InitialState, bool>(
                    selector: (state) {
                      return state.isFinish;
                    },
                    builder: (context, isFinish) {
                      if (isFinish) {
                        return child ?? const SizedBox.shrink();
                      }
                      return const SplashPage();
                    },
                  ),
                );
              },
            );
          }),
    );
  }
}
