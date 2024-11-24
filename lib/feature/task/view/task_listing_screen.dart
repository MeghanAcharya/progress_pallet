import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:progresspallet/common/toast/custom_flutter_toast.dart';
import 'package:progresspallet/common/widgets/common_app_bar.dart';
import 'package:progresspallet/common/widgets/common_loading_indicator.dart';
import 'package:progresspallet/common/widgets/common_no_data_view.dart';
import 'package:progresspallet/common/widgets/common_status_chip.dart';
import 'package:progresspallet/constants/analytics_key_constats.dart';
import 'package:progresspallet/constants/app_constants.dart';
import 'package:progresspallet/constants/app_dimens.dart';
import 'package:progresspallet/constants/app_sizes.dart';
import 'package:progresspallet/constants/string_keys.dart';
import 'package:progresspallet/dependency_injection/injection_container.dart';
import 'package:progresspallet/feature/task/bloc/task_bloc.dart';
import 'package:progresspallet/feature/task/bloc/task_event.dart';
import 'package:progresspallet/feature/task/bloc/task_state.dart';
import 'package:progresspallet/feature/task/data/model/task_list_response_model.dart';
import 'package:progresspallet/feature/task/view/components/task_card_view.dart';
import 'package:progresspallet/routing/routes_constants.dart';
import 'package:progresspallet/utils/app_utils.dart';
import 'package:progresspallet/utils/firebase_analytics_utils.dart';
import 'package:progresspallet/utils/localization/app_localizations.dart';

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
  List<TaskData> todoTaskList = [];
  List<TaskData> inProgressTaskList = [];
  List<TaskData> completedTaskList = [];
  @override
  void initState() {
    taskBloc.add(TaskDataFetchEvent(widget.projectId));
    super.initState();
    AnalyticsUtils().logEvent(name: AppAnalyticsKey.viewTaskBoard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackIcon(
        context: context,
        titleText:
            AppLocalizations.of(context)?.translate(StringKeys.taskKey) ?? "",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.push(Routes.getRoutes(Routes.addTask),
              extra: {"taskInfo": null}).then((val) {
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
            todoTaskList = [];
            inProgressTaskList = [];
            completedTaskList = [];
            for (int i = 0; i < (state.model?.tasks?.length ?? 0); i++) {
              if (state.model?.tasks?[i].status ==
                  AppConstants.completedStatus) {
                completedTaskList.add(state.model?.tasks?[i] ?? TaskData());
              } else if (state.model?.tasks?[i].status ==
                  AppConstants.inProgressStatus) {
                inProgressTaskList.add(state.model?.tasks?[i] ?? TaskData());
              } else {
                todoTaskList.add(state.model?.tasks?[i] ?? TaskData());
              }
            }
          }

          return SizedBox(
            height: AppSizes.getHeight(context),
            width: AppSizes.getWidth(context),
            child: Stack(
              children: [
                buildUi(),
                Visibility(
                  visible: state is TaskScreenLoading,
                  child: const CommonLoadingIndicator(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildUi() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        renderLisViewWithHeader(
          todoTaskList,
          AppUtils.getTaskStatus(AppConstants.todoStatus),
          AppUtils.getTaskStatusColor(AppConstants.todoStatus),
        ),
        renderLisViewWithHeader(
          inProgressTaskList,
          AppUtils.getTaskStatus(AppConstants.inProgressStatus),
          AppUtils.getTaskStatusColor(AppConstants.inProgressStatus),
        ),
        renderLisViewWithHeader(
          completedTaskList,
          AppUtils.getTaskStatus(AppConstants.completedStatus),
          AppUtils.getTaskStatusColor(AppConstants.completedStatus),
        ),
      ],
    );
  }

  Widget renderLisViewWithHeader(
      List<TaskData> listData, String textTitle, Color bgColor) {
    return SizedBox(
      height: AppSizes.getHeight(context, percent: AppDimens.dp29),
      width: AppSizes.getWidth(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.dp20, vertical: AppDimens.dp5),
            child: DisplayStatusWidget(
              desc: textTitle,
              bgColor: bgColor,
            ),
          ),
          SizedBox(
            height: AppSizes.getHeight(context, percent: AppDimens.dp24),
            child: listData.isEmpty
                ? CommonNoDataView(
                    imageHeight: AppSizes.getHeight(context, percent: 10),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: listData.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, i) {
                      return TaskCardView(
                        taskData: listData[i],
                        onTapTask: () {
                          context.push(
                            Routes.getRoutes(Routes.taskDetail),
                            extra: {
                              "id": listData[i].id,
                            },
                          ).then((val) {
                            taskBloc.add(TaskDataFetchEvent(widget.projectId));
                          });
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
