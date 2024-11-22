import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'all_comment_response_data.g.dart';

AllCommentResponseData allCommentResponseDataFromJson(String str) =>
    AllCommentResponseData.fromJson(json.decode(str));

String allCommentResponseDataToJson(AllCommentResponseData data) =>
    json.encode(data.toJson());

@JsonSerializable()
class AllCommentResponseData {
  @JsonKey(name: "commentsData")
  List<CommentsDatum>? commentsData;

  AllCommentResponseData({
    this.commentsData,
  });

  factory AllCommentResponseData.fromJson(Map<String, dynamic> json) =>
      _$AllCommentResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$AllCommentResponseDataToJson(this);
}

@JsonSerializable()
class CommentsDatum {
  @JsonKey(name: "content")
  String? content;
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "posted_at")
  DateTime? postedAt;
  @JsonKey(name: "project_id")
  dynamic projectId;
  @JsonKey(name: "task_id")
  String? taskId;
  @JsonKey(name: "attachment")
  Attachment? attachment;

  CommentsDatum({
    this.content,
    this.id,
    this.postedAt,
    this.projectId,
    this.taskId,
    this.attachment,
  });

  factory CommentsDatum.fromJson(Map<String, dynamic> json) =>
      _$CommentsDatumFromJson(json);

  Map<String, dynamic> toJson() => _$CommentsDatumToJson(this);
}

@JsonSerializable()
class Attachment {
  @JsonKey(name: "file_name")
  String? fileName;
  @JsonKey(name: "file_type")
  String? fileType;
  @JsonKey(name: "file_url")
  String? fileUrl;
  @JsonKey(name: "resource_type")
  String? resourceType;

  Attachment({
    this.fileName,
    this.fileType,
    this.fileUrl,
    this.resourceType,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
}
