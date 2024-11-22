import 'dart:convert';

AddTaskRequestData addTaskRequestDataFromJson(String str) =>
    AddTaskRequestData.fromJson(json.decode(str));

String addTaskRequestDataToJson(AddTaskRequestData data) =>
    json.encode(data.toJson());

class AddTaskRequestData {
  String? content;
  String? dueString;
  String? dueLang;
  int? priority;
  String? description;

  AddTaskRequestData({
    this.content,
    this.dueString,
    this.dueLang,
    this.priority,
    this.description,
  });

  factory AddTaskRequestData.fromJson(Map<String, dynamic> json) =>
      AddTaskRequestData(
        content: json["content"],
        dueString: json["due_string"],
        dueLang: json["due_lang"],
        priority: json["priority"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "due_string": dueString,
        "due_lang": dueLang,
        "priority": priority,
        "description": description,
      };
}
