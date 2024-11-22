import 'package:progresspallet/domain/entities/error/server_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:progresspallet/feature/dashboard/data/model/project_list/project_list_response_model.dart';
import 'package:progresspallet/feature/dashboard/data/remote_data_source/dashboard_data_source.dart';

abstract class DashboardScreenRepository {
  Future<Either<ServerException, ProjectListResponseModel>>
      getAllMyProjectsRequest();
}

class DashboardScreenRepositoryImpl extends DashboardScreenRepository {
  DashboardScreenRepositoryImpl({
    required this.remoteDataSource,
  });

  final DashboardRemoteDataSource remoteDataSource;

  @override
  Future<Either<ServerException, ProjectListResponseModel>>
      getAllMyProjectsRequest() async {
    try {
      return await remoteDataSource.getAllMyProjectsRequest();
    } on ServerException catch (ex) {
      return Left(ServerException(code: ex.code, message: ex.message));
    } on Exception catch (e) {
      return Left(ServerException(code: 502, message: e.toString()));
    }
  }
}
