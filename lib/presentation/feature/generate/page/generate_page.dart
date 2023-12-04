import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scan_qr_code/app/component/button/solid_button.dart';
import 'package:scan_qr_code/app/component/text/app_text_form_field.dart';
import 'package:scan_qr_code/app/extensions/app_logger.dart';
import 'package:scan_qr_code/app/extensions/barcode_type_extension.dart';
import 'package:scan_qr_code/app/extensions/colors.dart';
import 'package:scan_qr_code/app/extensions/context.dart';
import 'package:scan_qr_code/app/extensions/spaces.dart';
import 'package:scan_qr_code/presentation/feature/generate/page/widgets/cubit/qr_code_generate_dialog_cubit.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/models/app_qr_code_data.dart';
part 'widgets/qr_code_generate_dialog.dart';

class GeneratePage extends StatefulWidget {
  const GeneratePage({super.key});

  @override
  State<GeneratePage> createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  final _generateList = const [
    BarcodeType.email,
    BarcodeType.phone,
    BarcodeType.sms,
    BarcodeType.url,
    BarcodeType.wifi,
    BarcodeType.text,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xD6333333),
      appBar: AppBar(),
      body: Column(
        children: [
          spaceH24,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 42.w),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 42.w,
                mainAxisSpacing: 42.h,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _generateList.length,
              itemBuilder: (c, i) {
                final item = _generateList[i];
                return GestureDetector(
                  onTap: () {
                    QrCodeGenerateDialog.open(
                      context,
                      type: item,
                    );
                  },
                  child: _item(
                    context,
                    item,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _item(BuildContext context, BarcodeType item) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 86.w,
          height: 86.w,
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            color: const Color(0xFF333333),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 2.r,
                color: const Color(0xFFD9D9D9),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: item.getIcon.svg(
            width: 24.w,
            height: 24.h,
            colorFilter: const ColorFilter.mode(
              Color(0xFFD9D9D9),
              BlendMode.srcIn,
            ),
          ),
        ),
        Positioned(
            top: -12.h,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 4.h,
              ),
              decoration: ShapeDecoration(
                color: const Color(0xFFD9D9D9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              child: Text(
                item.title,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: colorWhite,
                ),
              ),
            ))
      ],
    );
  }
}
