import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:progresspallet/common/toast/custom_flutter_toast.dart';
import 'package:progresspallet/common/widgets/common_app_bar.dart';
import 'package:progresspallet/common/widgets/common_button.dart';
import 'package:progresspallet/common/widgets/common_horizontal_title_and_desc_comp.dart';
import 'package:progresspallet/common/widgets/common_loading_indicator.dart';
import 'package:progresspallet/common/widgets/common_no_data_view.dart';
import 'package:progresspallet/common/widgets/common_sized_boxes.dart';
import 'package:progresspallet/common/widgets/common_text_widget.dart';
import 'package:progresspallet/common/widgets/common_textfield_widget.dart';
import 'package:progresspallet/common/widgets/common_user_info_comp.dart';
import 'package:progresspallet/constants/app_colors.dart';
import 'package:progresspallet/constants/app_constants.dart';
import 'package:progresspallet/constants/app_dimens.dart';
import 'package:progresspallet/constants/app_sizes.dart';
import 'package:progresspallet/constants/app_strings.dart';
import 'package:progresspallet/constants/app_styles.dart';
import 'package:progresspallet/constants/string_keys.dart';
import 'package:progresspallet/dependency_injection/injection_container.dart';
import 'package:progresspallet/extension/app_extensions.dart';
import 'package:progresspallet/feature/task/data/model/task_list_response_model.dart';
import 'package:progresspallet/feature/task_detail/data/model/status_data/status_data_model.dart';
import 'package:progresspallet/feature/task_detail/view/components/display_comment_view.dart';
import 'package:progresspallet/feature/task_detail/bloc/task_detail_bloc.dart';
import 'package:progresspallet/feature/task_detail/bloc/task_detail_event.dart';
import 'package:progresspallet/feature/task_detail/bloc/task_detail_state.dart';
import 'package:progresspallet/feature/task_detail/data/model/comment/add_Comment_request_data.dart';
import 'package:progresspallet/feature/task_detail/data/model/comment/all_comment_request_data.dart';
import 'package:progresspallet/feature/task_detail/data/model/comment/all_comment_response_data.dart';
import 'package:progresspallet/routing/routes_constants.dart';
import 'package:progresspallet/utils/app_utils.dart';
import 'package:progresspallet/utils/localization/app_localizations.dart';

class TaskDetailScreen extends StatefulWidget {
  final String? taskId;
  const TaskDetailScreen({super.key, this.taskId});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final taskBloc = sl<TaskDetailScreenBloc>();
  TaskData? taskInfo;
  List<CommentsDatum>? comments;
  TextEditingController commentController = TextEditingController();
  FocusNode commentFocusNode = FocusNode();
  List<StatusDatum>? statusData = [];
  StatusDatum? selectedStatus;
  @override
  void initState() {
    taskBloc.add(TaskDetailDataFetchEvent(widget.taskId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskDetailScreenBloc, TaskDetailScreenState>(
        listener: (context, state) {},
        bloc: taskBloc,
        builder: (context, state) {
          if (state is TaskDetailScreenError) {
            CustomFlutterToast.showToast(state.message ?? "");
          }
          if (state is TaskDetailScreenSuccess) {
            taskInfo = state.model;
            statusData = state.statusInfo?.statusData ?? [];
            selectedStatus = state.statusInfo?.statusData?.firstWhere(
              (element) => element.statusCode == taskInfo?.status,
              orElse: () =>
                  state.statusInfo?.statusData?.first ?? StatusDatum(),
            );
            taskBloc.add(TaskCommentsDataFetchEvent(
                AllCommentRequestData(taskId: widget.taskId)));
          }
          if (state is TaskCommentScreenSuccess) {
            comments = state.model?.commentsData;
          }
          if (state is TaskAddCommentSuccess) {
            comments?.add(state.model ?? CommentsDatum());
            commentController.clear();
            taskBloc.add(TaskDetailDataFetchEvent(widget.taskId));
          }
          if (state is LocalDataUpdateState) {
            taskBloc.add(TaskDetailDataFetchEvent(widget.taskId));
          }

          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Visibility(
              visible: state is TaskDetailStateUpdate,
              child: CommonButton(
                buttonWidth:
                    AppSizes.getWidth(context, percent: AppDimens.dp70),
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  taskInfo?.status = selectedStatus?.statusCode;
                  if (selectedStatus?.statusCode ==
                      AppConstants.inProgressStatus) {
                    taskInfo?.startTime = DateTime.now();
                  } else if (selectedStatus?.statusCode ==
                      AppConstants.completedStatus) {
                    taskInfo?.endTime = DateTime.now();
                  }
                  taskBloc.add(SaveTaskStateEvent(taskInfo ?? TaskData()));
                },
                buttonColor: AppColors.primary,
                borderColor: AppColors.primary,
                buttonTitle:
                    AppLocalizations.of(context)?.translate(StringKeys.save) ??
                        "",
              ),
            ),
            appBar: AppBarWithBackIcon(
              context: context,
              titleText:
                  "${AppLocalizations.of(context)?.translate(StringKeys.taskKey)} #${widget.taskId}",
              actionWidgets: [
                IconButton(
                  onPressed: () {
                    context.push(
                      Routes.getRoutes(Routes.addTask),
                      extra: {"taskInfo": taskInfo},
                    ).then((val) {
                      taskBloc.add(TaskDetailDataFetchEvent(widget.taskId));
                    });
                  },
                  icon: const Icon(Icons.edit),
                )
              ],
            ),
            body: Stack(
              children: [
                buildUi(),
                Visibility(
                  visible: state is TaskDetailScreenLoading,
                  child: const CommonLoadingIndicator(),
                ),
              ],
            ),
          );
        });
  }

