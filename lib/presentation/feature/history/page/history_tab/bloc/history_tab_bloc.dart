import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'history_tab_state.dart';
part 'history_tab_event.dart';
part 'history_tab_bloc.freezed.dart';

@injectable
class HistoryTabBloc extends Bloc<HistoryTabEvent, HistoryTabState> {
  HistoryTabBloc() : super(const HistoryTabState()) {}
}
