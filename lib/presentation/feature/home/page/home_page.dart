import 'package:flutter/material.dart';
import 'package:scan_qr_code/app/inject_dependency/inject_dependency.dart';
import 'package:scan_qr_code/presentation/feature/home/bloc/home_bloc.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/page/app_scan_qr_code.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc homeBloc;
  @override
  void initState() {
    super.initState();
    homeBloc = getIt<HomeBloc>()..add(HomeEventOnStart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppScanQrCodePage.open(context);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
