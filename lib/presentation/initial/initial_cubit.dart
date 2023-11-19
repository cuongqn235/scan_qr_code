import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part 'initial_state.dart';

@injectable
class InitialCubit extends Cubit<InitialState> {
  InitialCubit() : super(const InitialState());
  void start() {
    emit(const InitialState(isFinish: false));
  }

  void end() {
    emit(const InitialState(isFinish: true));
  }
}
