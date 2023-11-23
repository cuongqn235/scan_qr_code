part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState implements BaseState {
  const factory HomeState({
    @Default(Status.idle()) Status status,
  }) = _HomeState;
}
