import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/models/app_qr_code_data.dart';

part 'qr_code_generate_dialog_state.dart';
part 'qr_code_generate_dialog_cubit.freezed.dart';

class QrCodeGenerateDialogCubit extends Cubit<QrCodeGenerateDialogState> {
  QrCodeGenerateDialogCubit({
    required AppQrCodeData data,
  }) : super(QrCodeGenerateDialogState(
          data: data,
        ));
}
