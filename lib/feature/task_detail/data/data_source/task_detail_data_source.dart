import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:progresspallet/constants/app_strings.dart';
import 'package:progresspallet/core/logs.dart';

import 'package:progresspallet/domain/entities/error/server_exception.dart';
import 'package:progresspallet/domain/network_utils.dart/app_end_points.dart';
import 'package:progresspallet/feature/task/data/model/task_list_response_model.dart';
import 'package:progresspallet/feature/task_detail/data/model/comment/add_Comment_request_data.dart';
import 'package:progresspallet/feature/task_detail/data/model/comment/all_comment_request_data.dart';
import 'package:progresspallet/feature/task_detail/data/model/comment/all_comment_response_data.dart';

abstract class TaskDetailRemoteDataSource {
  Future<Either<ServerException, TaskData>> getTaskDetail(String taskId);
  Future<Either<ServerException, AllCommentResponseData>> getAllCommentsForTask(
      AllCommentRequestData requestData);
  Future<Either<ServerException, CommentsDatum>> postCommentForTaskRequest(
      AddCommentRequestData requestData);
}

class TaskDetailRemoteDataSourceImpl implements TaskDetailRemoteDataSource {
  TaskDetailRemoteDataSourceImpl({
    required this.dio,
  });

  final Dio dio;

  Future<Options> createDioOptions() async {
    String? token = AppStrings.bearerToken;
    Map<String, String> tokanInfo = {};
    if (token.trim().isNotEmpty) {
      tokanInfo = {'Authorization': 'Bearer $token'};
    }

    return Options(headers: tokanInfo);
  }

  @override
  Future<Either<ServerException, TaskData>> getTaskDetail(String taskId) async {
    try {
      final uri =
          AppEndPoints.getRequestUrl("${AppEndPoints.getTaskDetail}$taskId");

      final response = await dio.getUri(
        uri,
        options: await createDioOptions(),
      );

      if (response.statusCode! < 300) {
        printMessage('${response.realUri}');
        printMessage('${response.requestOptions.data}');

        TaskData responseData = TaskData.fromJson(response.data);

        return Right(responseData);
      } else {
        throw ServerException(
          code: response.statusCode,
          message: response.statusMessage ?? response.toString(),
        );
      }
    } on DioException catch (e) {
      return Left(
        ServerException(
          code: e.response?.statusCode ?? 500,
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<Either<ServerException, AllCommentResponseData>> getAllCommentsForTask(
      AllCommentRequestData requestData) async {
    try {
      final uri = AppEndPoints.getRequestUrl(
        AppEndPoints.getAllComments,
        queryParams: requestData.toJson(),
      );

      final response = await dio.getUri(
        uri,
        options: await createDioOptions(),
      );

      if (response.statusCode! < 300) {
        printMessage('${response.realUri}');
        printMessage('${response.requestOptions.data}');

        AllCommentResponseData responseData =
            AllCommentResponseData.fromJson({"commentsData": response.data});

        return Right(responseData);
      } else {
        throw ServerException(
          code: response.statusCode,
          message: response.statusMessage ?? response.toString(),
        );
      }
    } on DioException catch (e) {
      return Left(
        ServerException(
          code: e.response?.statusCode ?? 500,
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<Either<ServerException, CommentsDatum>> postCommentForTaskRequest(
      AddCommentRequestData requestData) async {
    try {
      Map<String, dynamic> requestModel = requestData.toJson()
        ..removeWhere((key, value) => (value?.toString() ?? "").trim().isEmpty);
      final uri = AppEndPoints.getRequestUrl(AppEndPoints.postComment);

      final response = await dio.postUri(
        uri,
        options: await createDioOptions(),
        data: requestModel,
      );

      if (response.statusCode! < 300) {
        printMessage('${response.realUri}');
        printMessage('${response.requestOptions.data}');

        CommentsDatum responseData = CommentsDatum.fromJson(response.data);

        return Right(responseData);
      } else {
        throw ServerException(
          code: response.statusCode,
          message: response.statusMessage ?? response.toString(),
        );
      }
    } on DioException catch (e) {
      return Left(
        ServerException(
          code: e.response?.statusCode ?? 500,
          message: e.message,
        ),
      );
    }
  }
}
