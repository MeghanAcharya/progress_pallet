import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'project_list_response_model.g.dart';

ProjectListResponseModel projectListResponseModelFromJson(String str) =>
    ProjectListResponseModel.fromJson(json.decode(str));

String projectListResponseModelToJson(ProjectListResponseModel data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ProjectListResponseModel {
  @JsonKey(name: "projects")
  List<Project>? projects;

  ProjectListResponseModel({
    this.projects,
  });

  factory ProjectListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectListResponseModelToJson(this);
}

@JsonSerializable()
class Project {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "comment_count")
  int? commentCount;
  @JsonKey(name: "order")
  int? order;
  @JsonKey(name: "color")
  String? color;
  @JsonKey(name: "is_shared")
  bool? isShared;
  @JsonKey(name: "is_favorite")
  bool? isFavorite;
  @JsonKey(name: "is_inbox_project")
  bool? isInboxProject;
  @JsonKey(name: "is_team_inbox")
  bool? isTeamInbox;
  @JsonKey(name: "view_style")
  String? viewStyle;
  @JsonKey(name: "url")
  String? url;
  @JsonKey(name: "parent_id")
  dynamic parentId;

  Project({
    this.id,
    this.name,
    this.commentCount,
    this.order,
    this.color,
    this.isShared,
    this.isFavorite,
    this.isInboxProject,
    this.isTeamInbox,
    this.viewStyle,
    this.url,
    this.parentId,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
