import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scan_qr_code/app/common/application/base_state.dart';

abstract class BaseBloc<Event, S extends BaseState> extends Bloc<Event, S> {
  BaseBloc(S initState) : super(initState);
}
