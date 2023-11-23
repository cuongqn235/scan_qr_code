import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:scan_qr_code/app/common/application/base_state.dart';
import 'package:scan_qr_code/app/common/model/status.dart';
import 'package:scan_qr_code/app/component/loading/indicator.dart';
import 'package:scan_qr_code/app/extensions/context.dart';
import 'package:scan_qr_code/app/inject_dependency/inject_dependency.dart';

class BasePage<B extends BlocBase<S>, S extends BaseState>
    extends StatefulWidget {
  const BasePage._({super.key, required this.page, this.param1, this.param2});
  final Widget page;
  final dynamic param1;
  final dynamic param2;
  factory BasePage({
    required Widget page,
    dynamic param1,
    dynamic param2,
  }) {
    return BasePage._(
      page: page,
      param1: param1,
      param2: param2,
    );
  }

  @override
  State<BasePage> createState() => _BasePageState<B, S>();
}

class _BasePageState<B extends BlocBase<S>, S extends BaseState>
    extends State<BasePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<B>(param1: widget.param1, param2: widget.param2),
      child: BlocSelector<B, S, Status>(
        selector: (state) {
          return state.status;
        },
        builder: (context, status) {
          return LoaderOverlay(
              child: BlocListener<B, S>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              state.status.map(
                idle: (value) {
                  context.loaderOverlay.hide();
                },
                success: (value) {},
                loading: (value) {
                  context.loaderOverlay.show(
                    widgetBuilder: (progress) => const AppIndicator(),
                  );
                },
                failure: (value) {
                  context.showAlert(title: 'Lỗi', content: 'Vui lòng thử lại');
                },
              );
            },
            child: widget.page,
          ));
        },
      ),
    );
  }
}
