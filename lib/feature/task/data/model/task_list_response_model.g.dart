// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskListResponseModel _$TaskListResponseModelFromJson(
        Map<String, dynamic> json) =>
    TaskListResponseModel(
      tasks: (json['tasks'] as List<dynamic>?)
          ?.map((e) => TaskData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskListResponseModelToJson(
        TaskListResponseModel instance) =>
    <String, dynamic>{
      'tasks': instance.tasks,
    };

TaskData _$TaskDataFromJson(Map<String, dynamic> json) => TaskData(
      creatorId: json['creator_id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      assigneeId: json['assignee_id'] as String?,
      assignerId: json['assigner_id'] as String?,
      commentCount: (json['comment_count'] as num?)?.toInt(),
      isCompleted: json['is_completed'] as bool?,
      content: json['content'] as String?,
      description: json['description'] as String?,
      due: json['due'] == null
          ? null
          : Due.fromJson(json['due'] as Map<String, dynamic>),
      duration: json['duration'] == null
          ? null
          : DurationData.fromJson(json['duration'] as Map<String, dynamic>),
      id: json['id'] as String?,
      labels:
          (json['labels'] as List<dynamic>?)?.map((e) => e as String).toList(),
      order: (json['order'] as num?)?.toInt(),
      priority: (json['priority'] as num?)?.toInt(),
      projectId: json['project_id'] as String?,
      sectionId: json['section_id'] as String?,
      parentId: json['parent_id'] as String?,
      url: json['url'] as String?,
    )
      ..status = json['status'] as String?
      ..startTime = json['start_time'] == null
          ? null
          : DateTime.parse(json['start_time'] as String)
      ..endTime = json['end_time'] == null
          ? null
          : DateTime.parse(json['end_time'] as String);

Map<String, dynamic> _$TaskDataToJson(TaskData instance) => <String, dynamic>{
      'creator_id': instance.creatorId,
      'created_at': instance.createdAt?.toIso8601String(),
      'assignee_id': instance.assigneeId,
      'assigner_id': instance.assignerId,
      'comment_count': instance.commentCount,
      'is_completed': instance.isCompleted,
      'content': instance.content,
      'description': instance.description,
      'due': instance.due,
      'duration': instance.duration,
      'id': instance.id,
      'labels': instance.labels,
      'order': instance.order,
      'priority': instance.priority,
      'project_id': instance.projectId,
      'section_id': instance.sectionId,
      'parent_id': instance.parentId,
      'url': instance.url,
      'status': instance.status,
      'start_time': instance.startTime?.toIso8601String(),
      'end_time': instance.endTime?.toIso8601String(),
    };

Due _$DueFromJson(Map<String, dynamic> json) => Due(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      isRecurring: json['is_recurring'] as bool?,
      datetime: json['datetime'] == null
          ? null
          : DateTime.parse(json['datetime'] as String),
      string: json['string'] as String?,
      timezone: json['timezone'] as String?,
    );

Map<String, dynamic> _$DueToJson(Due instance) => <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'is_recurring': instance.isRecurring,
      'datetime': instance.datetime?.toIso8601String(),
      'string': instance.string,
      'timezone': instance.timezone,
    };

DurationData _$DurationDataFromJson(Map<String, dynamic> json) => DurationData(
      amount: (json['amount'] as num?)?.toInt(),
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$DurationDataToJson(DurationData instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'unit': instance.unit,
    };
