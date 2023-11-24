import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scan_qr_code/app/common/application/base_state.dart';
import 'package:scan_qr_code/app/common/model/status.dart';
import 'package:scan_qr_code/app/extensions/barcode_type_extension.dart';
import 'package:scan_qr_code/domain/entities/scan_entity.dart';
import 'package:scan_qr_code/domain/usecases/scan/add_scan_usecase.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/models/app_qr_code_data.dart';
import 'package:uuid/uuid.dart';

part 'app_scan_qr_code_event.dart';
part 'app_scan_qr_code_state.dart';
part 'app_scan_qr_code_bloc.freezed.dart';

@injectable
class AppScanQrCodeBloc extends Bloc<AppScanQrCodeEvent, AppScanQrCodeState> {
  AppScanQrCodeBloc(this._addJokeFeedbackUseCase)
      : super(const AppScanQrCodeState()) {
    // event mapping
    on<CaptureScanQrcode>(_onCaptureScanQrcode);
    on<AppScanQrCodeEventClearResult>(_onClearResult);
  }
  final AddJokeFeedbackUseCase _addJokeFeedbackUseCase;
  FutureOr<void> _onCaptureScanQrcode(
      CaptureScanQrcode event, Emitter<AppScanQrCodeState> emit) async {
    try {
      AppQrCodeData? data;
      switch (event.data.type) {
        case BarcodeType.email:
          data = AppQrCodeData.email(
            address: event.data.email?.address,
            body: event.data.email?.body,
            subject: event.data.email?.subject,
          );

          break;
        case BarcodeType.phone:
          data = AppQrCodeData.phone(
            number: event.data.phone?.number,
          );
          break;
        case BarcodeType.sms:
          assert(event.data.sms != null, 'sms data is null');
          data = AppQrCodeData.sms(
            message: event.data.sms?.message,
            phoneNumber: event.data.sms!.phoneNumber,
          );
          break;
        case BarcodeType.url:
          assert(event.data.url != null, 'url data is null');
          data = AppQrCodeData.urlBookmark(
            title: event.data.url?.title,
            url: event.data.url!.url,
          );
          break;
        case BarcodeType.wifi:
          data = AppQrCodeData.wifi(
            encryptionType: event.data.wifi?.encryptionType.rawValue,
            ssid: event.data.wifi?.ssid,
            password: event.data.wifi?.password,
          );
          break;
        case BarcodeType.text:
          data = AppQrCodeData.text(
            text: event.data.displayValue,
          );
          break;
        case BarcodeType.unknown:
        case BarcodeType.contactInfo:
        case BarcodeType.isbn:
        case BarcodeType.product:
        case BarcodeType.geo:
        case BarcodeType.calendarEvent:
        case BarcodeType.driverLicense:
          break;
      }
      if (data == null) {
        emit(state.copyWith(
          correctFormat: false,
        ));
      } else {
        await addScanEntity(event.data.type, data);
        emit(state.copyWith(
          data: data,
          correctFormat: true,
        ));
      }

      emit(state.copyWith(
        isScanable: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        correctFormat: false,
      ));
    } finally {
      emit(state.copyWith(
        correctFormat: null,
        data: null,
      ));
    }
  }

  Future<void> addScanEntity(BarcodeType type, AppQrCodeData data) async {
    final uuid = const Uuid().v4();
    await _addJokeFeedbackUseCase.execute(
      ScanEntity(
        id: uuid,
        scanType: type.value,
        createdAt: DateTime.now(),
        qrData: data.toEntity(),
      ),
    );
  }

  FutureOr<void> _onClearResult(
      AppScanQrCodeEventClearResult event, Emitter<AppScanQrCodeState> emit) {
    emit(
      state.copyWith(
        data: null,
        isScanable: true,
      ),
    );
  }
}
