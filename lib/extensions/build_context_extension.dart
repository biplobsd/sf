import 'package:flutter/material.dart';

import '../features/common/ui/widgets/custom_snack_bar.dart';
import '../theme/app_colors.dart';

extension ThemeModeExtension on BuildContext {
  Color get secondaryTextColor => AppColors.mono80;

  ThemeData get lightTheme => ThemeData.light().copyWith(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: Theme.of(this).colorScheme.copyWith(
              brightness: Brightness.light,
              primary: AppColors.watermelon100,
              error: AppColors.rambutan100,
              surface: AppColors.watermelon100.withAlpha(30),
            ),
        textTheme: Theme.of(this).textTheme.apply(
              bodyColor: AppColors.mono100,
            ),
      );

  void showErrorSnackBar(String text) {
    ScaffoldMessenger.of(this).showSnackBar(CustomSnackBar.error(text: text));
  }
}
