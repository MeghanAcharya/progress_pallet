import 'package:dartz/dartz.dart';
import 'package:progresspallet/domain/entities/error/server_exception.dart';
import 'package:progresspallet/feature/dashboard/data/model/project_list/project_list_response_model.dart';
import 'package:progresspallet/feature/dashboard/data/repository/dashboard_repository.dart';

class GetProjectUsecase {
  const GetProjectUsecase(this.repository);

  final DashboardScreenRepository repository;

  Future<Either<ServerException, ProjectListResponseModel>> call() =>
      repository.getAllMyProjectsRequest();
}
