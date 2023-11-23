import 'package:freezed_annotation/freezed_annotation.dart';

part 'status.freezed.dart';

abstract class StatusValue {
  dynamic get value;
}

@freezed
class Status with _$Status {
  const factory Status.idle() = StatusIdle;
  @Implements<StatusValue>()
  const factory Status.success({
    dynamic value,
    @Default(false) bool isCreated,
    @Default(false) bool isUpdated,
    @Default(false) bool isDeleted,
  }) = StatusSuccess;
  const factory Status.loading() = StatusLoading;
  @Implements<StatusValue>()
  const factory Status.failure({
    dynamic value,
  }) = StatusFailure;
}
