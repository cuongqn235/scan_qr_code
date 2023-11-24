// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScanModelImpl _$$ScanModelImplFromJson(Map<String, dynamic> json) =>
    _$ScanModelImpl(
      id: json['id'] as String,
      scanType: json['scanType'] as String,
      createdAt: const DateTimeConverterFromString()
          .fromJson(json['createdAt'] as String),
      qrData: json['qrData'] as String,
    );

Map<String, dynamic> _$$ScanModelImplToJson(_$ScanModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scanType': instance.scanType,
      'createdAt':
          const DateTimeConverterFromString().toJson(instance.createdAt),
      'qrData': instance.qrData,
    };
