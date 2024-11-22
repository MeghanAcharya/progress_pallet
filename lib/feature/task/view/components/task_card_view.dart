import 'package:flutter/material.dart';
import 'package:progresspallet/common/widgets/common_sized_boxes.dart';
import 'package:progresspallet/common/widgets/common_status_chip.dart';
import 'package:progresspallet/common/widgets/common_text_widget.dart';
import 'package:progresspallet/common/widgets/common_user_info_comp.dart';
import 'package:progresspallet/constants/app_constants.dart';
import 'package:progresspallet/constants/app_dimens.dart';
import 'package:progresspallet/constants/app_sizes.dart';
import 'package:progresspallet/constants/app_strings.dart';
import 'package:progresspallet/constants/app_styles.dart';
import 'package:progresspallet/constants/app_colors.dart';
import 'package:progresspallet/feature/task/data/model/task_list_response_model.dart';
import 'package:progresspallet/utils/app_utils.dart';

class TaskCardView extends StatelessWidget {
  final TaskData? taskData;
  final VoidCallback? onTapTask;
  const TaskCardView({super.key, this.taskData, this.onTapTask});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTapTask?.call();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: AppDimens.dp15, horizontal: AppDimens.dp12),
        margin: const EdgeInsets.symmetric(
            vertical: AppDimens.dp8, horizontal: AppDimens.dp15),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius:
              const BorderRadius.all(Radius.circular(AppSizes.mediumPadding)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextWidget(
                text: taskData?.content ?? "",
                textStyle: textStyleMonumentFontW600.copyWith(
                  fontSize: AppDimens.dp12,
                ),
                maxTextLines: AppConstants.maxListTextLines,
                overflow: TextOverflow.ellipsis,
              ),
              if (taskData?.description?.trim().isNotEmpty ?? false) ...[
                microSizedBox(),
                CommonTextWidget(
                  text: taskData?.description ?? "",
                  textStyle: textStyleMonumentFontW400.copyWith(
                    fontSize: AppDimens.dp12,
                    color: AppColors.textSecondaryColor,
                  ),
                  maxTextLines: AppConstants.maxListTextLines,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ],
          ),
          subtitle: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DisplayStatusWidget(
                desc: AppUtils.getTaskStatus(taskData?.status),
                bgColor: AppUtils.getTaskStatusColor(taskData?.status),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: UserDisplayNameComp(
                  name: (taskData?.assigneeId ?? AppStrings.defaultUser),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
