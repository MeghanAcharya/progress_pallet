import 'package:flutter/material.dart';
import 'package:progresspallet/common/widgets/common_text_widget.dart';
import 'package:progresspallet/common/widgets/common_user_info_comp.dart';
import 'package:progresspallet/constants/app_colors.dart';
import 'package:progresspallet/constants/app_dimens.dart';
import 'package:progresspallet/constants/app_strings.dart';
import 'package:progresspallet/constants/app_styles.dart';
import 'package:progresspallet/extension/app_extensions.dart';
import 'package:progresspallet/feature/task_detail/data/model/comment/all_comment_response_data.dart';

class DisplayCommentView extends StatelessWidget {
  final CommentsDatum? commentInfo;
  const DisplayCommentView({super.key, this.commentInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppDimens.dp5),
      padding: const EdgeInsets.symmetric(
          vertical: AppDimens.dp2, horizontal: AppDimens.dp10),
      decoration: BoxDecoration(
        color: AppColors.greyColor.withOpacity(0.5),
        border: Border.all(color: AppColors.greyColor),
        borderRadius: BorderRadius.circular(AppDimens.dp10),
      ),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.top,
        contentPadding: EdgeInsets.zero,
        minLeadingWidth: AppDimens.dp50,
        dense: true,
        horizontalTitleGap: AppDimens.dp4,
        leading: UserDisplayNameComp(
          name: AppStrings.defaultUser,
          showOnlyAvatar: true,
        ),
        title: CommonTextWidget(
          text: (commentInfo?.postedAt ?? DateTime.now())
              .toGetDisplayDateFormat(),
          textStyle: textStyleMonumentFontW200.copyWith(
            fontSize: AppDimens.dp10,
            color: AppColors.textSecondaryColor,
          ),
        ),
        subtitle: CommonTextWidget(
          text: commentInfo?.content ?? "",
          textStyle:
              textStyleMonumentFontW400.copyWith(fontSize: AppDimens.dp12),
        ),
      ),
    );
  }
}
