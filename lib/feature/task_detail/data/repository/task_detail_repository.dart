import 'package:progresspallet/domain/entities/error/server_exception.dart';
import 'package:dartz/dartz.dart';

import 'package:progresspallet/feature/task/data/model/task_list_response_model.dart';
import 'package:progresspallet/feature/task_detail/data/data_source/task_detail_data_source.dart';
import 'package:progresspallet/feature/task_detail/data/model/comment/add_Comment_request_data.dart';
import 'package:progresspallet/feature/task_detail/data/model/comment/all_comment_request_data.dart';
import 'package:progresspallet/feature/task_detail/data/model/comment/all_comment_response_data.dart';

abstract class TaskDetailScreenRepository {
  Future<Either<ServerException, TaskData>> getTaskDetail(String taskId);
  Future<Either<ServerException, AllCommentResponseData>> getAllCommentsForTask(
      AllCommentRequestData requestData);
  Future<Either<ServerException, CommentsDatum>> postCommentForTaskRequest(
      AddCommentRequestData requestData);
}

class TaskDetailScreenRepositoryImpl extends TaskDetailScreenRepository {
  TaskDetailScreenRepositoryImpl({
    required this.remoteDataSource,
  });

  final TaskDetailRemoteDataSource remoteDataSource;

  @override
  Future<Either<ServerException, TaskData>> getTaskDetail(String taskId) async {
    try {
      return await remoteDataSource.getTaskDetail(taskId);
    } on ServerException catch (ex) {
      return Left(ServerException(code: ex.code, message: ex.message));
    } on Exception catch (e) {
      return Left(ServerException(code: 502, message: e.toString()));
    }
  }

  @override
  Future<Either<ServerException, AllCommentResponseData>> getAllCommentsForTask(
      AllCommentRequestData requestData) async {
    try {
      return await remoteDataSource.getAllCommentsForTask(requestData);
    } on ServerException catch (ex) {
      return Left(ServerException(code: ex.code, message: ex.message));
    } on Exception catch (e) {
      return Left(ServerException(code: 502, message: e.toString()));
    }
  }

  @override
  Future<Either<ServerException, CommentsDatum>> postCommentForTaskRequest(
      AddCommentRequestData requestData) async {
    try {
      return await remoteDataSource.postCommentForTaskRequest(requestData);
    } on ServerException catch (ex) {
      return Left(ServerException(code: ex.code, message: ex.message));
    } on Exception catch (e) {
      return Left(ServerException(code: 502, message: e.toString()));
    }
  }
}
