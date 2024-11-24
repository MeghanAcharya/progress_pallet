import 'package:flutter/material.dart';
import 'package:progresspallet/common/widgets/common_horizontal_title_and_desc_comp.dart';
import 'package:progresspallet/common/widgets/common_sized_boxes.dart';
import 'package:progresspallet/common/widgets/common_text_widget.dart';
import 'package:progresspallet/common/widgets/common_user_info_comp.dart';
import 'package:progresspallet/constants/app_constants.dart';
import 'package:progresspallet/constants/app_dimens.dart';
import 'package:progresspallet/constants/app_sizes.dart';
import 'package:progresspallet/constants/app_strings.dart';
import 'package:progresspallet/constants/app_styles.dart';
import 'package:progresspallet/constants/app_colors.dart';
import 'package:progresspallet/constants/string_keys.dart';
import 'package:progresspallet/feature/task/data/model/task_list_response_model.dart';
import 'package:progresspallet/utils/localization/app_localizations.dart';
import 'package:progresspallet/extension/app_extensions.dart';

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
        width: AppSizes.getWidth(context, percent: AppDimens.dp60),
        padding: const EdgeInsets.symmetric(
            vertical: AppDimens.dp15, horizontal: AppDimens.dp12),
        margin: const EdgeInsets.symmetric(
            vertical: AppDimens.dp10, horizontal: AppDimens.dp15),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius:
              const BorderRadius.all(Radius.circular(AppSizes.mediumPadding)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
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
                extraSmallSizedBox(),
                CommonTextWidget(
                  text: taskData?.description ?? "",
                  textStyle: textStyleMonumentFontW400.copyWith(
                    fontSize: AppDimens.dp12,
                    color: AppColors.textSecondaryColor,
                  ),
                  maxTextLines: AppConstants.maxListTextLines,
                  overflow: TextOverflow.ellipsis,
                ),
                smallSizedBox(),
              ],
              if (taskData?.description?.trim().isEmpty ?? true) ...[
                smallSizedBox(),
              ]
            ],
          ),
          subtitle: isCompletedTask()
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CommonHorizontalTitleDescComp(
                      title: AppLocalizations.of(context)
                              ?.translate(StringKeys.completedOnKey) ??
                          "",
                      desc: taskData?.endTime?.toGetDisplayDateFormat(),
                    ),
                    CommonHorizontalTitleDescComp(
                      title: AppLocalizations.of(context)
                              ?.translate(StringKeys.timeTakenKey) ??
                          "",
                      desc: getTimeTakenInMinute(),
                    ),
                  ],
                )
              : UserDisplayNameComp(
                  name: (taskData?.assigneeId ?? AppStrings.defaultUser),
                ),
        ),
      ),
    );
  }

  String getTimeTakenInMinute() {
    Duration difference = (taskData?.endTime ?? DateTime.now())
        .difference(taskData?.startTime ?? DateTime.now());

    return "${difference.inMinutes} ${AppConstants.durationKey}";
  }

  bool isCompletedTask() => taskData?.status == AppConstants.completedStatus;
}
