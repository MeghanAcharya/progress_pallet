import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresspallet/common/toast/custom_flutter_toast.dart';
import 'package:progresspallet/common/widgets/common_app_bar.dart';
import 'package:progresspallet/common/widgets/common_loading_indicator.dart';
import 'package:progresspallet/common/widgets/common_no_data_view.dart';
import 'package:progresspallet/common/widgets/common_sized_boxes.dart';
import 'package:progresspallet/common/widgets/common_status_chip.dart';
import 'package:progresspallet/common/widgets/common_text_widget.dart';
import 'package:progresspallet/common/widgets/common_textfield_widget.dart';
import 'package:progresspallet/common/widgets/common_user_info_comp.dart';
import 'package:progresspallet/constants/app_colors.dart';

import 'package:progresspallet/constants/app_dimens.dart';
import 'package:progresspallet/constants/app_sizes.dart';
import 'package:progresspallet/constants/app_strings.dart';
import 'package:progresspallet/constants/app_styles.dart';
import 'package:progresspallet/constants/string_keys.dart';
import 'package:progresspallet/dependency_injection/injection_container.dart';
import 'package:progresspallet/feature/task/data/model/task_list_response_model.dart';
import 'package:progresspallet/feature/task_detail/view/components/display_comment_view.dart';
import 'package:progresspallet/feature/task_detail/bloc/task_detail_bloc.dart';
import 'package:progresspallet/feature/task_detail/bloc/task_detail_event.dart';
import 'package:progresspallet/feature/task_detail/bloc/task_detail_state.dart';
import 'package:progresspallet/feature/task_detail/data/model/comment/add_Comment_request_data.dart';
import 'package:progresspallet/feature/task_detail/data/model/comment/all_comment_request_data.dart';
import 'package:progresspallet/feature/task_detail/data/model/comment/all_comment_response_data.dart';
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

  @override
  void initState() {
    taskBloc.add(TaskDetailDataFetchEvent(widget.taskId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackIcon(
        context: context,
        titleText:
            "${AppLocalizations.of(context)?.translate(StringKeys.taskKey)} #${widget.taskId}",
      ),
      body: BlocConsumer<TaskDetailScreenBloc, TaskDetailScreenState>(
        listener: (context, state) {},
        bloc: taskBloc,
        builder: (context, state) {
          if (state is TaskDetailScreenError) {
            CustomFlutterToast.showToast(state.message ?? "");
          }
          if (state is TaskDetailScreenSuccess) {
            taskInfo = state.model;
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

          return Stack(
            children: [
              buildUi(),
              Visibility(
                visible: state is TaskDetailScreenLoading,
                child: const CommonLoadingIndicator(),
              ),
            ],
          );
        },
      ),
    );
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
        displayAssigneeAndStatus(),
        smallSizedBox(),
        displayCardHeader(),
        getAddCommentTextField(),
        microSizedBox(),
        displayAddedComments(),
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
        DisplayStatusWidget(
          desc: AppUtils.getTaskStatus(taskInfo?.status),
          bgColor: AppUtils.getTaskStatusColor(taskInfo?.status),
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
          textStyle: textStyleMonumentFontW500.copyWith(
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
      children: [
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
