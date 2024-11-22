import 'package:equatable/equatable.dart';
import 'package:progresspallet/feature/dashboard/data/model/project_list/project_list_response_model.dart';

abstract class DashboardScreenState extends Equatable {
  const DashboardScreenState();

  @override
  List<Object> get props => [];
}

class DashboardScreenInitial extends DashboardScreenState {}

class DashboardScreenLoading extends DashboardScreenState {}

class DashboardScreenSuccess extends DashboardScreenState {
  final ProjectListResponseModel? model;
  const DashboardScreenSuccess(this.model);

  @override
  List<Object> get props => [];
}

class DashboardScreenError extends DashboardScreenState {
  const DashboardScreenError(this.message);
  final String? message;

  @override
  List<Object> get props => [];
}
