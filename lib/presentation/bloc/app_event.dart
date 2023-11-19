part of 'app_bloc.dart';

sealed class AppEvent {}

class AppEventInitial implements AppEvent {}

class AppEventEndOnboard implements AppEvent {}
