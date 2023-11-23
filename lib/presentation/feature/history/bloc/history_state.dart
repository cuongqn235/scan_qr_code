part of 'history_bloc.dart';

@freezed
class HistoryState with _$HistoryState implements BaseState {
  const factory HistoryState({
    @Default(Status.idle()) Status status,
  }) = _HistoryState;
}
