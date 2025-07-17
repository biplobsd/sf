import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/build_context_extension.dart';
import 'app_colors.dart';
import 'app_theme.dart';

class AppStyles {
  AppStyles._();

  static customDropdownDecoration(BuildContext context) =>
      CustomDropdownDecoration(
        searchFieldDecoration: SearchFieldDecoration(
          fillColor: context.isDarkMode ? AppColors.mono100 : AppColors.mono20,
        ),
        listItemDecoration: ListItemDecoration(
          selectedColor:
              context.isDarkMode ? AppColors.mono80 : AppColors.mono20,
        ),
        closedFillColor:
            context.isDarkMode ? AppColors.mono90 : AppColors.mono0,
        expandedBorder: Border.all(
          color: context.isDarkMode ? AppColors.mono60 : AppColors.mono20,
        ),
        expandedFillColor: context.isDarkMode ? AppColors.mono90 : Colors.white,
        closedBorder: Border.all(
          color: context.isDarkMode ? AppColors.mono40 : AppColors.mono20,
        ),
        closedBorderRadius: BorderRadius.circular(10.sp),
        headerStyle: AppTheme.bodySmall12,
        listItemStyle: AppTheme.bodySmall12,
        hintStyle: AppTheme.bodySmall12.copyWith(
          color: context.isDarkMode ? AppColors.mono20 : AppColors.mono100,
        ),
      );
}
