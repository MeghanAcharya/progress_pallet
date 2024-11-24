// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusDataModel _$StatusDataModelFromJson(Map<String, dynamic> json) =>
    StatusDataModel(
      statusData: (json['statusData'] as List<dynamic>?)
          ?.map((e) => StatusDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StatusDataModelToJson(StatusDataModel instance) =>
    <String, dynamic>{
      'statusData': instance.statusData,
    };

StatusDatum _$StatusDatumFromJson(Map<String, dynamic> json) => StatusDatum(
      statusCode: json['statusCode'] as String?,
      status: json['status'] as String?,
      statusKey: json['statusKey'] as String?,
    );

Map<String, dynamic> _$StatusDatumToJson(StatusDatum instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'status': instance.status,
      'statusKey': instance.statusKey,
    };
