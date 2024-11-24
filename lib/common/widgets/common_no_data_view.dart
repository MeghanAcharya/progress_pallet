import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:progresspallet/common/widgets/common_sized_boxes.dart';
import 'package:progresspallet/common/widgets/common_text_widget.dart';
import 'package:progresspallet/constants/app_colors.dart';
import 'package:progresspallet/constants/app_dimens.dart';
import 'package:progresspallet/constants/app_images.dart';
import 'package:progresspallet/constants/app_styles.dart';
import 'package:progresspallet/constants/string_keys.dart';
import 'package:progresspallet/utils/localization/app_localizations.dart';

class CommonNoDataView extends StatelessWidget {
  final String? title;
  final String? desc;
  final double? imageHeight;
  const CommonNoDataView({
    super.key,
    this.title,
    this.desc,
    this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.dp30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            lottie.Lottie.asset(
              AppImages.noData,
              fit: BoxFit.contain,
              height: imageHeight,
            ),
            mediumSizedBox(),
            CommonTextWidget(
              text: title ??
                  AppLocalizations.of(context)
                      ?.translate(StringKeys.noDataTitleKey) ??
                  "",
              textAlign: TextAlign.center,
              textStyle: textStyleMonumentFontW600.copyWith(
                color: AppColors.blackColor,
                fontSize: 16,
              ),
            ),
            smallSizedBox(),
            CommonTextWidget(
              text: desc ??
                  AppLocalizations.of(context)
                      ?.translate(StringKeys.noDataDescKey) ??
                  "",
              textAlign: TextAlign.center,
              textStyle: textStyleMonumentFontW400.copyWith(
                color: AppColors.textSecondaryColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
