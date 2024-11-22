import 'package:flutter/material.dart';
import 'package:progresspallet/common/widgets/common_text_widget.dart';
import 'package:progresspallet/constants/app_dimens.dart';
import 'package:progresspallet/constants/app_styles.dart';
import 'package:progresspallet/constants/app_colors.dart';

class DisplayStatusWidget extends StatelessWidget {
  final String? desc;
  final Color? bgColor;
  const DisplayStatusWidget({super.key, this.desc, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.dp4,
        horizontal: AppDimens.dp10,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppDimens.dp5),
      ),
      child: CommonTextWidget(
        text: desc ?? "",
        textStyle: textStyleMonumentFontW500.copyWith(
          fontSize: 13,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
