import 'package:dartz/dartz.dart';
import 'package:progresspallet/domain/entities/error/server_exception.dart';
import 'package:progresspallet/feature/task/data/model/add_task/add_task_request_data.dart';
import 'package:progresspallet/feature/task/data/model/task_list_response_model.dart';
import 'package:progresspallet/feature/task/data/repository/task_repository.dart';

class EditTaskUsecase {
  const EditTaskUsecase(this.repository);

  final TaskScreenRepository repository;

  Future<Either<ServerException, TaskData>> call(AddTaskRequestData data) =>
      repository.editTaskRequest(data);
}
