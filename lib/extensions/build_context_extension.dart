import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../features/common/ui/widgets/custom_snack_bar.dart';
import '../theme/app_colors.dart';

extension ThemeModeExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  Color get primaryBackgroundColor =>
      isDarkMode ? AppColors.mono100 : AppColors.mono0;

  Color get secondaryBackgroundColor =>
      isDarkMode ? AppColors.mono100 : AppColors.mono20;

  Color get secondaryWidgetColor =>
      isDarkMode ? AppColors.mono90 : AppColors.mono0;

  Color get primaryTextColor =>
      isDarkMode ? AppColors.mono20 : AppColors.mono100;

  Color get secondaryTextColor =>
      isDarkMode ? AppColors.mono40 : AppColors.mono80;

  Color get dividerColor => isDarkMode ? AppColors.mono80 : AppColors.mono20;

  ThemeData get lightTheme => ThemeData.light().copyWith(
        canvasColor: AppColors.mono0,
        scaffoldBackgroundColor: AppColors.mono0,
        colorScheme: Theme.of(this).colorScheme.copyWith(
              brightness: Brightness.light,
              primary: AppColors.watermelon100,
              error: AppColors.rambutan100,
              surface: AppColors.watermelon100.withAlpha(30), // Surface tint
            ),
        textTheme: Theme.of(this).textTheme.apply(
              bodyColor: AppColors.mono100,
            ),
        primaryColor: AppColors.watermelon100,
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all(AppColors.watermelon100.withAlpha(30)),
            overlayColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.pressed)
                  ? AppColors.watermelon100
                  : null,
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.watermelon100,
          textTheme: ButtonTextTheme.primary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            // borderSide: BorderSide(color: AppColors.blueberry100),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            // borderSide: BorderSide(color: AppColors.blueberry100),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            // borderSide: BorderSide(color: AppColors.rambutan100),
          ),
        ),
      );

  ThemeData get darkTheme => ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.mono100,
        canvasColor: AppColors.mono100,
        colorScheme: Theme.of(this).colorScheme.copyWith(
              brightness: Brightness.dark,
              primary: AppColors.watermelon100,
              error: AppColors.rambutan100,
              surface: AppColors.watermelon100.withAlpha(30),
            ),
        textTheme: Theme.of(this).textTheme.apply(
              bodyColor: AppColors.mono20,
            ),
        primaryColor: AppColors.watermelon100,
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all(AppColors.watermelon100.withAlpha(30)),
            overlayColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.pressed)
                  ? AppColors.watermelon100
                  : null,
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.watermelon100,
          textTheme: ButtonTextTheme.primary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.transparent,
          hintStyle: TextStyle(color: AppColors.mono60),
          // Hint text color
          labelStyle: TextStyle(color: AppColors.watermelon100),
          // Label color
          helperStyle: TextStyle(color: AppColors.mono80),
          // Helper text color
          errorStyle: TextStyle(color: AppColors.rambutan100),
          // Error text color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

  void showSuccessSnackBar(String text) {
    ScaffoldMessenger.of(this).showSnackBar(CustomSnackBar.success(text: text));
  }

  void showInfoSnackBar(String text) {
    ScaffoldMessenger.of(this).showSnackBar(CustomSnackBar.info(text: text));
  }

  void showWarningSnackBar(String text) {
    ScaffoldMessenger.of(this).showSnackBar(CustomSnackBar.warning(text: text));
  }

  void showErrorSnackBar(String text) {
    ScaffoldMessenger.of(this).showSnackBar(CustomSnackBar.error(text: text));
  }

  void tryLaunchUrl(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      if (mounted) {
        showErrorSnackBar('Cannot open url: $url');
      }
    }
  }
}
