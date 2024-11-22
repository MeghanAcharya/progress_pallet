import 'dart:convert';

AddCommentRequestData addCommentRequestDataFromJson(String str) =>
    AddCommentRequestData.fromJson(json.decode(str));

String addCommentRequestDataToJson(AddCommentRequestData data) =>
    json.encode(data.toJson());

class AddCommentRequestData {
  String? taskId;
  String? content;
  Attachment? attachment;

  AddCommentRequestData({
    this.taskId,
    this.content,
    this.attachment,
  });

  factory AddCommentRequestData.fromJson(Map<String, dynamic> json) =>
      AddCommentRequestData(
        taskId: json["task_id"],
        content: json["content"],
        attachment: json["attachment"] == null
            ? null
            : Attachment.fromJson(json["attachment"]),
      );

  Map<String, dynamic> toJson() => {
        "task_id": taskId,
        "content": content,
        "attachment": attachment?.toJson(),
      };
}

class Attachment {
  String? resourceType;
  String? fileUrl;
  String? fileType;
  String? fileName;

  Attachment({
    this.resourceType,
    this.fileUrl,
    this.fileType,
    this.fileName,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        resourceType: json["resource_type"],
        fileUrl: json["file_url"],
        fileType: json["file_type"],
        fileName: json["file_name"],
      );

  Map<String, dynamic> toJson() => {
        "resource_type": resourceType,
        "file_url": fileUrl,
        "file_type": fileType,
        "file_name": fileName,
      };
}
