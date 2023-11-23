import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scan_qr_code/app/component/popup/permission/camera_bottom_popup_permission.dart';
import 'package:scan_qr_code/app/extensions/colors.dart';
import 'package:scan_qr_code/app/extensions/context.dart';
import 'package:scan_qr_code/app/gen/assets.gen.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/bloc/app_scan_qr_code_bloc.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/models/app_scan_qr_code_params.dart';

class AppScanQrCodePage extends StatefulWidget {
  const AppScanQrCodePage({super.key, required this.params});
  final AppScanQrCodeParams params;

  @override
  State<AppScanQrCodePage> createState() {
    return _AppScanQrCodePageState();
  }
}

class _AppScanQrCodePageState extends State<AppScanQrCodePage> {
  late bool isScannerInitialized = false;
  bool isScanSuccess = false;
  late MobileScannerController mobileScannerCtrl;
  late bool isDispose;
  late AppScanQrCodeBloc bloc;
  @override
  void initState() {
    super.initState();
    checkCameraState();
    mobileScannerCtrl = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
    );
    bloc = context.read<AppScanQrCodeBloc>();
    isDispose = false;
  }

  Future<void> checkCameraState() async {
    final cameraStatus = await [
      Permission.camera,
    ].request();
    if (!mounted) {
      return;
    }
    if (cameraStatus[Permission.camera] == PermissionStatus.granted) {
      setState(() {
        isScannerInitialized = true;
      });
    } else {
      await CameraBottomPopupPermission.show(
        context,
        isDismissible: false,
        onNegative: () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AppScanQrCodeBloc, AppScanQrCodeState>(
          listenWhen: (p, c) => p.isScanable != c.isScanable,
          listener: (context, state) {
            state.isScanable
                ? mobileScannerCtrl.start()
                : mobileScannerCtrl.stop();
          },
        ),
        BlocListener<AppScanQrCodeBloc, AppScanQrCodeState>(
          listenWhen: (p, c) =>
              p.correctFormat != c.correctFormat && c.correctFormat == false,
          listener: (context, state) {
            context.showAlert(
                content: 'Mã QR không đúng hoặc đã hết hạn',
                title: 'Thông báo',
                onTapConfirmButton: () {
                  setState(() {
                    isScanSuccess = false;
                  });
                  bloc.add(AppScanQrCodeEventClearResult());
                });
          },
        ),
        BlocListener<AppScanQrCodeBloc, AppScanQrCodeState>(
          listenWhen: (p, c) => p.data != c.data && c.data != null,
          listener: (context, state) async {
            if (!mounted) {
              return;
            }
            if (state.data != null) {
              context.back(result: state.data);
              return;

              // bloc.add(AppScanQrCodeEventClearResult());
              // setState(() {
              //   isScanSuccess = false;
              // });
              // await mobileScannerCtrl.start();
            }
          },
        ),
        BlocListener<AppScanQrCodeBloc, AppScanQrCodeState>(
          listenWhen: (p, c) => p.data != c.data && c.data != null,
          listener: (context, state) async {
            // bloc.add(AppScanQrCodeEventClearResult());
          },
        ),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(24.r),
          alignment: Alignment.center,
          child: isScannerInitialized
              ? SafeArea(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: MobileScanner(
                            controller: mobileScannerCtrl,
                            onDetect: (capture) {
                              mobileScannerCtrl.stop();
                              final barcodes = capture.barcodes;
                              if (barcodes.isNotEmpty &&
                                  !isScanSuccess &&
                                  barcodes.first.rawValue != null) {
                                context.read<AppScanQrCodeBloc>().add(
                                      CaptureScanQrcode(
                                        barcodes.first,
                                      ),
                                    );
                                setState(() {
                                  isScanSuccess = true;
                                });
                              }
                            },
                            overlay: Assets.icons.squareScanqr.svg(
                              width: (1.sw - 50.w) / 2,
                              height: (1.sw - 50.w) / 2,
                              colorFilter: const ColorFilter.mode(
                                colorWhite,
                                BlendMode.srcIn,
                              ),
                            )),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }

  // @override
  // AppScanQrCodeBloc initBloc(BuildContext context) {
  //   return AppScanQrCodeBloc(
  //       estateDetailRepository: Get.find(), estateQrRepository: Get.find())
  //     ..add(AppScanQrCodeEventOnStarted(isWrite: widget.isWrite));
  // }

  @override
  void dispose() {
    if (mobileScannerCtrl.isStarting) {
      mobileScannerCtrl.stop();
    }
    mobileScannerCtrl.dispose();
    super.dispose();
  }
}
