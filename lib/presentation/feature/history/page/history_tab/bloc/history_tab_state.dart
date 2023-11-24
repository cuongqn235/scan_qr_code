part of 'history_tab_bloc.dart';

@freezed
class HistoryTabState with _$HistoryTabState {
  const factory HistoryTabState({
    bool? isAdmin,
    @Default(Status.idle()) Status status,
    @Default(<AppScanData>[]) List<AppScanData> scans,
    List<AppScanData>? newScans,
    @Default(false) bool canLoadMore,
    @Default(0) int currentPage,
  }) = _HistoryTabState;
}
