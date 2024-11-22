import 'package:flutter/material.dart';
import 'package:progresspallet/constants/app_colors.dart';
import 'package:progresspallet/constants/app_sizes.dart';
import 'package:progresspallet/constants/app_styles.dart';

class CommonButton extends StatelessWidget {
  final String? buttonTitle;
  final double buttonHeight;
  final double buttonRadius;
  final VoidCallback onTap;
  final bool isDarkButton;
  final bool showTrailingIcon;
  final bool showIconWithButtonTitle;
  final String? centerIcon;
  final double? buttonTextSize;
  final Color buttonColor;
  final Color? borderColor;
  final Color? buttonTextColor;
  final TextStyle? buttonTextStyle;
  final double? buttonWidth;
  const CommonButton({
    super.key,
    this.buttonTitle,
    this.buttonHeight = 50,
    this.buttonRadius = 10,
    this.buttonWidth,
    required this.onTap,
    this.isDarkButton = true,
    this.showTrailingIcon = false,
    this.showIconWithButtonTitle = false,
    this.buttonTextSize,
    this.centerIcon,
    this.borderColor,
    required this.buttonColor,
    this.buttonTextColor,
    this.buttonTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(),
      splashColor: Colors.transparent,
      child: Container(
        height: buttonHeight,
        width: buttonWidth ?? AppSizes.getWidth(context),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(
          vertical: 3,
        ),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(buttonRadius),
          border: Border.all(color: borderColor ?? AppColors.blackColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: showTrailingIcon ? buttonHeight - 15 : 0,
            ),
            Text(
              buttonTitle ?? "",
              style: buttonTextStyle ??
                  textStyleMonumentFontW500.copyWith(
                    color: buttonTextColor,
                    fontSize: buttonTextSize ?? 12,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
