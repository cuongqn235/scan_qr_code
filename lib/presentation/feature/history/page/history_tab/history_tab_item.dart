import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scan_qr_code/app/component/text/app_text.dart';
import 'package:scan_qr_code/app/extensions/context.dart';
import 'package:scan_qr_code/app/extensions/spaces.dart';
import 'package:scan_qr_code/presentation/feature/scan_qr/models/app_qr_code_data.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryTabItem extends StatelessWidget {
  const HistoryTabItem({super.key, required this.data});
  final AppQrCodeData data;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: HistoryTabItemBody(
              data: data,
            ),
          ),
          spaceW8,
          HistoryTabItemIcon(
            data: data,
          ),
        ],
      ),
    );
  }
}

class HistoryTabItemBody extends StatelessWidget {
  const HistoryTabItemBody({super.key, required this.data});
  final AppQrCodeData data;
  @override
  Widget build(BuildContext context) {
    return data.map(
      email: (value) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            value.address,
            title: 'Address',
          ),
          spaceH4,
          AppText(value.subject, title: 'Subject'),
          spaceH4,
          AppText(value.body, title: 'Body'),
        ],
      ),
      phone: (value) => AppText(value.number, title: 'Phone'),
      sms: (value) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(value.phoneNumber, title: 'Phone'),
          spaceH4,
          AppText(value.message, title: 'Message'),
        ],
      ),
      urlBookmark: (value) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(value.url,
              style: context.textTheme.bodyMedium?.copyWith(
                decoration: TextDecoration.underline,
              ),
              title: 'Url'),
          spaceH4,
          AppText(value.title, title: 'Title'),
        ],
      ),
      wifi: (value) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            value.encryptionType.toString(),
            title: 'EncryptionType',
          ),
          spaceH4,
          AppText(value.ssid, title: 'Ssid'),
          spaceH4,
          AppText(value.password, title: 'Password'),
        ],
      ),
      text: (value) => AppText(value.text, title: 'Text'),
    );
  }
}

class HistoryTabItemIcon extends StatelessWidget {
  const HistoryTabItemIcon({super.key, required this.data});
  final AppQrCodeData data;
  @override
  Widget build(BuildContext context) {
    return data.map(
        email: (value) => IconButton(
              onPressed: () async {
                final url = Uri(
                  scheme: 'mailto',
                  path: '${value.address}',
                  query: 'subject=${value.subject}&body=${value.body}',
                );
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              },
              icon: const Icon(
                Icons.email_outlined,
              ),
            ),
        phone: (value) => IconButton(
            onPressed: () async {
              final Uri launchUri = Uri(
                scheme: 'tel',
                path: value.number,
              );
              await launchUrl(launchUri);
            },
            icon: const Icon(Icons.phone_enabled_outlined)),
        sms: (value) => IconButton(
            onPressed: () async {
              final uri = Uri(
                scheme: 'sms',
                path: value.phoneNumber,
                query: 'body=${value.message}',
              );

              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            },
            icon: const Icon(Icons.sms_outlined)),
        urlBookmark: (value) => IconButton(
              onPressed: () {
                launchUrl(
                  Uri.parse(value.url),
                );
              },
              icon: const Icon(Icons.link),
            ),
        wifi: (value) => IconButton(
            onPressed: () {}, icon: const Icon(Icons.wifi_2_bar_outlined)),
        text: (value) => IconButton(
              onPressed: () {
                if ((value.text ?? '').isNotEmpty) {
                  Clipboard.setData(ClipboardData(text: value.text!)).then((_) {
                    Fluttertoast.showToast(
                      msg: value.text!,
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  });
                }
              },
              icon: const Icon(
                Icons.text_snippet_rounded,
              ),
            ));
  }
}
