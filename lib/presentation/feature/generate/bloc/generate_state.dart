part of 'generate_bloc.dart';

@freezed
class GenerateState with _$GenerateState implements BaseState {
  const factory GenerateState({
    @Default(Status.idle()) Status status,
  }) = _GenerateState;
}