  Widget buildUi() {
    return taskInfo?.id?.trim().isEmpty ?? true
        ? const CommonNoDataView()
        : SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: AppDimens.dp15, horizontal: AppDimens.dp12),
              margin: const EdgeInsets.symmetric(
                  vertical: AppDimens.dp10, horizontal: AppDimens.dp10),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppSizes.mediumPadding),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: renderDetail(),
            ),
          );
  }

  Widget renderDetail() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        renderActionButtons(),
        smallSizedBox(),
        displayCardHeader(),
        renderTaskState(),
        smallSizedBox(),
        displayAssigneeAndStatus(),
        getAddCommentTextField(),
        microSizedBox(),
        displayAddedComments(),
      ],
    );
  }

  Widget renderActionButtons() {
    return taskInfo?.status == AppConstants.completedStatus
        ? Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.dp10,
              vertical: AppDimens.dp10,
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(AppDimens.dp8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: CommonHorizontalTitleDescComp(
              title: AppLocalizations.of(context)
                      ?.translate(StringKeys.completedOnKey) ??
                  "",
              desc: taskInfo?.endTime?.toGetDisplayDateFormat(),
            ),
          )
        : InkWell(
            onTap: () {
              if (hasStartedTimer()) {
                taskInfo?.status = AppConstants.completedStatus;
                taskInfo?.endTime = DateTime.now();
              } else {
                taskInfo?.startTime = DateTime.now();
                taskInfo?.status = AppConstants.inProgressStatus;
              }
              taskBloc.add(SaveTaskStateEvent(taskInfo ?? TaskData()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimens.dp5,
                horizontal: AppDimens.dp10,
              ),
              decoration: BoxDecoration(
                color: hasStartedTimer()
                    ? AppColors.lightOrange
                    : AppColors.lightBlue,
                borderRadius: BorderRadius.circular(AppDimens.dp6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    hasStartedTimer() ? Icons.pause : Icons.play_arrow,
                    size: AppDimens.dp16,
                    color: AppColors.whiteColor,
                  ),
                  microSizedBox(isWidth: true),
                  CommonTextWidget(
                    text: AppLocalizations.of(context)?.translate(
                            hasStartedTimer()
                                ? StringKeys.stopKey
                                : StringKeys.startKey) ??
                        "",
                    textStyle: textStyleMonumentFontW500.copyWith(
                      color: AppColors.whiteColor,
                      fontSize: AppDimens.dp12,
                    ),
                  )
                ],
              ),
            ),
          );
  }

  bool hasStartedTimer() => taskInfo?.startTime != null;
  Widget renderTaskState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonHorizontalTitleDescComp(
          title: AppLocalizations.of(context)?.translate(StringKeys.stateKey) ??
              "",
          desc: AppUtils.getTaskStatus(taskInfo?.status),
        ),
        CommonHorizontalTitleDescComp(
          title:
              AppLocalizations.of(context)?.translate(StringKeys.dueDate) ?? "",
          desc: taskInfo?.due?.date?.toGetDisplayDateFormat() ?? "",
        ),
        CommonHorizontalTitleDescComp(
          title: AppLocalizations.of(context)?.translate(StringKeys.priority) ??
              "",
          desc: (taskInfo?.priority ?? "").toString(),
        ),
      ],
    );
  }

  Widget displayAddedComments() {
    return comments?.isEmpty ?? true
        ? const SizedBox.shrink()
        : ListView.builder(
            itemCount: comments?.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int ind) => DisplayCommentView(
              commentInfo: comments?[ind],
            ),
          );
  }

  Widget displayAssigneeAndStatus() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UserDisplayNameComp(
          name: (taskInfo?.assigneeId ?? AppStrings.defaultUser),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.dp10),
          width: AppSizes.getWidth(context, percent: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: AppColors.greyColor),
            color: Colors.white,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<StatusDatum>(
              isExpanded: true,
              value: selectedStatus,
              onChanged: (value) {
                selectedStatus = value;
                taskBloc.add(const DropDownSelectionEvent());
              },
              items: statusData?.map((StatusDatum value) {
                return DropdownMenuItem<StatusDatum>(
                  value: value,
                  child: CommonTextWidget(
                    text: value.status ?? "",
                    textStyle: textStyleMonumentFontW400.copyWith(
                      fontSize: 10,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget displayCardHeader() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CommonTextWidget(
          text: taskInfo?.content ?? "",
          textStyle: textStyleMonumentFontW600.copyWith(
            fontSize: AppDimens.dp12,
          ),
        ),
        smallSizedBox(),
        CommonTextWidget(
          text: AppLocalizations.of(context)
                  ?.translate(StringKeys.acceptanceCriteria) ??
              "",
          textStyle: textStyleMonumentFontW400.copyWith(
            fontSize: AppDimens.dp10,
            color: AppColors.hint,
          ),
        ),
        CommonTextWidget(
          text: taskInfo?.description ?? "",
          textStyle: textStyleMonumentFontW400.copyWith(
            fontSize: AppDimens.dp12,
            color: AppColors.textSecondaryColor,
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget getAddCommentTextField() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        extraSmallSizedBox(),
        const Divider(),
        extraSmallSizedBox(),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonTextWidget(
              text: AppLocalizations.of(context)
                      ?.translate(StringKeys.discussionKey) ??
                  "",
              textStyle: textStyleMonumentFontW500.copyWith(
                fontSize: AppDimens.dp12,
                color: AppColors.textSecondaryColor,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: AppDimens.dp5),
                  child: Icon(
                    Icons.chat_bubble_outline,
                    size: AppDimens.dp14,
                  ),
                ),
                CommonTextWidget(
                  text: (taskInfo?.commentCount ?? 0).toString(),
                  textStyle: textStyleMonumentFontW500.copyWith(
                    fontSize: AppDimens.dp12,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: UserDisplayNameComp(
            name: (taskInfo?.assigneeId ?? AppStrings.defaultUser),
            showOnlyAvatar: true,
          ),
          horizontalTitleGap: AppDimens.dp5,
          title: CommonTextFieldWidget(
            label: "",
            controller: commentController,
            hintText:
                AppLocalizations.of(context)?.translate(StringKeys.comments),
            focusNode: commentFocusNode,
            onFieldSubmitted: (value) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ),
        const SizedBox(height: AppDimens.dp5),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            child: Container(
              height: AppDimens.dp40,
              width: AppDimens.dp40,
              margin: const EdgeInsets.only(
                left: AppDimens.dp15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  AppDimens.dp20,
                ),
                color: AppColors.primary,
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (commentController.text.trim().isNotEmpty) {
                taskBloc.add(
                  AddTaskCommentsDataEvent(
                    AddCommentRequestData(
                      taskId: widget.taskId,
                      content: commentController.text,
                    ),
                  ),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
