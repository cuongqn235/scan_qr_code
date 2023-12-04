part of '../generate_page.dart';

class QrCodeGenerateDialog extends StatefulWidget {
  const QrCodeGenerateDialog({super.key, required this.type});
  final BarcodeType type;
  static Future<void> open(
    BuildContext context, {
    required BarcodeType type,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          contentPadding: EdgeInsets.zero,
          alignment: Alignment.center,
          actionsPadding: EdgeInsets.zero,
          actionsOverflowAlignment: OverflowBarAlignment.center,
          content: QrCodeGenerateDialog(
            type: type,
          ),
        );
      },
    );
  }

  @override
  State<QrCodeGenerateDialog> createState() => _QrCodeGenerateDialogState();
}

class _QrCodeGenerateDialogState extends State<QrCodeGenerateDialog>
    with TickerProviderStateMixin {
  late final QrCodeGenerateDialogCubit _cubit;
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  @override
  void initState() {
    late final AppQrCodeData data;
    switch (widget.type) {
      case BarcodeType.email:
        data = AppQrCodeData.email();
      case BarcodeType.phone:
        data = AppQrCodeData.phone();
      case BarcodeType.sms:
        data = AppQrCodeData.sms(
          phoneNumber: '',
        );
      case BarcodeType.url:
        data = AppQrCodeData.urlBookmark(
          url: '',
        );
      case BarcodeType.wifi:
        data = AppQrCodeData.wifi();
      case BarcodeType.text:
        data = AppQrCodeData.text();
      default:
        data = AppQrCodeData.text();
    }
    logger.d(data);
    _cubit = QrCodeGenerateDialogCubit(
      data: data,
    );
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: ScaleTransition(
        scale: _animation,
        child: Padding(
          padding: EdgeInsets.only(
            left: 24.w,
            right: 24.w,
            top: 42.h,
            bottom: 24.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.type.getIcon.svg(
                height: 60.h,
                width: 60.w,
                colorFilter: ColorFilter.mode(
                  context.colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
              spaceH16,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.type.name,
                ),
              ),
              const AppTextFormField(),
              spaceH16,
              AppSolidButton.medium(
                'Generate QR Code',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
