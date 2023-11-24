import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:scan_qr_code/app/common/model/status.dart';
import 'package:scan_qr_code/domain/usecases/scan/get_all_scan_usecase.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/models/app_scan_data.dart';

part 'history_tab_state.dart';
part 'history_tab_event.dart';
part 'history_tab_bloc.freezed.dart';

@injectable
class HistoryTabBloc extends Bloc<HistoryTabEvent, HistoryTabState> {
  HistoryTabBloc(
    this._getAllJokeUseCase,
    @factoryParam HistoryTabState? state,
  ) : super(state ?? const HistoryTabState()) {
    on<HistoryTabEventOnStart>(_onStart);
  }
  final GetAllJokeUseCase _getAllJokeUseCase;

  FutureOr<void> _onStart(
      HistoryTabEventOnStart event, Emitter<HistoryTabState> emit) async {
    try {
      if (event.pageKey == 0) {
        emit(
          state.copyWith(
            currentPage: 0,
            canLoadMore: true,
            newScans: null,
          ),
        );
      }
      final res = await _getAllJokeUseCase.execute(
        state.isAdmin,
      );
      final data = res.fold(
        (l) => throw l,
        (r) => r.map(AppScanData.fromEntity).toList(),
      );
      final scans = List<AppScanData>.from(state.scans)..addAll(data);
      final canLoadMore = scans.length < data.length;
      emit(
        state.copyWith(
          scans: data,
          newScans: data,
          canLoadMore: canLoadMore,
          currentPage: event.pageKey,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.failure(value: e),
        ),
      );
    } finally {
      emit(
        state.copyWith(
          status: const Status.idle(),
        ),
      );
    }
  }
}
