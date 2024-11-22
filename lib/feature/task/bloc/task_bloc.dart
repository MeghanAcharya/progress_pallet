import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresspallet/core/logs.dart';
import 'package:progresspallet/domain/usecases/add_task_usecase.dart';
import 'package:progresspallet/domain/usecases/get_task_list_usecase.dart';
import 'package:progresspallet/feature/task/bloc/task_event.dart';

import 'package:progresspallet/feature/task/bloc/task_state.dart';
import 'package:progresspallet/feature/task/data/model/add_task/add_task_request_data.dart';
import 'package:progresspallet/utils/app_utils.dart';

class TaskListScreenBloc extends Bloc<TaskScreenEvent, TaskListScreenState> {
  GetTaskListUsecase getTaskListUsecase;
  AddTaskUsecase addTaskUsecase;
  TaskListScreenBloc(
      {required this.getTaskListUsecase, required this.addTaskUsecase})
      : super(TaskScreenInitial()) {
    on<TaskScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      TaskScreenEvent event, Emitter<TaskListScreenState> emit) async {
    if (event is TaskDataFetchEvent) {
      emit(TaskScreenLoading());
      try {
        final model = await getTaskListUsecase.call(event.projectId ?? "");
        return model.fold(
          (l) async {
            emit(TaskScreenError(l.message));
          },
          (r) async {
            emit(TaskScreenSuccess(r));
          },
        );
      } catch (error, _) {
        printMessage(error.toString());
        emit(TaskScreenError(error.toString()));
      }
    }
    if (event is AddTaskEvent) {
      emit(TaskScreenLoading());
      try {
        final model = await addTaskUsecase
            .call(event.requestData ?? AddTaskRequestData());
        return model.fold(
          (l) async {
            emit(TaskScreenError(l.message));
          },
          (r) async {
            emit(AddTaskSuccess());
          },
        );
      } catch (error, _) {
        printMessage(error.toString());
        emit(TaskScreenError(error.toString()));
      }
    }
    if (event is DropdownStateUpdateEvent) {
      emit(TaskScreenLoading());
      emit(ScreenStateUpdate());
    }
    if (event is DatePickEvent) {
      emit(TaskScreenLoading());
      try {
        if (event.context.mounted) {
          DateTime? selectedDate = await AppUtils.selectDate(event.context);
          emit(DateSelectedState(selectedDate));
        }
      } catch (error, _) {
        printMessage(error.toString());
        emit(TaskScreenError(error.toString()));
      }
    }
  }
}
