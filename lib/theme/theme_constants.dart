import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progresspallet/constants/app_fonts.dart';
import 'package:progresspallet/constants/app_styles.dart';
import 'package:progresspallet/constants/app_colors.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: AppFontConstant.ppMonumentFont,
    primaryColor: AppColors.primary,
    dialogBackgroundColor: AppColors.whiteColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    buttonTheme: const ButtonThemeData(buttonColor: AppColors.primary),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary, // Background color
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primary,
      selectionColor: Color.fromARGB(255, 237, 182, 182),
      selectionHandleColor: AppColors.primary,
    ),
    cupertinoOverrideTheme: CupertinoThemeData(
      primaryColor: AppColors.primary,
      applyThemeToAll: true,
      textTheme: CupertinoTextThemeData(
        primaryColor: AppColors.textPrimaryColor,
        textStyle: textStyleMonumentFontW400.copyWith(
          fontSize: 14,
          color: AppColors.textPrimaryColor,
        ),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white; // Thumb color when active
        }
        return Colors.grey; // Thumb color when inactive
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary; // Track color when active
        }
        return Colors.grey[300]; // Track color when inactive
      }),

      // Define the overlay color to handle thumb size consistency
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      splashRadius: 0.0, // Disable the ripple effect if necessary
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
    ),
    textTheme: const TextTheme().copyWith(
      bodySmall: textStyleMonumentFontW400,
      bodyMedium: textStyleMonumentFontW400,
      bodyLarge: textStyleMonumentFontW400.copyWith(fontSize: 14),
      labelSmall: textStyleMonumentFontW400,
      labelMedium: textStyleMonumentFontW400,
      labelLarge: textStyleMonumentFontW400,
      displaySmall: textStyleMonumentFontW400,
      displayMedium: textStyleMonumentFontW400,
      displayLarge: textStyleMonumentFontW400,
    ));

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  fontFamily: AppFontConstant.ppMonumentFont,
  scaffoldBackgroundColor: AppColors.blackColor,
  dialogBackgroundColor: AppColors.blackColor,
  buttonTheme: const ButtonThemeData(buttonColor: AppColors.primary),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary, // Background color
    ),
  ),
  appBarTheme: const AppBarTheme(
    // systemOverlayStyle:
    //     SystemUiOverlayStyle.dark.copyWith(statusBarColor: AppColors.primary),
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white; // Thumb color when active
      }
      return Colors.grey; // Thumb color when inactive
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary; // Track color when active
      }
      return Colors.grey[300]; // Track color when inactive
    }),

    // Define the overlay color to handle thumb size consistency
    overlayColor: WidgetStateProperty.all(Colors.transparent),
    splashRadius: 0.0, // Disable the ripple effect if necessary
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.primary,
    selectionColor: Color.fromARGB(255, 237, 182, 182),
    selectionHandleColor: AppColors.primary,
  ),
  cupertinoOverrideTheme: CupertinoThemeData(
    primaryColor: AppColors.primary,
    textTheme: CupertinoTextThemeData(
      primaryColor: AppColors.textPrimaryColor,
      textStyle: textStyleMonumentFontW400.copyWith(
        fontSize: 14,
        color: AppColors.textPrimaryColor,
      ),
    ),
  ),
  textTheme: const TextTheme().copyWith(
    bodySmall: textStyleMonumentFontW400,
    bodyMedium: textStyleMonumentFontW400,
    bodyLarge: textStyleMonumentFontW400.copyWith(fontSize: 14),
    labelSmall: textStyleMonumentFontW400,
    labelMedium: textStyleMonumentFontW400,
    labelLarge: textStyleMonumentFontW400,
    displaySmall: textStyleMonumentFontW400,
    displayMedium: textStyleMonumentFontW400,
    displayLarge: textStyleMonumentFontW400,
  ),
);
