import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scan_qr_code/app/inject_dependency/inject_dependency.dart';
import 'package:scan_qr_code/presentation/bloc/app_bloc.dart';
import 'package:scan_qr_code/presentation/feature/home/splash/splash.dart';
import 'package:scan_qr_code/presentation/feature/home/ui/home_page.dart';
import 'package:scan_qr_code/presentation/initial/initial_cubit.dart';

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

  @override
  void initState() {
    super.initState();
    appBloc = context.read<AppBloc>();
    processIntital = Completer();
    intitial();
  }

  void intitial() {
    context.read<InitialCubit>().start();
    appBloc.add(AppEventInitial());
    Future.wait([
      processIntital.future,
    ]).then((value) {
      if (mounted) {
        appBloc.add(AppEventEndOnboard());
        context.read<InitialCubit>().end();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.isFirstLaunch != null && !processIntital.isCompleted) {
          processIntital.complete();
        }
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocSelector<InitialCubit, InitialState, bool>(
          selector: (state) {
            return state.isFinish;
          },
          builder: (context, isFinish) {
            if (!isFinish) {
              return const SplashPage();
            }
            return const HomePage();
          },
        ),
      ),
    );
  }
}
