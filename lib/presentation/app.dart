import 'dart:async';

import 'package:dartz/dartz.dart' as dartz;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:scan_qr_code/app/inject_dependency/inject_dependency.dart';
import 'package:scan_qr_code/app/router/app_router.dart';
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
          create: (context) => getIt<AppBloc>()..add(AppEventInitial()),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => getIt<InitialCubit>()..start(),
        ),
      ],
      child: Builder(builder: (context) {
        ScreenUtil.init(
          context,
          designSize: const Size(375, 812),
        );
        return const _MyApp();
      }),
    );
  }
}

// late final GoRouter appRouter;

class _MyApp extends StatefulWidget {
  const _MyApp({super.key});

  @override
  State<_MyApp> createState() => __MyAppState();
}

class __MyAppState extends State<_MyApp> {
  late final Completer processIntital;
  late final AppBloc appBloc;

  late final StreamController redirectController;

  @override
  void initState() {
    super.initState();
    appBloc = context.read<AppBloc>();
    processIntital = Completer();
    redirectController = StreamController.broadcast();
    intitial();
  }

  void intitial() {
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
              previous.isFirstLaunch != current.isFirstLaunch,
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
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: AppTheme.lightTheme(context),
        darkTheme: AppTheme.darkTheme(context),
        // routeInformationParser: appRouter.routeInformationParser,
        // routerDelegate: appRouter.routerDelegate,
        // routeInformationProvider: appRouter.routeInformationProvider,\
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routerConfig: AppRouter.setup(redirectController),
        builder: (context, child) {
          return LoaderOverlay(
            child: BlocSelector<InitialCubit, InitialState, bool>(
              selector: (state) {
                return state.isFinish;
              },
              builder: (context, isFinish) {
                if (isFinish) {
                  return child ?? const SizedBox.shrink();
                } else {
                  return const SplashPage();
                }
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    redirectController.close();
    super.dispose();
  }
}
