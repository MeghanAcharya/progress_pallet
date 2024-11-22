import 'package:flutter/material.dart';
import 'package:progresspallet/constants/app_sizes.dart';

Widget microSizedBox({bool isWidth = false}) {
  return SizedBox(
    height: isWidth ? null : AppSizes.microPadding,
    width: isWidth ? AppSizes.microPadding : null,
  );
}

Widget extraSmallSizedBox({bool isWidth = false}) {
  return SizedBox(
    height: isWidth ? null : AppSizes.extraSmallPadding,
    width: isWidth ? AppSizes.extraSmallPadding : null,
  );
}

Widget smallSizedBox({bool isWidth = false}) {
  return SizedBox(
    height: isWidth ? null : AppSizes.smallPadding,
    width: isWidth ? AppSizes.smallPadding : null,
  );
}

Widget mediumSizedBox({bool isWidth = false}) {
  return SizedBox(
    height: isWidth ? null : AppSizes.mediumPadding,
    width: isWidth ? AppSizes.mediumPadding : null,
  );
}

Widget defaultSizedBox({bool isWidth = false}) {
  return SizedBox(
    height: isWidth ? null : AppSizes.defaultPadding,
    width: isWidth ? AppSizes.defaultPadding : null,
  );
}

Widget largeSizedBox({bool isWidth = false}) {
  return SizedBox(
    height: isWidth ? null : AppSizes.largePadding,
    width: isWidth ? AppSizes.largePadding : null,
  );
}

Widget extraLargeSizedBox({bool isWidth = false}) {
  return Container(
    color: Colors.transparent,
    height: isWidth ? null : AppSizes.xxlPadding,
    width: isWidth ? AppSizes.xxlPadding : null,
  );
}

Widget dynamicSizedBox(
    {bool isWidth = false, double margin = AppSizes.xxlPadding}) {
  return SizedBox(
    height: isWidth ? null : margin,
    width: isWidth ? margin : null,
  );
}
