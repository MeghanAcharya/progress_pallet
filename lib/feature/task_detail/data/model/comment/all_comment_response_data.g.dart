// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_comment_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllCommentResponseData _$AllCommentResponseDataFromJson(
        Map<String, dynamic> json) =>
    AllCommentResponseData(
      commentsData: (json['commentsData'] as List<dynamic>?)
          ?.map((e) => CommentsDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllCommentResponseDataToJson(
        AllCommentResponseData instance) =>
    <String, dynamic>{
      'commentsData': instance.commentsData,
    };

CommentsDatum _$CommentsDatumFromJson(Map<String, dynamic> json) =>
    CommentsDatum(
      content: json['content'] as String?,
      id: json['id'] as String?,
      postedAt: json['posted_at'] == null
          ? null
          : DateTime.parse(json['posted_at'] as String),
      projectId: json['project_id'],
      taskId: json['task_id'] as String?,
      attachment: json['attachment'] == null
          ? null
          : Attachment.fromJson(json['attachment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentsDatumToJson(CommentsDatum instance) =>
    <String, dynamic>{
      'content': instance.content,
      'id': instance.id,
      'posted_at': instance.postedAt?.toIso8601String(),
      'project_id': instance.projectId,
      'task_id': instance.taskId,
      'attachment': instance.attachment,
    };

Attachment _$AttachmentFromJson(Map<String, dynamic> json) => Attachment(
      fileName: json['file_name'] as String?,
      fileType: json['file_type'] as String?,
      fileUrl: json['file_url'] as String?,
      resourceType: json['resource_type'] as String?,
    );

Map<String, dynamic> _$AttachmentToJson(Attachment instance) =>
    <String, dynamic>{
      'file_name': instance.fileName,
      'file_type': instance.fileType,
      'file_url': instance.fileUrl,
      'resource_type': instance.resourceType,
    };
