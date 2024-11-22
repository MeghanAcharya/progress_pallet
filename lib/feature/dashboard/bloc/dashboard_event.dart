import 'package:equatable/equatable.dart';

abstract class DashboardScreenEvent extends Equatable {
  const DashboardScreenEvent();

  @override
  List<Object> get props => [];
}

class DashboardDataFetchEvent extends DashboardScreenEvent {
  const DashboardDataFetchEvent();

  @override
  List<Object> get props => [];
}
