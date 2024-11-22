import 'package:flutter/material.dart';
import 'package:progresspallet/extension/app_extensions.dart';

///All sizes used in the application are described in AppSizes
class AppSizes {
  AppSizes._();

  static const defaultFontSize = 16.0;
  static const smallFontSize = 12.0;
  static const microPadding = 4.0;
  static const extraSmallPadding = 10.0;
  static const smallPadding = 14.0;
  static const textFieldVerticalPadding = 14.0;
  static const defaultPadding = 30.0;
  static const mediumPadding = 20.0;
  static const largePadding = 40.0;
  static const leftPadding = 70.0;
  static const rightPadding = 50.0;
  static const suffixRowWidth = 70.0;

  static const extralargePadding = 28.0;
  static const xlPadding = 32.0;
  static const xxlPadding = 64.0;
  static const containerHeight = 92.0;

  static const microMargin = 4.0;
  static const smallMargin = 8.0;
  static const defaultMargin = 16.0;
  static const largeMargin = 24.0;
  static const mediumMargin = 18.0;

  static const defaultHeaderSize = 16.0;

  static const smallRoundedRadius = 8.0;
  static const defaultRoundedRadius = 16.0;
  static const largeRoundedRadius = 24.0;
  static double deviceHeight = 720.0;
  static double deviceWidth = 480.0;
  static MediaQueryData? mediaQuery;
  static MediaQueryData setMediaQueryData(MediaQueryData mQuery) =>
      mediaQuery = mQuery;
  static double setWidth(double width) => deviceWidth = width;
  static double setHight(double height) => deviceHeight = height;

  static double getWidth(BuildContext context, {double percent = 100}) =>
      percent / 100 * MediaQuery.of(context).size.width;

  static double getHeight(BuildContext context, {double percent = 100}) =>
      percent / 100 * MediaQuery.of(context).size.height;

  static double getFontSize(BuildContext context, {int sizeValue = 14}) =>
      (sizeValue / 10) *
      (context.isMobileAndPotrait()
          ? (MediaQuery.of(context).size.height * 0.015)
          : (MediaQuery.of(context).size.width * 0.015));

  static double getIconHeight(BuildContext context, {int sizeValue = 30}) =>
      ((MediaQuery.of(context).size.height * 0.015) * (sizeValue / 10));

  static double getIconWidth(BuildContext context, {int sizeValue = 30}) =>
      ((MediaQuery.of(context).size.width * 0.015) * (sizeValue / 10));

  static double getShortSide({percent = 100}) =>
      (mediaQuery?.size.shortestSide ?? 600);
}
