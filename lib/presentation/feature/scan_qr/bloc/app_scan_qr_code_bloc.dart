import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scan_qr_code/app/common/application/base_state.dart';
import 'package:scan_qr_code/app/common/model/status.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/models/scan_qr_code_data.dart';

part 'app_scan_qr_code_event.dart';
part 'app_scan_qr_code_state.dart';
part 'app_scan_qr_code_bloc.freezed.dart';

@injectable
class AppScanQrCodeBloc extends Bloc<AppScanQrCodeEvent, AppScanQrCodeState> {
  AppScanQrCodeBloc() : super(const AppScanQrCodeState()) {
    // event mapping
    on<CaptureScanQrcode>(_onCaptureScanQrcode);
    on<AppScanQrCodeEventClearResult>(_onClearResult);
  }

  FutureOr<void> _onCaptureScanQrcode(
      CaptureScanQrcode event, Emitter<AppScanQrCodeState> emit) async {
    try {
      switch (event.data.type) {
        case BarcodeType.email:
          emit(state.copyWith(
            data: ScanQrCodeData.email(
              address: event.data.email?.address,
              body: event.data.email?.body,
              subject: event.data.email?.subject,
            ),
            correctFormat: true,
          ));
          break;
        case BarcodeType.phone:
          emit(state.copyWith(
            data: ScanQrCodeData.phone(
              number: event.data.phone?.number,
            ),
            correctFormat: true,
          ));
          break;
        case BarcodeType.sms:
          assert(event.data.sms != null, 'sms data is null');
          emit(state.copyWith(
            data: ScanQrCodeData.sms(
              message: event.data.sms?.message,
              phoneNumber: event.data.sms!.phoneNumber,
            ),
            correctFormat: true,
          ));
          break;
        case BarcodeType.url:
          assert(event.data.url != null, 'url data is null');
          emit(state.copyWith(
            data: ScanQrCodeData.urlBookmark(
              title: event.data.url?.title,
              url: event.data.url!.url,
            ),
            correctFormat: true,
          ));
          break;
        case BarcodeType.wifi:
          emit(state.copyWith(
            data: ScanQrCodeData.wifi(
              encryptionType: event.data.wifi?.encryptionType.rawValue,
              ssid: event.data.wifi?.ssid,
              password: event.data.wifi?.password,
            ),
            correctFormat: true,
          ));
          break;
        case BarcodeType.text:
          emit(state.copyWith(
            data: ScanQrCodeData.text(
              text: event.data.displayValue,
            ),
            correctFormat: true,
          ));
          break;
        case BarcodeType.unknown:
        case BarcodeType.contactInfo:
        case BarcodeType.isbn:
        case BarcodeType.product:
        case BarcodeType.geo:
        case BarcodeType.calendarEvent:
        case BarcodeType.driverLicense:
          emit(state.copyWith(
            correctFormat: false,
          ));
          break;
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
