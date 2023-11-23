import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:scan_qr_code/app/common/application/base_state.dart';
import 'package:scan_qr_code/app/common/model/status.dart';
part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeEventOnStart>(_onStart);
  }

  FutureOr<void> _onStart(
      HomeEventOnStart event, Emitter<HomeState> emit) async {
    // try {
    //   final res = await _getJokeUseCase.execute();
    //   final data = res.fold((l) => throw l, (r) => r);
    //   if (data != null) {
    //     emit(HomeStateJoke(joke: data));
    //     return;
    //   }
    //   emit(HomeStateNotFound());
    // } catch (e) {
    //   emit(HomeStateError());
    // }
  }
}
