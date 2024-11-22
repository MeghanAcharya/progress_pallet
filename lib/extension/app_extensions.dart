import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progresspallet/constants/app_constants.dart';
import 'package:progresspallet/constants/app_sizes.dart';
import 'package:progresspallet/core/logs.dart';

extension DeviceSizeType on BuildContext {
  bool isMobileTypeDevice() {
    var shortestSide = MediaQuery.of(this).size.shortestSide;
    final bool useMobileLayout = shortestSide < 600;
    return useMobileLayout;
  }

  bool isMobileAndPotrait() {
    var shortestSide = MediaQuery.of(this).size.shortestSide;
    var orientation = MediaQuery.of(this).orientation;
    final bool useMobileLayout = shortestSide < AppConstants.shortestSide;
    return useMobileLayout && orientation != Orientation.landscape;
  }

  bool isSmallDevice() {
    var shortSide = AppSizes.getShortSide();
    printMessage('{$shortSide}');
    final bool useMobileLayout = shortSide < AppConstants.smallerDevice;
    return useMobileLayout;
  }
}

extension PascalCase on String {
  String toPascalCase() =>
      isEmpty ? '' : substring(0, 1).toUpperCase() + substring(1, length);
}

extension StringCapitalizationExtension on String {
  String capitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }
    var nameChar = this[0];
    return nameChar.toUpperCase();
  }
}

extension StringExtensions on String {
  String capitalizeNameFirstLetter() {
    if (isEmpty) {
      return this;
    }
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension PrivateProfileFirstName on String {
  String getDisplayPrivateFirstName() {
    if (length < 2) {
      return capitalizeNameFirstLetter();
    }
    String firstName =
        split(" ").first.capitalizeNameFirstLetter().replaceAll(',', '');
    if (firstName.length > 20) {
      return firstName.substring(0, 20);
    }
    return firstName;
  }
}

extension ToGetDisplayDateFormat on DateTime {
  String toGetDisplayDateFormat() => toDMMMYYYTimeFromString();
}

extension FormatDMMMYYYY on DateTime {
  String toDMMMYYYTimeFromString() =>
      DateFormat(AppConstants.mmmddyy).format(this);
}
