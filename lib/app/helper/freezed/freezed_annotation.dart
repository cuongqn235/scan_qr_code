import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

const jsonApiResponse =
    JsonSerializable(createToJson: false, explicitToJson: true);
const jsonApiResquest =
    JsonSerializable(explicitToJson: true, createFactory: false);
// const freezedSqfileEntity = freezed;
// const freezedApiResponse = Freezed(
//   fromJson: true,
//   toJson: false,
//   copyWith: false,
// );
// const freezedApiRequest = Freezed(
//   fromJson: false,
//   toJson: true,
//   copyWith: false,
// );
// const freezedBlocState = Freezed(fromJson: false, toJson: false);
// const freezedBlocEvent = Freezed(
//   copyWith: false,
//   toStringOverride: false,
//   fromJson: false,
//   toJson: false,
//   genericArgumentFactories: false,
//   makeCollectionsUnmodifiable: false,
//   map: FreezedMapOptions(map: false, mapOrNull: false, maybeMap: false),
//   equal: true,
//   when: FreezedWhenOptions(
//     when: false,
//     maybeWhen: false,
//     whenOrNull: false,
//   ),
// );
// const freezedFailure = Freezed(
//   copyWith: false,
//   toStringOverride: false,
//   fromJson: false,
//   toJson: false,
//   genericArgumentFactories: false,
//   makeCollectionsUnmodifiable: false,
//   equal: false,
// );

class DateTimeConverterFromString implements JsonConverter<DateTime, String> {
  const DateTimeConverterFromString();

  @override
  DateTime fromJson(String dateTime) {
    return DateTime.parse(dateTime).toLocal();
  }

  @override
  String toJson(DateTime date) {
    return date.toUtc().toIso8601String();
  }
}

class DateTimeOrNullConverterFromString
    implements JsonConverter<DateTime?, String?> {
  const DateTimeOrNullConverterFromString();

  @override
  DateTime? fromJson(String? dateTime) {
    return dateTime != null ? DateTime.parse(dateTime).toLocal() : null;
  }

  @override
  String? toJson(DateTime? date) => date?.toUtc().toIso8601String();
}

// /// Convert to UTC format
// class DateTimeAsUTC implements JsonConverter<DateTime, String> {
//   const DateTimeAsUTC();
//   @override
//   DateTime fromJson(String dateTime) {
//     return DateTime.parse(dateTime);
//   }

//   @override
//   String toJson(DateTime date) {
//     return date.asUtc.toIso8601String();
//   }
// }

// class DateTimeOrNullAsUTC implements JsonConverter<DateTime?, String?> {
//   const DateTimeOrNullAsUTC();

//   @override
//   DateTime? fromJson(String? dateTime) {
//     if (dateTime == null) {
//       return null;
//     }
//     final date = DateTime.parse(dateTime);
//     return DateTime(date.year, date.month, date.day, date.hour, date.minute,
//         date.second, date.millisecond, date.microsecond);
//   }

//   @override
//   String? toJson(DateTime? date) {
//     final string = date?.asUtc.toIso8601String();
//     return string;
//   }
// }

class ColorConverterFromString implements JsonConverter<Color, String> {
  const ColorConverterFromString();

  @override
  Color fromJson(String strColor) {
    return Color(int.parse(strColor));
  }

  @override
  String toJson(Color color) {
    return color.value.toString();
  }
}
