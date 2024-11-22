import 'package:flutter/material.dart';
import 'package:progresspallet/common/widgets/common_text_widget.dart';
import 'package:progresspallet/constants/app_dimens.dart';
import 'package:progresspallet/constants/app_styles.dart';
import 'package:progresspallet/constants/app_colors.dart';
import 'package:progresspallet/utils/color_utils.dart';
import 'package:progresspallet/extension/app_extensions.dart';

class UserDisplayNameComp extends StatelessWidget {
  final String? name;
  final bool? showOnlyName;
  final bool? showOnlyAvatar;
  final String? userImage;
  final double? avatarHeight;
  final bool? showMargin;
  final VoidCallback? onTapUserInfo;
  const UserDisplayNameComp({
    super.key,
    this.name,
    this.showOnlyName,
    this.showOnlyAvatar,
    this.userImage,
    this.avatarHeight,
    this.showMargin,
    this.onTapUserInfo,
  });

  @override
  Widget build(BuildContext context) {
    return showOnlyName ?? false
        ? getUserNameComp()
        : showOnlyAvatar ?? false
            ? getUserAvatar()
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  getUserAvatar(),
                  getUserNameComp(),
                ],
              );
  }

  Widget getUserNameComp() {
    return Flexible(
      child: CommonTextWidget(
        text: name?.capitalizeNameFirstLetter() ?? "",
        textAlign: TextAlign.start,
        textStyle: textStyleMonumentFontW500.copyWith(
          color: AppColors.blackColor.withOpacity(0.8),
          fontSize: 14,
        ),
      ),
    );
  }

  Widget getUserAvatar() {
    return ((name != null) && (name?.trim().isNotEmpty ?? false))
        ? InkWell(
            onTap: () => onTapUserInfo?.call(),
            child: Container(
              height: avatarHeight ?? AppDimens.dp35,
              width: avatarHeight ?? AppDimens.dp35,
              margin: showMargin ?? true
                  ? const EdgeInsets.only(right: AppDimens.dp8)
                  : EdgeInsets.zero,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular((avatarHeight ?? AppDimens.dp35) / 2),
                color: ColorUtils.getNameSpecificColor(name ?? ""),
              ),
              child: CommonTextWidget(
                text: (name ?? "").capitalizeFirstLetter(),
                textStyle: textStyleMonumentFontW700.copyWith(
                  color: AppColors.whiteColor,
                  fontSize: 16,
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
