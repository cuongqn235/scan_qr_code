part of 'history_tab_bloc.dart';

@freezed
class HistoryTabState with _$HistoryTabState {
  const factory HistoryTabState({
    @Default(Status.idle()) Status status,
    @Default(<AppScanData>[]) List<AppScanData> scans,
  }) = _HistoryTabState;
}
