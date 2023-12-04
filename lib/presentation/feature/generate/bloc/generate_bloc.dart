import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:scan_qr_code/app/common/application/base_state.dart';
import 'package:scan_qr_code/app/common/model/status.dart';

part 'generate_state.dart';
part 'generate_event.dart';
part 'generate_bloc.freezed.dart';

@injectable
class GenerateBloc extends Bloc<GenerateEvent, GenerateState> {
  GenerateBloc() : super(const GenerateState()) {}
}
