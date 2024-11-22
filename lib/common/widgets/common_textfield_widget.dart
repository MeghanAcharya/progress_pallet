import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progresspallet/constants/app_colors.dart';
import 'package:progresspallet/constants/app_dimens.dart';
import 'package:progresspallet/constants/app_sizes.dart';
import 'package:progresspallet/constants/app_styles.dart';

class CommonTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onFieldChange;
  final TextInputType keyboardType;
  final int? maxLines;
  final int minLines;
  final TextCapitalization? textCapitalization;
  final bool isDropdown;
  final VoidCallback? onTapField;
  final VoidCallback? onTapSuffixIcon;
  final bool readOnly;
  final int? maxLength;
  final int? lengthLimit;
  final double? borderRadius;
  final bool showCounterText;
  final AutovalidateMode? autoValidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final bool? autofocus;
  final Color fillColor;
  final Widget? suffixIcon;
  final bool isSuffixIcon;
  final bool obscureText;
  final String? errorMessage;
  final String? suffixText;
  final TextStyle? suffixTextStyle;
  final TextInputAction? textInputActionType;
  final String? label;
  final bool withAsterisk;
  final double? givenMaxHeight;
  final double? givenMaxWidth;
  final TextCapitalization? textCapitalize;

  const CommonTextFieldWidget({
    super.key,
    this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.focusNode,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onFieldChange,
    this.maxLines = 1,
    this.minLines = 1,
    this.borderRadius = 10,
    this.onTapField,
    this.onTapSuffixIcon,
    this.readOnly = false,
    this.withAsterisk = false,
    this.maxLength,
    this.label,
    this.lengthLimit,
    this.showCounterText = false,
    this.autoValidateMode,
    this.inputFormatters,
    this.autofocus = false,
    this.textCapitalization,
    this.isDropdown = false,
    this.fillColor = AppColors.whiteColor,
    this.suffixIcon,
    this.isSuffixIcon = false,
    this.errorMessage,
    this.obscureText = false,
    this.suffixText,
    this.suffixTextStyle,
    this.textInputActionType,
    this.givenMaxHeight,
    this.givenMaxWidth,
    this.textCapitalize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label?.trim().isEmpty ?? false
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '$label',
                        style: textStyleMonumentFontW600.copyWith(
                          fontSize: AppDimens.dp10,
                          color: AppColors.lightGreyColor,
                        ),
                      ),
                      TextSpan(
                        text: withAsterisk ? ' * ' : ' ',
                        style: textStyleMonumentFontW600.copyWith(
                          fontSize: AppDimens.dp12,
                          color: AppColors.darkRedColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        TextFormField(
          inputFormatters: inputFormatters,
          onFieldSubmitted: onFieldSubmitted,
          obscureText: obscureText,
          onChanged: onFieldChange,
          autofocus: autofocus ?? false,
          focusNode: focusNode ?? FocusNode(),
          onEditingComplete: onEditingComplete,
          cursorColor: Theme.of(context).primaryColor,
          style: textStyleMonumentFontW400.copyWith(fontSize: AppDimens.dp12),
          readOnly: readOnly,
          keyboardType: keyboardType,
          textInputAction: textInputActionType,
          validator: validator,
          autovalidateMode: autoValidateMode,
          controller: controller,
          maxLines: maxLines,
          minLines: minLines,
          textCapitalization:
              textCapitalization ?? TextCapitalization.sentences,
          onTap: onTapField,
          maxLength: maxLength ?? 255,
          decoration: InputDecoration(
            errorStyle: textStyleMonumentFontW400.copyWith(
              fontSize: AppDimens.dp10,
              color: AppColors.darkRedColor,
            ),
            fillColor: fillColor,
            suffixIcon: isSuffixIcon
                ? InkWell(
                    onTap: onTapSuffixIcon,
                    child: suffixIcon,
                  )
                : isDropdown
                    ? const Icon(Icons.arrow_drop_down)
                    : suffixText?.trim().isNotEmpty ?? false
                        ? Text(
                            suffixText ?? "",
                            style: suffixTextStyle ??
                                const TextStyle(
                                  fontSize: 10,
                                  color: AppColors.darkRedColor,
                                  fontWeight: FontWeight.normal,
                                ),
                          )
                        : SizedBox(
                            width: AppSizes.getWidth(context, percent: 4)),
            suffixIconConstraints: isDropdown || isSuffixIcon
                ? BoxConstraints(
                    maxHeight: givenMaxHeight ??
                        AppSizes.getHeight(context, percent: 12),
                    maxWidth: givenMaxWidth ??
                        AppSizes.getWidth(context, percent: 10))
                : (suffixText?.trim().isNotEmpty ?? false)
                    ? BoxConstraints(
                        maxHeight: givenMaxHeight ??
                            AppSizes.getHeight(context, percent: 12),
                        maxWidth: givenMaxWidth ??
                            AppSizes.getWidth(context, percent: 10),
                      )
                    : BoxConstraints(
                        maxHeight: 0,
                        maxWidth: AppSizes.getWidth(context, percent: 4),
                      ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSizes.getWidth(context, percent: 2),
            ),
            counterText: showCounterText ? null : '',
            errorText: errorMessage,
            errorMaxLines: 2,
            labelStyle: textStyleMonumentFontW400.copyWith(
                fontSize: AppDimens.dp12, color: AppColors.lightGreyColor),
            filled: true,
            hintText: hintText,
            hintStyle: textStyleMonumentFontW400.copyWith(
                fontSize: AppDimens.dp12, color: AppColors.lightGreyColor),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.greyColor),
              borderRadius:
                  BorderRadius.circular(borderRadius ?? AppDimens.dp8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.greyColor),
              borderRadius:
                  BorderRadius.circular(borderRadius ?? AppDimens.dp8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.greyColor),
              borderRadius:
                  BorderRadius.circular(borderRadius ?? AppDimens.dp8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.greyColor),
              borderRadius:
                  BorderRadius.circular(borderRadius ?? AppDimens.dp8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.greyColor),
              borderRadius:
                  BorderRadius.circular(borderRadius ?? AppDimens.dp8),
            ),
          ),
        ),
      ],
    );
  }
}
