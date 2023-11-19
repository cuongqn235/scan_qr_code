part of 'app_bloc.dart';

class AppState extends Equatable {
  final bool? isFirstLaunch;

  const AppState({this.isFirstLaunch});

  @override
  List<Object?> get props => [isFirstLaunch];
}
