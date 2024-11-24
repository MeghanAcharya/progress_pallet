import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresspallet/constants/analytics_key_constats.dart';
import 'package:progresspallet/core/logs.dart';
import 'package:progresspallet/domain/usecases/add_task_usecase.dart';
import 'package:progresspallet/domain/usecases/edit_task_usecase.dart';
import 'package:progresspallet/domain/usecases/get_task_list_usecase.dart';
import 'package:progresspallet/feature/task/bloc/task_event.dart';

import 'package:progresspallet/feature/task/bloc/task_state.dart';
import 'package:progresspallet/feature/task/data/data_source/task_local_data_source.dart';
import 'package:progresspallet/feature/task/data/model/add_task/add_task_request_data.dart';
import 'package:progresspallet/feature/task/data/model/task_list_response_model.dart';
import 'package:progresspallet/utils/app_utils.dart';
import 'package:progresspallet/utils/firebase_analytics_utils.dart';

class TaskListScreenBloc extends Bloc<TaskScreenEvent, TaskListScreenState> {
  GetTaskListUsecase getTaskListUsecase;
  AddTaskUsecase addTaskUsecase;
  EditTaskUsecase editTaskUsecase;
  TaskListScreenBloc({
    required this.getTaskListUsecase,
    required this.addTaskUsecase,
    required this.editTaskUsecase,
  }) : super(TaskScreenInitial()) {
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
            for (int i = 0; i < (r.tasks?.length ?? 0); i++) {
              TaskData? data = await TaskLocalDataSource()
                  .getTaskDetail(r.tasks?[i].id ?? "");

              r.tasks?[i].status = data?.status;
              r.tasks?[i].startTime = data?.startTime;
              r.tasks?[i].endTime = data?.endTime;
            }
            emit(TaskScreenSuccess(r));
          },
        );
      } catch (error, _) {
        printMessage(error.toString());
        emit(TaskScreenError(error.toString()));
      }
    } else if (event is AddTaskEvent) {
      AnalyticsUtils().logEvent(name: AppAnalyticsKey.addTask);
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
    } else if (event is DropdownStateUpdateEvent) {
      emit(TaskScreenLoading());
      emit(ScreenStateUpdate());
    } else if (event is DatePickEvent) {
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
    } else if (event is EditTaskEvent) {
      AnalyticsUtils().logEvent(name: AppAnalyticsKey.editTask);
      emit(TaskScreenLoading());
      try {
        final model = await editTaskUsecase
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
  }
}
