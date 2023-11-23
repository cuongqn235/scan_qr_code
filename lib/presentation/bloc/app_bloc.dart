import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:scan_qr_code/domain/repositories/app/i_app_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

@injectable
class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(
    this._appRepository,
  ) : super(const AppState()) {
    on<AppEventInitial>(_initial);
    on<AppEventEndOnboard>(_endOnBoard);
  }
  final IAppRepository _appRepository;
  FutureOr<void> _initial(AppEventInitial event, Emitter<AppState> emit) async {
    await Future.delayed(const Duration(seconds: 1));
    final isFirstLaunch = _appRepository.isFirstLaunch;

    if (isFirstLaunch) {
      await _appRepository.clearAllData();
    }
    emit(AppState(isFirstLaunch: isFirstLaunch));
    // add(AppEventEndOnboard());
  }

  FutureOr<void> _endOnBoard(
      AppEventEndOnboard event, Emitter<AppState> emit) async {
    await _appRepository.saveFirstLaunch();
    emit(const AppState(isFirstLaunch: false));
  }
}
