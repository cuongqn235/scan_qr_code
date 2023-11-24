part of 'history_tab_bloc.dart';

sealed class HistoryTabEvent {}

class HistoryTabEventOnStart extends HistoryTabEvent {
  final int pageKey;
  HistoryTabEventOnStart(this.pageKey);
}
