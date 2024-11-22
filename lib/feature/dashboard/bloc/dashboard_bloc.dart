import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresspallet/core/logs.dart';
import 'package:progresspallet/domain/usecases/get_project_usecase.dart';
import 'package:progresspallet/feature/dashboard/bloc/dashboard_event.dart';
import 'package:progresspallet/feature/dashboard/bloc/dashboard_state.dart';

class DashboardScreenBloc
    extends Bloc<DashboardScreenEvent, DashboardScreenState> {
  GetProjectUsecase getProjectUsecase;

  DashboardScreenBloc({required this.getProjectUsecase})
      : super(DashboardScreenInitial()) {
    on<DashboardScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      DashboardScreenEvent event, Emitter<DashboardScreenState> emit) async {
    if (event is DashboardDataFetchEvent) {
      emit(DashboardScreenLoading());
      try {
        final model = await getProjectUsecase.call();
        return model.fold(
          (l) async {
            emit(DashboardScreenError(l.message));
          },
          (r) async {
            emit(DashboardScreenSuccess(r));
          },
        );
      } catch (error, _) {
        printMessage(error.toString());
        emit(DashboardScreenError(error.toString()));
      }
    }
  }
}
