import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar.error({
    super.key,
    required String text,
  }) : super(
          content: Row(
            children: [
              const Icon(Icons.close, size: 24, color: AppColors.mono0),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  text,
                  style: AppTheme.bodyMedium14.copyWith(color: AppColors.mono0),
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.rambutan100,
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 32),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          behavior: SnackBarBehavior.floating,
        );
}
