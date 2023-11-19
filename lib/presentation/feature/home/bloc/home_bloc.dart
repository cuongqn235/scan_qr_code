import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
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
