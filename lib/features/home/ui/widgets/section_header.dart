import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final void Function() onPressedViewAll;
  const SectionHeader({
    super.key,
    required this.onPressedViewAll,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 3.h, 16.w, 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTheme.titleExtraSmall14,
          ),
          TextButton(
            onPressed: onPressedViewAll,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              minimumSize: Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              "View All",
              style: AppTheme.titleTiny12.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: AppColors.watermelon80,
                color: AppColors.watermelon80,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
