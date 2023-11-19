part of 'initial_cubit.dart';

class InitialState extends Equatable {
  const InitialState({
    this.isFinish = false,
  });
  final bool isFinish;

  @override
  List<Object?> get props => [isFinish];
}
