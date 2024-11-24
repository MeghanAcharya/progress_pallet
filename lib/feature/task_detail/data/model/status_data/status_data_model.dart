// To parse this JSON data, do
//
//     final statusDataModel = statusDataModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'status_data_model.g.dart';

StatusDataModel statusDataModelFromJson(String str) =>
    StatusDataModel.fromJson(json.decode(str));

String statusDataModelToJson(StatusDataModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class StatusDataModel {
  @JsonKey(name: "statusData")
  List<StatusDatum>? statusData;

  StatusDataModel({
    this.statusData,
  });

  factory StatusDataModel.fromJson(Map<String, dynamic> json) =>
      _$StatusDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatusDataModelToJson(this);
}

@JsonSerializable()
class StatusDatum {
  @JsonKey(name: "statusCode")
  String? statusCode;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "statusKey")
  String? statusKey;

  StatusDatum({
    this.statusCode,
    this.status,
    this.statusKey,
  });

  factory StatusDatum.fromJson(Map<String, dynamic> json) =>
      _$StatusDatumFromJson(json);

  Map<String, dynamic> toJson() => _$StatusDatumToJson(this);
}
