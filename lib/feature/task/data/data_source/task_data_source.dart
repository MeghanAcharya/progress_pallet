import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:progresspallet/constants/app_strings.dart';
import 'package:progresspallet/core/logs.dart';

import 'package:progresspallet/domain/entities/error/server_exception.dart';
import 'package:progresspallet/domain/network_utils.dart/app_end_points.dart';
import 'package:progresspallet/feature/task/data/data_source/task_local_data_source.dart';
import 'package:progresspallet/feature/task/data/model/add_task/add_task_request_data.dart';
import 'package:progresspallet/feature/task/data/model/task_list_response_model.dart';

abstract class TaskRemoteDataSource {
  Future<Either<ServerException, TaskListResponseModel>> getTasksUnderProject(
      String projectId);
  Future<Either<ServerException, TaskData>> addTaskRequest(
      AddTaskRequestData requestData);
  Future<Either<ServerException, TaskData>> editTaskRequest(
      AddTaskRequestData requestData);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  TaskRemoteDataSourceImpl({
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
  Future<Either<ServerException, TaskListResponseModel>> getTasksUnderProject(
      String projectId) async {
    try {
      final uri = AppEndPoints.getRequestUrl(AppEndPoints.getTasksUnderProject);

      final response = await dio.getUri(
        uri,
        options: await createDioOptions(),
      );

      if (response.statusCode! < 300) {
        printMessage('${response.realUri}');
        printMessage('${response.requestOptions.data}');

        TaskListResponseModel responseData =
            TaskListResponseModel.fromJson({"tasks": response.data});
        for (int i = 0; i < (responseData.tasks?.length ?? 0); i++) {
          await TaskLocalDataSource().upsertTask(responseData.tasks?[i].id,
              responseData.tasks?[i].localDbToJson());
        }

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
  Future<Either<ServerException, TaskData>> addTaskRequest(
      AddTaskRequestData requestData) async {
    try {
      Map<String, dynamic> requestModel = requestData.toJson()
        ..removeWhere((key, value) => (value?.toString() ?? "").trim().isEmpty);
      final uri = AppEndPoints.getRequestUrl(AppEndPoints.addTask);

      final response = await dio.postUri(
        uri,
        options: await createDioOptions(),
        data: requestModel,
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
  Future<Either<ServerException, TaskData>> editTaskRequest(
      AddTaskRequestData requestData) async {
    try {
      Map<String, dynamic> requestModel = requestData.toJson()
        ..removeWhere((key, value) => (value?.toString() ?? "").trim().isEmpty);
      final uri = AppEndPoints.getRequestUrl(
          AppEndPoints.editTask(requestData.id ?? ""));

      final response = await dio.postUri(
        uri,
        options: await createDioOptions(),
        data: requestModel,
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
}
