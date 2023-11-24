import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:scan_qr_code/app/core/usecases/data_usecase.dart';
import 'package:scan_qr_code/app/core/usecases/no_param_usecase.dart';
import 'package:scan_qr_code/domain/entities/scan_entity.dart';
import 'package:scan_qr_code/domain/repositories/scan/i_scan_repository.dart';

@injectable
class GetAllJokeUseCase extends NoParamUseCase<DataUseCase<List<ScanEntity>>> {
  final IScanRepository _iScanRepository;
  GetAllJokeUseCase(this._iScanRepository);

  @override
  Future<DataUseCase<List<ScanEntity>>> execute() async {
    try {
      final data = await _iScanRepository.getAllScan();
      return right(data);
    } on Exception catch (e) {
      return left(e);
    }
  }
}
