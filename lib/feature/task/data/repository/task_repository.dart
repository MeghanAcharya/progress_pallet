import 'package:progresspallet/domain/entities/error/server_exception.dart';
import 'package:dartz/dartz.dart';

import 'package:progresspallet/feature/task/data/data_source/task_data_source.dart';
import 'package:progresspallet/feature/task/data/model/add_task/add_task_request_data.dart';
import 'package:progresspallet/feature/task/data/model/task_list_response_model.dart';

abstract class TaskScreenRepository {
  Future<Either<ServerException, TaskListResponseModel>> getTasksUnderProject(
      String projectId);
  Future<Either<ServerException, TaskData>> addTaskRequest(
      AddTaskRequestData requestData);
}

class TaskScreenRepositoryImpl extends TaskScreenRepository {
  TaskScreenRepositoryImpl({
    required this.remoteDataSource,
  });

  final TaskRemoteDataSource remoteDataSource;

  @override
  Future<Either<ServerException, TaskListResponseModel>> getTasksUnderProject(
      String projectId) async {
    try {
      return await remoteDataSource.getTasksUnderProject(projectId);
    } on ServerException catch (ex) {
      return Left(ServerException(code: ex.code, message: ex.message));
    } on Exception catch (e) {
      return Left(ServerException(code: 502, message: e.toString()));
    }
  }

  @override
  Future<Either<ServerException, TaskData>> addTaskRequest(
      AddTaskRequestData requestData) async {
    try {
      return await remoteDataSource.addTaskRequest(requestData);
    } on ServerException catch (ex) {
      return Left(ServerException(code: ex.code, message: ex.message));
    } on Exception catch (e) {
      return Left(ServerException(code: 502, message: e.toString()));
    }
  }
}
