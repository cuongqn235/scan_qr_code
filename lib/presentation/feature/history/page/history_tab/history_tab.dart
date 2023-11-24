import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scan_qr_code/presentation/feature/history/page/history_tab/bloc/history_tab_bloc.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab>
    with AutomaticKeepAliveClientMixin {
  late final HistoryTabBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<HistoryTabBloc>()
      ..add(
        HistoryTabEventOnStart(),
      );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container();
  }

  @override
  bool get wantKeepAlive => true;
}
