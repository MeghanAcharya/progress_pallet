import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresspallet/core/logs.dart';
import 'package:progresspallet/domain/usecases/get_task_comments_usecase.dart';
import 'package:progresspallet/domain/usecases/get_task_detail_usecase.dart';
import 'package:progresspallet/domain/usecases/post_comment_usecase.dart';
import 'package:progresspallet/feature/task_detail/bloc/task_detail_event.dart';
import 'package:progresspallet/feature/task_detail/bloc/task_detail_state.dart';
import 'package:progresspallet/feature/task_detail/data/model/comment/add_Comment_request_data.dart';
import 'package:progresspallet/feature/task_detail/data/model/comment/all_comment_request_data.dart';

class TaskDetailScreenBloc
    extends Bloc<TaskDetailScreenEvent, TaskDetailScreenState> {
  GetTaskDetailUsecase getTaskDetailUsecase;
  GetTaskCommentsUsecase getTaskCommentsUsecase;
  PostCommentsUsecase postCommentsUsecase;
  TaskDetailScreenBloc({
    required this.getTaskDetailUsecase,
    required this.getTaskCommentsUsecase,
    required this.postCommentsUsecase,
  }) : super(TaskDetailScreenInitial()) {
    on<TaskDetailScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      TaskDetailScreenEvent event, Emitter<TaskDetailScreenState> emit) async {
    if (event is TaskDetailDataFetchEvent) {
      emit(TaskDetailScreenLoading());
      try {
        final model = await getTaskDetailUsecase.call(event.taskId ?? "");
        return model.fold(
          (l) async {
            emit(TaskDetailScreenError(l.message));
          },
          (r) async {
            emit(TaskDetailScreenSuccess(r));
          },
        );
      } catch (error, _) {
        printMessage(error.toString());
        emit(TaskDetailScreenError(error.toString()));
      }
    } else if (event is TaskCommentsDataFetchEvent) {
      emit(TaskDetailScreenLoading());
      try {
        final model = await getTaskCommentsUsecase
            .call(event.requestData ?? AllCommentRequestData());
        return model.fold(
          (l) async {
            emit(TaskDetailScreenError(l.message));
          },
          (r) async {
            emit(TaskCommentScreenSuccess(r));
          },
        );
      } catch (error, _) {
        printMessage(error.toString());
        emit(TaskDetailScreenError(error.toString()));
      }
    } else if (event is AddTaskCommentsDataEvent) {
      emit(TaskDetailScreenLoading());
      try {
        final model = await postCommentsUsecase
            .call(event.requestData ?? AddCommentRequestData());
        return model.fold(
          (l) async {
            emit(TaskDetailScreenError(l.message));
          },
          (r) async {
            emit(TaskAddCommentSuccess(r));
          },
        );
      } catch (error, _) {
        printMessage(error.toString());
        emit(TaskDetailScreenError(error.toString()));
      }
    }
  }
}
