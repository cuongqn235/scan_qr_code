import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scan_qr_code/app/extensions/context.dart';
import 'package:scan_qr_code/app/extensions/spaces.dart';
import 'package:scan_qr_code/presentation/feature/history/models/history_type.dart';
import 'package:scan_qr_code/presentation/feature/history/page/history_tab/bloc/history_tab_bloc.dart';
import 'package:scan_qr_code/presentation/feature/history/page/history_tab/history_tab.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with TickerProviderStateMixin {
  late final TabController tabController;
  late final PageController pageController;
  final _listHistoryType = HistoryType.values;
  @override
  void initState() {
    pageController = PageController();
    tabController = TabController(length: _listHistoryType.length, vsync: this);
    super.initState();
  }

  @override
  dispose() {
    tabController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: Column(children: [
        SizedBox(
          width: double.infinity,
          child: TabBar(
            onTap: (value) async {
              pageController.jumpToPage(value);
            },
            isScrollable: false,
            controller: tabController,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(width: 1),
            ),
            tabs: [
              ..._listHistoryType.map(
                (e) => Tab(
                  child: Text(
                    e.title,
                    style: context.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      // color: context.appColorScheme.cursor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        spaceH16,
        Expanded(
          child: PageView.builder(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {
                tabController.index = value;
              });
            },
            physics: const ClampingScrollPhysics(),
            itemCount: _listHistoryType.length,
            itemBuilder: (c, i) {
              return BlocProvider(
                create: (context) => HistoryTabBloc(),
                child: const HistoryTab(),
              );
            },
          ),
        )
      ]),
    );
  }
}
