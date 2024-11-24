// To parse this JSON data, do
//
//     final taskListResponseModel = taskListResponseModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'task_list_response_model.g.dart';

TaskListResponseModel taskListResponseModelFromJson(String str) =>
    TaskListResponseModel.fromJson(json.decode(str));

String taskListResponseModelToJson(TaskListResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class TaskListResponseModel {
  @JsonKey(name: "tasks")
  List<TaskData>? tasks;

  TaskListResponseModel({
    this.tasks,
  });

  factory TaskListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TaskListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskListResponseModelToJson(this);
}

@JsonSerializable()
class TaskData {
  @JsonKey(name: "creator_id")
  String? creatorId;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "assignee_id")
  String? assigneeId;
  @JsonKey(name: "assigner_id")
  String? assignerId;
  @JsonKey(name: "comment_count")
  int? commentCount;
  @JsonKey(name: "is_completed")
  bool? isCompleted;
  @JsonKey(name: "content")
  String? content;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "due")
  Due? due;
  @JsonKey(name: "duration")
  Duration? duration;
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "labels")
  List<String>? labels;
  @JsonKey(name: "order")
  int? order;
  @JsonKey(name: "priority")
  int? priority;
  @JsonKey(name: "project_id")
  String? projectId;
  @JsonKey(name: "section_id")
  String? sectionId;
  @JsonKey(name: "parent_id")
  String? parentId;
  @JsonKey(name: "url")
  String? url;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "start_time")
  DateTime? startTime;
  @JsonKey(name: "end_time")
  DateTime? endTime;

  TaskData({
    this.creatorId,
    this.createdAt,
    this.assigneeId,
    this.assignerId,
    this.commentCount,
    this.isCompleted,
    this.content,
    this.description,
    this.due,
    this.duration,
    this.id,
    this.labels,
    this.order,
    this.priority,
    this.projectId,
    this.sectionId,
    this.parentId,
    this.url,
  });

  factory TaskData.fromJson(Map<String, dynamic> json) =>
      _$TaskDataFromJson(json);

  Map<String, dynamic> toJson() => _$TaskDataToJson(this);

  Map<String, dynamic> localDbToJson() {
    return {
      'id': id,
      'content': content,
      'description': description,
      'priority': priority,
      'status': status,
      'start_time': startTime?.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
    };
  }
}

@JsonSerializable()
class Due {
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "is_recurring")
  bool? isRecurring;
  @JsonKey(name: "datetime")
  DateTime? datetime;
  @JsonKey(name: "string")
  String? string;
  @JsonKey(name: "timezone")
  String? timezone;

  Due({
    this.date,
    this.isRecurring,
    this.datetime,
    this.string,
    this.timezone,
  });

  factory Due.fromJson(Map<String, dynamic> json) => _$DueFromJson(json);

  Map<String, dynamic> toJson() => _$DueToJson(this);
}

@JsonSerializable()
class Duration {
  @JsonKey(name: "amount")
  int? amount;
  @JsonKey(name: "unit")
  String? unit;

  Duration({
    this.amount,
    this.unit,
  });

  factory Duration.fromJson(Map<String, dynamic> json) =>
      _$DurationFromJson(json);

  Map<String, dynamic> toJson() => _$DurationToJson(this);
}
