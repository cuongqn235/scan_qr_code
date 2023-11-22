import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_scan_qr_code_event.dart';
import 'app_scan_qr_code_state.dart';

class AppScanQrCodeBloc extends Bloc<AppScanQrCodeEvent, AppScanQrCodeState> {
  AppScanQrCodeBloc({
    AppScanQrCodeState initialState = const AppScanQrCodeState(),
  }) : super(initialState) {
    // event mapping
    on<CaptureScanQrcode>((e, handler) async {
      // handler(state.copyWith(isScanable: false));
      // try {
      //   handler(
      //     state.copyWith(
      //       showLoading: true,
      //     ),
      //   );

      //   var rawDataQrCode = e.qrCode;
      //   if (rawDataQrCode.isNotEmpty && rawDataQrCode.contains('fphouse.vn')) {
      //     rawDataQrCode =
      //         rawDataQrCode.substring(rawDataQrCode.lastIndexOf('data=') + 5);
      //     // Step 1: URL Decoding
      //     final urlDecodedString = Uri.decodeComponent(rawDataQrCode);

      //     // Step 2: Base64 Decoding
      //     List<int> decodedBytes = base64.decode(urlDecodedString);

      //     // Step 3: Convert UTF-8 bytes to string
      //     rawDataQrCode = utf8.decode(decodedBytes);
      //   }

      //   final dataQrCode = rawDataQrCode.split('|');
      //   final type = TypeScanQRCodeEnum.fromValue(() {
      //     try {
      //       return dataQrCode.last;
      //       // ignore: avoid_catches_without_on_clauses
      //     } catch (e) {
      //       return null;
      //     }
      //   }());

      //   await qrDataHandler(dataQrCode, type, handler);
      // } on Exception catch (e) {
      //   handler(state.copyWith(showLoading: false, error: UIError(cause: e)));
      // } finally {
      //   handler(
      //     state.copyWith(
      //       scanQrCodeData: null,
      //       showLoading: false,
      //     ),
      //   );
      // }
    });
    // other event
  }
}
