import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scan_qr_code/app/extensions/colors.dart';
import 'package:scan_qr_code/app/extensions/context.dart';
import 'package:scan_qr_code/app/gen/assets.gen.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/bloc/app_scan_qr_code_bloc.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/bloc/app_scan_qr_code_event.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/bloc/app_scan_qr_code_state.dart';

class AppScanQrCodePage extends StatefulWidget {
  const AppScanQrCodePage(
      {super.key, this.isInputLink = false, this.isWrite = false});
  final bool isInputLink;
  final bool isWrite;
  static Future<ScanQrCodeData?> open(
    BuildContext context, {
    bool isInputLink = false,
    bool isWrite = false,
  }) async {
    return Navigator.push<ScanQrCodeData?>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AppScanQrCodePage(isInputLink: isInputLink, isWrite: isWrite),
      ),
    );
  }

  @override
  State<AppScanQrCodePage> createState() {
    return _AppScanQrCodePageState();
  }
}

class _AppScanQrCodePageState extends State<AppScanQrCodePage> {
  late bool isScannerInitialized = false;
  late TextEditingController linkController;
  bool isScanSuccess = false;
  late MobileScannerController mobileScannerCtrl;
  late bool isDispose;
  @override
  void initState() {
    super.initState();
    checkCameraState();
    linkController = TextEditingController();
    mobileScannerCtrl = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
    );

    isDispose = false;
  }

  // @override
  // void onError(
  //   BuildContext context,
  //   AppScanQrCodeBloc screenBloc,
  //   UIError error,
  // ) {
  //   if (error.cause is DioError && error.httpCode == 404) {
  //     showAlert(context,
  //         content: 'Mã QR không đúng hoặc đã hết hạn',
  //         title: 'Thông báo', onTapConfirmButton: () {
  //       screenBloc.add(AppScanQrCodeEventClearResult());
  //     });
  //   } else {
  //     super.onError(context, screenBloc, error);
  //   }
  // }

  // @override
  // void onConfirmError(BuildContext context) {
  //   context.read<AppScanQrCodeBloc>().add(AppScanQrCodeEventClearResult());
  //   setState(() {
  //     isScanSuccess = false;
  //   });
  //   mobileScannerCtrl.start();
  // }

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
      // await CameraBottomPopupPermission.show(
      //   context,
      //   isDismissible: false,
      //   onNegative: () {
      //     Navigator.of(context).pop();
      //   },
      // );
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocProvider(
      create: (context) => AppScanQrCodeBloc(),
      child: MultiBlocListener(
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
                p.correctFormat != c.correctFormat && !c.correctFormat,
            listener: (context, state) {
              // showAlert(context,
              //     content: 'Mã QR không đúng hoặc đã hết hạn',
              //     title: 'Thông báo', onTapConfirmButton: () {
              //   setState(() {
              //     isScanSuccess = false;
              //   });
              //   screenBloc.add(AppScanQrCodeEventClearResult());
              // });
            },
          ),
          BlocListener<AppScanQrCodeBloc, AppScanQrCodeState>(
            listenWhen: (p, c) => c.scanQrCodeData != null,
            listener: (context, state) async {
              if (!mounted) {
                return;
              }
              if (state.scanQrCodeData != null) {
                if (widget.isWrite) {
                  context.back(result: state.scanQrCodeData);
                  return;
                }

                // screenBloc.add(AppScanQrCodeEventClearResult());
                setState(() {
                  isScanSuccess = false;
                });
                await mobileScannerCtrl.start();
              }
            },
          ),
          // BlocListener<AppScanQrCodeBloc, AppScanQrCodeState>(
          //   listenWhen: (p, c) =>
          //       p.pasteResult != c.pasteResult && c.pasteResult != null,
          //   listener: (context, state) async {
          //     final qrId = state.scanQrCodeData
          //         ?.mapOrNull(qrContract: (v) => v.qrId, qrId: (v) => v.qrId);
          //     final estateBasicInfo = state.pasteResult?.mapOrNull(
          //         estateContract: (v) => v.info, qrContract: (v) => v.info);
          //     if (estateBasicInfo != null && qrId != null) {
          //       await Navigator.pushReplacement(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => BlocProvider(
          //               create: (context) => RenterScanEstateContractBloc(
          //                   estateDetailRepository: Get.find(),
          //                   authenRepo: Get.find(),
          //                   userProfileRepo: Get.find())
          //                 ..add(RenterScanEstateContractOnStarted(
          //                     qrId: qrId, data: estateBasicInfo)),
          //               child: RenterScanEstateContractPage(),
          //             ),
          //           ));
          //       return;
          //     }

          //     state.pasteResult?.mapOrNull(
          //       estateId: (e) async => Navigator.push<void>(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => BlocProvider(
          //             create: (context) => LinkBioEstateBloc(Get.find())
          //               ..add(
          //                 LinkBioEstateEventOnStart(
          //                   e.estateId,
          //                 ),
          //               ),
          //             child: const LinkBioEstatePage(),
          //           ),
          //         ),
          //       ),
          //     );

          //     screenBloc.add(AppScanQrCodeEventClearResult());
          //   },
          // ),
        ],
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: true,
            leading: CloseButton(
              color: context.colorScheme.onPrimary,
            ),
            title: Text(
              'Quét mã',
              style: TextStyle(color: context.colorScheme.onPrimary),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              image: DecorationImage(
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
                opacity: 0.3,
                image: ExactAssetImage(
                  Assets.images.scanQrCode.path,
                ),
              ),
            ),
            alignment: Alignment.center,
            child: isScannerInitialized
                ? SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height - 200.w,
                            width: MediaQuery.of(context).size.width - 50.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
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
                                      final barcodes = capture.barcodes;
                                      if (barcodes.isNotEmpty &&
                                          !isScanSuccess &&
                                          barcodes.first.rawValue != null) {
                                        context.read<AppScanQrCodeBloc>().add(
                                              CaptureScanQrcode(
                                                barcodes.first.rawValue!,
                                              ),
                                            );
                                        setState(() {
                                          isScanSuccess = true;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                Assets.icons.squareScanqr.svg(
                                  width:
                                      (MediaQuery.of(context).size.width - 50) /
                                          2,
                                  height:
                                      (MediaQuery.of(context).size.width - 50) /
                                          2,
                                  colorFilter: const ColorFilter.mode(
                                    colorWhite,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Visibility(
                          //   visible: widget.isInputLink,
                          //   child: Padding(
                          //     padding: const EdgeInsets.symmetric(
                          //       horizontal: 24,
                          //       vertical: 24,
                          //     ),
                          //     child: Row(
                          //       children: [
                          //         Expanded(
                          //           child: AppTextFormField(
                          //             controller: linkController,
                          //             maxLines: 3,
                          //             minLines: 1,
                          //             decoration: const InputDecoration(
                          //               labelText: 'Dán link tại đây',
                          //               floatingLabelBehavior:
                          //                   FloatingLabelBehavior.never,
                          //               fillColor: colorWhite,
                          //               filled: true,
                          //             ),
                          //           ),
                          //         ),
                          //         spaceW16,
                          //         FilledButton(
                          //           child: const Icon(Icons.paste),
                          //           onPressed: () async {
                          //             final cdata = await Clipboard.getData(
                          //               Clipboard.kTextPlain,
                          //             );
                          //             linkController.text = cdata?.text ?? '';
                          //             screenBloc.add(
                          //               AppScanQrCodeEventPasteLink(
                          //                 linkController.text,
                          //               ),
                          //             );
                          //           },
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
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
    linkController.dispose();
    mobileScannerCtrl.dispose();
    super.dispose();
  }
}
