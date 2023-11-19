// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanModel _$ScanModelFromJson(Map<String, dynamic> json) => ScanModel(
      id: json['id'] as int?,
      qrCodeData: json['qrCodeData'] as String,
      createdAt: const DateTimeConverterFromString()
          .fromJson(json['createdAt'] as String),
    );

Map<String, dynamic> _$ScanModelToJson(ScanModel instance) => <String, dynamic>{
      'id': instance.id,
      'qrCodeData': instance.qrCodeData,
      'createdAt':
          const DateTimeConverterFromString().toJson(instance.createdAt),
    };
