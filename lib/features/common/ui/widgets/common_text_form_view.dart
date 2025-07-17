import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../extensions/build_context_extension.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme.dart';
import '../../../../theme/gaps.dart';

class CommonTextFormView extends StatelessWidget {
  const CommonTextFormView(
      {super.key,
      this.labelText,
      required this.text,
      this.suffix,
      this.maxLines,
      this.bgColor});

  final String? labelText;
  final String text;
  final Widget? suffix;
  final int? maxLines;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText != null) ...[
            Text(
              labelText!,
              style: AppTheme.titleExtraSmall14.copyWith(
                  color:
                      context.isDarkMode ? AppColors.mono40 : AppColors.mono90),
            ),
            gap0_5
          ],
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.sp),
              border: Border.all(
                  color:
                      (context.isDarkMode ? AppColors.mono60 : AppColors.mono20)
                          .withAlpha(80)),
              color: bgColor ??
                  (context.isDarkMode ? AppColors.mono90 : AppColors.mono0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: AppTheme.bodyMedium14.copyWith(
                      color: context.isDarkMode
                          ? AppColors.mono40
                          : AppColors.mono90,
                    ),
                    maxLines: maxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                suffix ?? const SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
