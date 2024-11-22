import 'package:dartz/dartz.dart';
import 'package:progresspallet/domain/entities/error/server_exception.dart';
import 'package:progresspallet/feature/task_detail/data/model/comment/all_comment_request_data.dart';
import 'package:progresspallet/feature/task_detail/data/model/comment/all_comment_response_data.dart';
import 'package:progresspallet/feature/task_detail/data/repository/task_detail_repository.dart';

class GetTaskCommentsUsecase {
  const GetTaskCommentsUsecase(this.repository);

  final TaskDetailScreenRepository repository;

  Future<Either<ServerException, AllCommentResponseData>> call(
          AllCommentRequestData requestData) =>
      repository.getAllCommentsForTask(requestData);
}
