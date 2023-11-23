import 'package:flutter/material.dart';

Future<T?> showAppModalBottomSheetV3<T>({
  required BuildContext context,
  required Widget child,
  bool isScrollControlled = true,
  bool isDismissible = true,
  bool enableDrag = true,
  BoxConstraints? boxConstraints,
}) {
  return showModalBottomSheet<T?>(
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    constraints: boxConstraints ??
        BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).viewPadding.top,
        ),
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: child,
      );
    },
  );
}

Future<T?> showAppModalBottomSheetV2<T>({
  required BuildContext context,
  required Widget child,
  bool isScrollControlled = true,
}) {
  return showModalBottomSheet<T?>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: isScrollControlled,
    builder: (c) => child,
  );
}

Future<T?> showAppModalBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  double? scaleHeight,
  bool isDismissible = true,
  bool enableDrag = true,
}) {
  return showModalBottomSheet<T>(
    isDismissible: isDismissible,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    enableDrag: enableDrag,
    context: context,
    builder: (modal) {
      return LayoutBuilder(
        builder: (modal, constraints) {
          final isScaleHeight = scaleHeight != null;
          Widget last = Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            alignment: Alignment.center,
            child: child,
          );
          if (isScaleHeight) {
            last = SizedBox(
              height: constraints.maxHeight *
                  ((constraints.maxHeight <= 736) ? 0.7 : scaleHeight),
              child: last,
            );
          } else {
            last = IntrinsicHeight(
              child: last,
            );
          }
          return AnimatedPadding(
            duration: const Duration(milliseconds: 100),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(modal).viewInsets.bottom,
            ),
            child: last,
          );
        },
      );
    },
  );
}

// Future<void> showImagesPicker(
//   BuildContext context, {
//   required ValueChanged<List<String>> imagesPicked,
// }) async {
//   return showCupertinoModalPopup<void>(
//     context: context,
//     builder: (c) => CupertinoActionSheet(
//       actions: [
//         CupertinoActionSheetAction(
//           child: const Text('Chọn từ thư viện'),
//           onPressed: () async {
//             c.justBack();
//             final cameraStatus = await Permission.photos.status;
//             if (cameraStatus.isPermanentlyDenied) {
//               final _ = await GalleryBottomPopupPermission.show(
//                 context,
//               );
//               return;
//             }
//             final picker = ImagePicker();
//             final files = await picker.pickMultiImage();
//             final paths = files
//                 .map(
//                   (e) => e.path,
//                 )
//                 .toList();
//             imagesPicked(
//               paths,
//             );
//           },
//         ),
//         CupertinoActionSheetAction(
//           child: const Text('Chụp ảnh'),
//           onPressed: () async {
//             c.justBack();
//             final cameraStatus = await [
//               Permission.camera,
//             ].request();
//             if (cameraStatus[Permission.camera] == PermissionStatus.granted) {
//               final picker = ImagePicker();
//               // Pick an image
//               final file = await picker.pickImage(
//                 source: ImageSource.camera,
//               );
//               if (file != null) {
//                 logD('size: ${File(file.path).sizeOfImage()}');
//                 imagesPicked([file.path]);
//               }
//             } else {
//               // ignore: use_build_context_synchronously
//               final _ = await CameraBottomPopupPermission.show(
//                 context,
//               );
//             }
//             //Navigator.pop(context);
//           },
//         )
//       ],
//     ),
//   );
// }

// Future<void> showViewImagePicker({
//   required BuildContext context,
//   int initialPage = 0,
//   required List<AppFile> files,
//   required void Function(String uri) callback,
//   void Function(Exception e)? onError,
// }) {
//   return showCupertinoModalPopup<void>(
//     context: context,
//     builder: (c) => CupertinoActionSheet(
//       actions: <CupertinoActionSheetAction>[
//         if (files.isNotEmpty)
//           CupertinoActionSheetAction(
//             child: const Text('Xem ảnh'),
//             onPressed: () async {
//               try {
//                 c.justBack();
//                 PhotosReviewScreen.show(
//                   context,
//                   files: files,
//                 );
//               } on Exception catch (e) {
//                 onError?.call(e);
//               }
//             },
//           ),
//         CupertinoActionSheetAction(
//           child: const Text('Chọn từ thư viện'),
//           onPressed: () async {
//             try {
//               c.justBack();
//               final cameraStatus = await Permission.photos.status;
//               if (cameraStatus.isPermanentlyDenied) {
//                 final _ = await GalleryBottomPopupPermission.show(
//                   context,
//                 );
//                 return;
//               }

