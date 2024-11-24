import 'package:equatable/equatable.dart';
import 'package:progresspallet/feature/task/data/model/task_list_response_model.dart';
import 'package:progresspallet/feature/task_detail/data/model/comment/add_Comment_request_data.dart';
import 'package:progresspallet/feature/task_detail/data/model/comment/all_comment_request_data.dart';

abstract class TaskDetailScreenEvent extends Equatable {
  const TaskDetailScreenEvent();

  @override
  List<Object> get props => [];
}

class TaskDetailDataFetchEvent extends TaskDetailScreenEvent {
  final String? taskId;
  const TaskDetailDataFetchEvent(this.taskId);

  @override
  List<Object> get props => [];
}

class TaskCommentsDataFetchEvent extends TaskDetailScreenEvent {
  final AllCommentRequestData? requestData;
  const TaskCommentsDataFetchEvent(this.requestData);

  @override
  List<Object> get props => [];
}

class AddTaskCommentsDataEvent extends TaskDetailScreenEvent {
  final AddCommentRequestData? requestData;
  const AddTaskCommentsDataEvent(this.requestData);

  @override
  List<Object> get props => [];
}

class DropDownSelectionEvent extends TaskDetailScreenEvent {
  const DropDownSelectionEvent();

  @override
  List<Object> get props => [];
}

class SaveTaskStateEvent extends TaskDetailScreenEvent {
  final TaskData updateData;

  const SaveTaskStateEvent(this.updateData);

  @override
  List<Object> get props => [];
}
