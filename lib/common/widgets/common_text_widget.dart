import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progresspallet/constants/app_styles.dart';

class CommonTextWidget extends StatelessWidget {
  const CommonTextWidget(
      {required this.text,
      this.textAlign,
      this.overflow,
      this.textStyle,
      this.maxTextLines,
      this.softWrap,
      this.padding,
      super.key});

  final String text;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextStyle? textStyle;
  final int? maxTextLines;
  final bool? softWrap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        text,
        style: textStyle ?? textStyleMonumentFontW500,
        softWrap: softWrap,
        maxLines: maxTextLines,
        textAlign: textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
        overflow: overflow ?? defaultTextStyle.overflow,
      ),
    );
  }
}
