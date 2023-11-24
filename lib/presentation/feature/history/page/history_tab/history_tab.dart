import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:scan_qr_code/app/extensions/spaces.dart';
import 'package:scan_qr_code/presentation/feature/history/page/history_tab/bloc/history_tab_bloc.dart';
import 'package:scan_qr_code/presentation/feature/history/page/history_tab/history_tab_item.dart';
import 'package:scan_qr_code/presentation/feature/history/page/history_tab/history_tab_not_found.dart';
import 'package:scan_qr_code/presentation/feature/history/page/history_tab/history_tab_shimmer.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/models/app_scan_data.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab>
    with AutomaticKeepAliveClientMixin {
  late final HistoryTabBloc bloc;
  late PagingController<int, AppScanData> pagingController;
  @override
  void initState() {
    super.initState();
    pagingController = PagingController<int, AppScanData>(firstPageKey: 0);
    bloc = context.read<HistoryTabBloc>();
    pagingController.addPageRequestListener((pageKey) {
      bloc.add(HistoryTabEventOnStart(pageKey));
    });
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<HistoryTabBloc, HistoryTabState>(
          listenWhen: (p, c) => p.newScans != c.newScans && c.newScans != null,
          listener: (context, state) {
            if (state.canLoadMore) {
              pagingController.appendPage(
                state.newScans ?? [],
                state.currentPage + 1,
              );
            } else {
              pagingController.appendLastPage(
                state.newScans ?? [],
              );
            }
          },
        ),
      ],
      child: RefreshIndicator(
        onRefresh: () async => Future.sync(pagingController.refresh),
        child: PagedListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 44),
            separatorBuilder: (context, index) => spaceH16,
            pagingController: pagingController,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            builderDelegate: PagedChildBuilderDelegate<AppScanData>(
              noItemsFoundIndicatorBuilder: (context) =>
                  const HistoryTabNotFound(),
              animateTransitions: true,
              firstPageProgressIndicatorBuilder: (context) =>
                  const HistoryTabShimmer(),
              newPageProgressIndicatorBuilder: (context) =>
                  const HistoryTabShimmer(),
              itemBuilder: (context, item, index) {
                return HistoryTabItem(
                  scanData: item,
                );
              },
            )),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
