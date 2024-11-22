import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progresspallet/common/widgets/common_text_widget.dart';
import 'package:progresspallet/constants/app_dimens.dart';
import 'package:progresspallet/constants/app_sizes.dart';
import 'package:progresspallet/constants/app_styles.dart';
import 'package:progresspallet/constants/app_colors.dart';
import 'package:progresspallet/core/logs.dart';
import 'package:progresspallet/core/system_settings.dart';

class AppBarWithBackIcon extends AppBar implements PreferredSizeWidget {
  final String titleText;
  final String? leadingIcon;
  final BuildContext context;
  final VoidCallback? onBackClick;
  final List<Widget>? actionWidgets;
  final Object? result;
  final bool? showDivider;
  final bool? isCenterTitle;
  final Color? dividerColor;
  final Color? textAndIconColor;
  final bool? showBackIcon;
  final Color? bgColor;

  AppBarWithBackIcon({
    super.key,
    required this.context,
    this.titleText = "",
    this.leadingIcon,
    this.onBackClick,
    this.result,
    this.actionWidgets,
    this.showDivider,
    this.isCenterTitle,
    this.dividerColor,
    this.textAndIconColor,
    this.showBackIcon,
    this.bgColor,
  }) : super(
          backgroundColor: bgColor ?? AppColors.whiteColor,
          surfaceTintColor: bgColor ?? AppColors.whiteColor,
          centerTitle: isCenterTitle ?? false,
          actions: actionWidgets ?? [],
          systemOverlayStyle:
              SystemSettings.getSystemOverlayStyle(isActive: true),
          bottom: showDivider ?? true
              ? PreferredSize(
                  preferredSize:
                      Size(AppSizes.getWidth(context), AppDimens.dp1),
                  child: Container(
                    color: dividerColor ?? AppColors.grey4E,
                    height: AppDimens.dp1,
                  ),
                )
              : null,
          leadingWidth: showBackIcon ?? true ? AppDimens.dp40 : AppDimens.dp5,
          titleSpacing: AppDimens.dp5,
          leading: showBackIcon ?? true
              ? InkWell(
                  onTap: () async {
                    onBackClick?.call();
                    if (Navigator.of(context).canPop()) {
                      // Pop the current route if it's not the top-most route
                      Navigator.of(context).pop();
                    } else {
                      // If it's the top-most route, move the app to the background
                      if (Theme.of(context).platform ==
                          TargetPlatform.android) {
                        // For Android, move the app to the background
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                      } else if (Theme.of(context).platform ==
                          TargetPlatform.iOS) {
                        // For iOS, we can't programmatically move the app to the background
                        // So we just avoid any further action
                        printMessage(
                            "iOS does not support moving apps to background programmatically.");
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimens.dp15,
                      AppDimens.dp5,
                      AppDimens.dp3,
                      AppDimens.dp5,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: textAndIconColor ?? AppColors.textSecondaryColor,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          title: titleText.trim().isNotEmpty
              ? CommonTextWidget(
                  text: titleText,
                  textStyle: textStyleMonumentFontW400.copyWith(
                    color: textAndIconColor ?? AppColors.textSecondaryColor,
                    fontSize: 14,
                  ),
                )
              : const SizedBox.shrink(),
        );
}
