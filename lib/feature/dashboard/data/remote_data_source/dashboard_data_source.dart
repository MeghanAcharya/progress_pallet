import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:progresspallet/constants/app_strings.dart';
import 'package:progresspallet/core/logs.dart';

import 'package:progresspallet/domain/entities/error/server_exception.dart';
import 'package:progresspallet/domain/network_utils.dart/app_end_points.dart';
import 'package:progresspallet/feature/dashboard/data/model/project_list/project_list_response_model.dart';

abstract class DashboardRemoteDataSource {
  Future<Either<ServerException, ProjectListResponseModel>>
      getAllMyProjectsRequest();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  DashboardRemoteDataSourceImpl({
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
  Future<Either<ServerException, ProjectListResponseModel>>
      getAllMyProjectsRequest() async {
    try {
      final uri = AppEndPoints.getRequestUrl(AppEndPoints.getAllProjects);

      final response = await dio.getUri(
        uri,
        options: await createDioOptions(),
      );

      if (response.statusCode! < 300) {
        printMessage('${response.realUri}');
        printMessage('${response.requestOptions.data}');

        ProjectListResponseModel responseData =
            ProjectListResponseModel.fromJson({"projects": response.data});

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
          message: "",
        ),
      );
    }
  }
}
