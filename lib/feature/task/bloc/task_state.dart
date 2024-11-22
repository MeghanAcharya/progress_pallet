import 'package:equatable/equatable.dart';
import 'package:progresspallet/feature/task/data/model/task_list_response_model.dart';

abstract class TaskListScreenState extends Equatable {
  const TaskListScreenState();

  @override
  List<Object> get props => [];
}

class TaskScreenInitial extends TaskListScreenState {}

class TaskScreenLoading extends TaskListScreenState {}

class TaskScreenSuccess extends TaskListScreenState {
  final TaskListResponseModel? model;
  const TaskScreenSuccess(this.model);

  @override
  List<Object> get props => [];
}

class TaskScreenError extends TaskListScreenState {
  const TaskScreenError(this.message);
  final String? message;

  @override
  List<Object> get props => [];
}

class AddTaskSuccess extends TaskListScreenState {}

class ScreenStateChange extends TaskListScreenState {}

class ScreenStateUpdate extends TaskListScreenState {}
