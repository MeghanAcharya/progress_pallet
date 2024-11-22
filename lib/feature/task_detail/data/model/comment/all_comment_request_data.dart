import 'dart:convert';

AllCommentRequestData allCommentRequestDataFromJson(String str) =>
    AllCommentRequestData.fromJson(json.decode(str));

String allCommentRequestDataToJson(AllCommentRequestData data) =>
    json.encode(data.toJson());

class AllCommentRequestData {
  String? taskId;

  AllCommentRequestData({
    this.taskId,
  });

  factory AllCommentRequestData.fromJson(Map<String, dynamic> json) =>
      AllCommentRequestData(
        taskId: json["task_id"],
      );

  Map<String, dynamic> toJson() => {
        "task_id": taskId,
      };
}