//               final picker = ImagePicker();
//               // Pick an image
//               final file = await picker.pickImage(
//                 source: ImageSource.gallery,
//               );
//               if (file != null) {
//                 logD('size: ${File(file.path).sizeOfImage()}');
//                 callback(file.path);
//               }
//             } on Exception catch (e) {
//               onError?.call(e);
//             }
//           },
//         ),
//         CupertinoActionSheetAction(
//           child: const Text('Chụp ảnh'),
//           onPressed: () async {
//             c.justBack();
//             final cameraStatus = await [
//               Permission.camera,
//             ].request();
//             if (cameraStatus[Permission.camera] == PermissionStatus.granted) {
//               final picker = ImagePicker();
//               // Pick an image
//               final file = await picker.pickImage(
//                 source: ImageSource.camera,
//               );
//               if (file != null) {
//                 logD('size: ${File(file.path).sizeOfImage()}');
//                 callback(file.path);
//               }
//             } else {
//               // show popup
//               // ignore: use_build_context_synchronously
//               final _ = await CameraBottomPopupPermission.show(
//                 context,
//               );
//             }
//             //Navigator.pop(context);
//           },
//         )
//       ],
//     ),
//   );
// }

// Future<void> showImagePicker({
//   required BuildContext context,
//   required void Function(String uri) callback,
//   CameraDevice cameraDevice = CameraDevice.rear,
//   void Function(Exception e)? onError,
// }) {
//   return showCupertinoModalPopup<void>(
//     context: context,
//     builder: (c) => CupertinoActionSheet(
//       actions: <CupertinoActionSheetAction>[
//         CupertinoActionSheetAction(
//           child: const Text('Chọn từ thư viện'),
//           onPressed: () async {
//             try {
//               c.justBack();
//               final cameraStatus = await Permission.photos.status;
//               if (cameraStatus.isPermanentlyDenied) {
//                 final _ = await GalleryBottomPopupPermission.show(
//                   context,
//                 );
//                 return;
//               }

//               final picker = ImagePicker();
//               // Pick an image
//               final file = await picker.pickImage(
//                 source: ImageSource.gallery,
//               );
//               if (file != null) {
//                 logD('size: ${File(file.path).sizeOfImage()}');
//                 callback(file.path);
//               }
//             } on Exception catch (e) {
//               onError?.call(e);
//             }
//           },
//         ),
//         CupertinoActionSheetAction(
//           child: const Text('Chụp ảnh'),
//           onPressed: () async {
//             c.justBack();
//             final cameraStatus = await [
//               Permission.camera,
//             ].request();
//             if (cameraStatus[Permission.camera] == PermissionStatus.granted) {
//               final picker = ImagePicker();
//               // Pick an image
//               final file = await picker.pickImage(
//                 source: ImageSource.camera,
//                 preferredCameraDevice: cameraDevice,
//               );

//               if (file != null) {
//                 logD('size: ${File(file.path).sizeOfImage()}');

//                 callback(file.path);
//               }
//             } else {
//               // ignore: use_build_context_synchronously
//               final _ = await CameraBottomPopupPermission.show(
//                 context,
//               );
//             }
//             //Navigator.pop(context);
//           },
//         )
//       ],
//     ),
//   );
// }

// Future<void> showDialogYearPicker({
//   required BuildContext context,
//   required int firstYear,
//   required int lastYear,
//   int? selectedYear,
//   required void Function(int year) callback,
// }) {
//   if (firstYear > lastYear) {
//     throw Exception('First year must be smaller than or equal to last year!');
//   }

//   context.hideKeyboard();
//   return showModalBottomSheet(
//     backgroundColor: Colors.transparent,
//     isScrollControlled: true,
//     context: context,
//     builder: (modal) {
//       final list = <int>[];
//       for (var i = lastYear; i >= firstYear; i--) {
//         list.add(i);
//       }
//       var itemSelected = selectedYear ?? list[0];
//       return LayoutBuilder(
//         builder: (modal, constraints) {
//           return AnimatedPadding(
//             duration: const Duration(milliseconds: 100),
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(modal).viewInsets.bottom,
//             ),
//             child: Container(
//               decoration: const BoxDecoration(
//                 color: colorWhite,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(24),
//                   topRight: Radius.circular(24),
//                 ),
//               ),
//               padding: const EdgeInsets.all(16),
//               height: constraints.maxHeight * 0.3,
//               alignment: Alignment.center,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Chọn năm',
//                         style: context.textTheme.titleLarge,
//                       ),
//                       InkWell(
//                         child: const Text(
//                           'Xong',
//                         ),
//                         onTap: () {
//                           Navigator.of(context).pop();
//                           callback(itemSelected);
//                         },
//                       )
//                     ],
//                   ),
//                   Expanded(
//                     child: ListWheelScrollView(
//                       itemExtent: 42,
//                       useMagnifier: true,
//                       magnification: 1.5,
//                       children: list.map((e) => Text(e.toString())).toList(),
//                       onSelectedItemChanged: (value) {
//                         itemSelected = list[value];
//                       },
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     },
//   );
// }

// Future<String> changeFileNameOnly(String filePath) async {
//   final file = File(filePath);
//   if (file.existsSync()) {
//     final uuid = const Uuid().v1();
//     final fileName = '$uuid.jpg';
//     final content = await file.readAsBytes();
//     final localPath = await _getTemporaryDirectory();
//     final fileLocation = File('$localPath/$fileName');
//     final newFile = await fileLocation.writeAsBytes(content);
//     return newFile.path;
//   }
//   throw Exception(['Could not rename file']);
// }

