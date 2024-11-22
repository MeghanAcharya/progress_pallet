import 'package:flutter/services.dart';

import 'package:progresspallet/constants/app_colors.dart';

class SystemSettings {
  static Future<void> makeAppBarColored() async {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor:
            AppColors.primary, // set Status bar color in Android devices
        statusBarIconBrightness:
            Brightness.dark, // set Status bar icons color in Android devices
        statusBarBrightness:
            Brightness.dark, // set Status bar icon color in iOS
      ),
    );
  }

  static Future<void> setAppOrientation() async {
    return await SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
      ],
    );
  }

  static getSystemOverlayStyle({bool isActive = false}) {
    return isActive
        ? const SystemUiOverlayStyle(
            statusBarColor: AppColors.primary, // <-- SEE HERE
            statusBarIconBrightness:
                Brightness.light, //<-- For Android SEE HERE (dark icons)
            statusBarBrightness:
                Brightness.dark, //<-- For iOS SEE HERE (dark icons)
            systemStatusBarContrastEnforced: true,
          )
        : null;
  }
}
