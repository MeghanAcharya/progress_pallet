import 'package:dartz/dartz.dart';
import 'package:progresspallet/domain/entities/error/server_exception.dart';
import 'package:progresspallet/feature/task/data/model/task_list_response_model.dart';
import 'package:progresspallet/feature/task_detail/data/repository/task_detail_repository.dart';

class GetTaskDetailUsecase {
  const GetTaskDetailUsecase(this.repository);

  final TaskDetailScreenRepository repository;

  Future<Either<ServerException, TaskData>> call(String id) =>
      repository.getTaskDetail(id);
}
