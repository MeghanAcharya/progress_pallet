import 'package:flutter/material.dart';
import 'package:progresspallet/common/widgets/common_text_widget.dart';
import 'package:progresspallet/constants/app_dimens.dart';
import 'package:progresspallet/constants/app_sizes.dart';
import 'package:progresspallet/constants/app_colors.dart';
import 'package:progresspallet/feature/dashboard/data/model/project_list/project_list_response_model.dart';

class ProjectsCardView extends StatelessWidget {
  final Project? projectInfo;
  final VoidCallback? onTapProject;
  const ProjectsCardView({super.key, this.projectInfo, this.onTapProject});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTapProject?.call();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: AppDimens.dp10, horizontal: AppDimens.dp15),
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
          title: CommonTextWidget(
            text: projectInfo?.name ?? "",
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
          ),
        ),
      ),
    );
  }
}