// Future<String> _getTemporaryDirectory() async {
//   final tempDir = await getTemporaryDirectory();
//   return tempDir.path;
// }

// Future<void> showDialogDatePicker({
//   required BuildContext context,
//   DateTime? min,
//   DateTime? max,
//   DateTime? selected,
//   CupertinoDatePickerMode mode = CupertinoDatePickerMode.date,
//   String? title,
//   required void Function(DateTime datetime) callback,
// }) async {
//   context.hideKeyboard();
//   var minDate = min?.toDay;
//   final now = DateTime.now();
//   var date = selected != null
//       ? DateTime(
//           selected.year,
//           selected.month,
//           selected.day,
//         ) // to set hour, second,.. to zero to avoid wrong compare
//       : DateTime(now.year, now.month, now.day);

//   if (minDate != null && date.isBefore(minDate)) {
//     minDate = date;
//   }

//   final maxDate = max != null
//       ? DateTime(
//           max.year,
//           max.month,
//           max.day,
//         ) // to set hour, second,.. to zero to avoid wrong compare
//       : null;
//   await showCupertinoModalPopup<void>(
//     context: context,
//     builder: (c) {
//       return ClipRRect(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(16),
//           topRight: Radius.circular(16),
//         ),
//         child: Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(16),
//               topRight: Radius.circular(16),
//             ),
//           ),
//           width: MediaQuery.of(context).size.width,
//           height: 320,
//           child: CupertinoApp(
//             supportedLocales: const [Locale('vi', 'VN')],
//             debugShowCheckedModeBanner: false,
//             localizationsDelegates: const [
//               GlobalMaterialLocalizations.delegate,
//               GlobalWidgetsLocalizations.delegate,
//               GlobalCupertinoLocalizations.delegate,
//             ],
//             home: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 8,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(c);
//                         },
//                         child: const Text(
//                           'Hủy',
//                           style: TextStyle(
//                             color: colorError03,
//                           ),
//                         ),
//                       ),
//                       Text(
//                         title ?? 'Chọn thời gian',
//                         style: context.textTheme.titleMedium,
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(c).pop();
//                           callback(date);
//                         },
//                         child: const Text(
//                           'Xong',
//                           style: TextStyle(
//                             color: colorPrimary03,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: CupertinoTheme(
//                     data: const CupertinoThemeData(
//                       textTheme: CupertinoTextThemeData(
//                         dateTimePickerTextStyle:
//                             TextStyle(fontSize: 18, color: Colors.black),
//                       ),
//                     ),
//                     child: CupertinoDatePicker(
//                       initialDateTime: date,
//                       minimumDate: minDate,
//                       maximumDate: maxDate,
//                       mode: mode,
//                       use24hFormat: true,
//                       // This is called when the user changes the date.
//                       onDateTimeChanged: (DateTime newDate) {
//                         date = newDate;
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

// Future<void> showDialogTimerPicker({
//   required BuildContext context,
//   DateTime? selected,
//   String? title,
//   required void Function(int hours, int minutes) callback,
// }) async {
//   context.hideKeyboard();
//   final now = DateTime.now();
//   var duration = selected != null
//       ? Duration(
//           hours: selected.hour,
//           minutes: selected
//               .minute) // to set hour, second,.. to zero to avoid wrong compare
//       : Duration(hours: now.hour, minutes: now.minute);
//   await showCupertinoModalPopup<void>(
//     context: context,
//     builder: (c) {
//       return ClipRRect(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(16),
//           topRight: Radius.circular(16),
//         ),
//         child: Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(16),
//               topRight: Radius.circular(16),
//             ),
//           ),
//           width: MediaQuery.of(context).size.width,
//           height: 320,
//           child: CupertinoApp(
//             supportedLocales: const [Locale('vi', 'VN')],
//             debugShowCheckedModeBanner: false,
//             localizationsDelegates: const [
//               GlobalMaterialLocalizations.delegate,
//               GlobalWidgetsLocalizations.delegate,
//               GlobalCupertinoLocalizations.delegate,
//             ],
//             home: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 8,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(c);
//                         },
//                         child: const Text(
//                           'Hủy',
//                           style: TextStyle(
//                             color: colorError03,
//                           ),
//                         ),
//                       ),
//                       Text(
//                         title ?? 'Chọn thời gian',
//                         style: context.textTheme.titleMedium,
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(c).pop();
//                           callback(duration.inHours, duration.inMinutes % 60);
//                         },
//                         child: const Text(
//                           'Xong',
//                           style: TextStyle(
//                             color: colorPrimary03,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: CupertinoTheme(
//                     data: const CupertinoThemeData(
//                       textTheme: CupertinoTextThemeData(
//                         pickerTextStyle:
//                             TextStyle(fontSize: 18, color: Colors.black),
//                       ),
//                     ),
//                     child: CupertinoTimerPicker(
//                       initialTimerDuration: duration,
//                       mode: CupertinoTimerPickerMode.hm,
//                       onTimerDurationChanged: (Duration newDuration) {
//                         duration = newDuration;
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
