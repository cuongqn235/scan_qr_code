﻿import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:scan_qr_code/app/core/usecases/data_usecase.dart';
import 'package:scan_qr_code/app/core/usecases/pram_usecase.dart';
import 'package:scan_qr_code/domain/entities/scan_entity.dart';
import 'package:scan_qr_code/domain/repositories/scan/i_scan_repository.dart';

@injectable
class AddJokeFeedbackUseCase
    extends ParamUseCase<DataUseCase<Unit>, ScanEntity> {
  final IScanRepository _scanRepository;
  AddJokeFeedbackUseCase(this._scanRepository);

  @override
  Future<DataUseCase<Unit>> execute(ScanEntity params) async {
    try {
      await _scanRepository.addScan(params);
      return right(unit);
    } on Exception catch (e) {
      return left(e);
    }
  }
}
