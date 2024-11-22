import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:progresspallet/common/toast/custom_flutter_toast.dart';
import 'package:progresspallet/common/widgets/common_app_bar.dart';
import 'package:progresspallet/common/widgets/common_loading_indicator.dart';
import 'package:progresspallet/common/widgets/common_no_data_view.dart';
import 'package:progresspallet/constants/app_dimens.dart';
import 'package:progresspallet/dependency_injection/injection_container.dart';
import 'package:progresspallet/feature/task/bloc/task_bloc.dart';
import 'package:progresspallet/feature/task/bloc/task_event.dart';
import 'package:progresspallet/feature/task/bloc/task_state.dart';
import 'package:progresspallet/feature/task/data/model/task_list_response_model.dart';
import 'package:progresspallet/feature/task/view/components/task_card_view.dart';
import 'package:progresspallet/routing/routes_constants.dart';

class TaskListScreen extends StatefulWidget {
  final String? projectId;
  const TaskListScreen({
    super.key,
    this.projectId,
  });

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final taskBloc = sl<TaskListScreenBloc>();
  List<TaskData> taskList = [];

  @override
  void initState() {
    taskBloc.add(TaskDataFetchEvent(widget.projectId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackIcon(
        context: context,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context
              .push(
            Routes.getRoutes(Routes.addTask),
          )
              .then((val) {
            taskBloc.add(TaskDataFetchEvent(widget.projectId));
          });
        },
      ),
      body: BlocConsumer<TaskListScreenBloc, TaskListScreenState>(
        listener: (context, state) {},
        bloc: taskBloc,
        builder: (context, state) {
          if (state is TaskScreenError) {
            CustomFlutterToast.showToast(state.message ?? "");
          }
          if (state is TaskScreenSuccess) {
            taskList = state.model?.tasks ?? [];
          }

          return Stack(
            children: [
              buildUi(),
              Visibility(
                visible: state is TaskScreenLoading,
                child: const CommonLoadingIndicator(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildUi() {
    return taskList.isEmpty
        ? const CommonNoDataView()
        : ListView.builder(
            shrinkWrap: true,
            itemCount: taskList.length,
            padding: const EdgeInsets.only(bottom: AppDimens.dp100),
            itemBuilder: (BuildContext context, i) {
              return TaskCardView(
                taskData: taskList[i],
                onTapTask: () {
                  context.push(
                    Routes.getRoutes(Routes.taskDetail),
                    extra: {
                      "id": taskList[i].id,
                    },
                  );
                },
              );
            },
          );
  }
}
