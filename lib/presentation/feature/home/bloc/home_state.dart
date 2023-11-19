part of 'home_bloc.dart';

sealed class HomeState extends Equatable {}

final class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

final class HomeStateNotFound extends HomeState {
  HomeStateNotFound();

  @override
  List<Object?> get props => [];
}

final class HomeStateError extends HomeState {
  HomeStateError();

  @override
  List<Object?> get props => [];
}
