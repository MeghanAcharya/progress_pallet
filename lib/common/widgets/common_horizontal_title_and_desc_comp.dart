import 'package:flutter/widgets.dart';
import 'package:progresspallet/common/widgets/common_text_widget.dart';
import 'package:progresspallet/constants/app_colors.dart';
import 'package:progresspallet/constants/app_dimens.dart';
import 'package:progresspallet/constants/app_styles.dart';

class CommonHorizontalTitleDescComp extends StatelessWidget {
  final String? title;
  final String? desc;
  const CommonHorizontalTitleDescComp({super.key, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: CommonTextWidget(
            text: title ?? "",
            textStyle: textStyleMonumentFontW500.copyWith(
              fontSize: AppDimens.dp10,
              color: AppColors.hint,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: CommonTextWidget(
            text: desc ?? "",
            textStyle: textStyleMonumentFontW500.copyWith(
              fontSize: AppDimens.dp10,
              color: AppColors.textSecondaryColor,
            ),
          ),
        ),
      ],
    );
    ;
  }
}
