import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
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
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              minimumSize: Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              "View All",
              style: AppTheme.titleExtraSmall14Colored.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: AppColors.watermelon100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
