import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:progresspallet/feature/task/data/model/add_task/add_task_request_data.dart';

abstract class TaskScreenEvent extends Equatable {
  const TaskScreenEvent();

  @override
  List<Object> get props => [];
}

class TaskDataFetchEvent extends TaskScreenEvent {
  final String? projectId;
  const TaskDataFetchEvent(this.projectId);

  @override
  List<Object> get props => [];
}

class AddTaskEvent extends TaskScreenEvent {
  final AddTaskRequestData? requestData;
  const AddTaskEvent(this.requestData);

  @override
  List<Object> get props => [];
}

class DropdownStateUpdateEvent extends TaskScreenEvent {
  final String? selectedData;
  const DropdownStateUpdateEvent(this.selectedData);

  @override
  List<Object> get props => [];
}

class DatePickEvent extends TaskScreenEvent {
  final BuildContext context;
  const DatePickEvent(this.context);

  @override
  List<Object> get props => [];
}

class EditTaskEvent extends TaskScreenEvent {
  final AddTaskRequestData? requestData;
  const EditTaskEvent(this.requestData);

  @override
  List<Object> get props => [];
}
