import 'package:dartz/dartz.dart';
import 'package:progresspallet/domain/entities/error/server_exception.dart';
import 'package:progresspallet/feature/task/data/model/task_list_response_model.dart';
import 'package:progresspallet/feature/task/data/repository/task_repository.dart';

class GetTaskListUsecase {
  const GetTaskListUsecase(this.repository);

  final TaskScreenRepository repository;

  Future<Either<ServerException, TaskListResponseModel>> call(String id) =>
      repository.getTasksUnderProject(id);
}
