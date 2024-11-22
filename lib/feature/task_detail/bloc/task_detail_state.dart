import 'package:equatable/equatable.dart';
import 'package:progresspallet/feature/task/data/model/task_list_response_model.dart';
import 'package:progresspallet/feature/task_detail/data/model/comment/all_comment_response_data.dart';

abstract class TaskDetailScreenState extends Equatable {
  const TaskDetailScreenState();

  @override
  List<Object> get props => [];
}

class TaskDetailScreenInitial extends TaskDetailScreenState {}

class TaskDetailScreenLoading extends TaskDetailScreenState {}

class TaskDetailScreenSuccess extends TaskDetailScreenState {
  final TaskData? model;
  const TaskDetailScreenSuccess(this.model);

  @override
  List<Object> get props => [];
}

class TaskDetailScreenError extends TaskDetailScreenState {
  const TaskDetailScreenError(this.message);
  final String? message;

  @override
  List<Object> get props => [];
}

class TaskCommentScreenSuccess extends TaskDetailScreenState {
  final AllCommentResponseData? model;
  const TaskCommentScreenSuccess(this.model);

  @override
  List<Object> get props => [];
}

class TaskAddCommentSuccess extends TaskDetailScreenState {
  final CommentsDatum? model;
  const TaskAddCommentSuccess(this.model);

  @override
  List<Object> get props => [];
}
