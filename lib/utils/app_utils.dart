import 'package:flutter/material.dart';
import 'package:progresspallet/constants/app_colors.dart';
import 'package:progresspallet/constants/app_constants.dart';
import 'package:progresspallet/constants/app_strings.dart';

class AppUtils {
  static String getTaskStatus(String? status) {
    String payStatus = AppStrings.todoStatusText;
    switch (status) {
      case AppConstants.todoStatus:
        payStatus = AppStrings.todoStatusText;
        break;
      case AppConstants.inProgressStatus:
        payStatus = AppStrings.inprogressStatusText;
        break;
      case AppConstants.completedStatus:
        payStatus = AppStrings.completedStatusText;
        break;

      default:
        payStatus = AppStrings.todoStatusText;
    }
    return payStatus;
  }

  static Color getTaskStatusColor(String? status) {
    Color payStatus = AppColors.lightBlue;
    switch (status) {
      case AppConstants.todoStatus:
        payStatus = AppColors.lightBlue;
        break;
      case AppConstants.inProgressStatus:
        payStatus = AppColors.lightOrange;
        break;
      case AppConstants.completedStatus:
        payStatus = AppColors.lightGreen;
        break;

      default:
        payStatus = AppColors.lightBlue;
    }
    return payStatus;
  }
}
