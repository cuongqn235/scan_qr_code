import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:scan_qr_code/app/common/application/base_state.dart';
import 'package:scan_qr_code/app/common/model/status.dart';

part 'history_state.dart';
part 'history_event.dart';
part 'history_bloc.freezed.dart';

@injectable
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(const HistoryState()) {}
}
