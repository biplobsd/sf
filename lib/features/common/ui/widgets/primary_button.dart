import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../extensions/build_context_extension.dart';
import '../../../../features/common/ui/widgets/material_ink_well.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme.dart';
import '../../../../theme/gaps.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Widget? icon;
  final Color? textColor;
  final Color? backgroundColor;
  final double? verticalPadding;
  final bool isEnable;
  final bool isIconRow;
  final double? height;
  final TextStyle? textStyle;
  final bool isOutline; // New parameter for outline button
  final bool setBlocked;

  const PrimaryButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.icon,
      this.textColor,
      this.backgroundColor,
      this.verticalPadding,
      this.isEnable = true,
      this.isIconRow = true,
      this.height,
      this.textStyle,
      this.isOutline = false, // Default value for outline
      this.setBlocked = true});

  @override
  Widget build(BuildContext context) {
    final txtColor =
        textColor ?? (isOutline ? AppColors.mono80 : AppColors.mono0);
    final bgColor = backgroundColor ?? AppColors.blueberry100;

    final items = [
      icon ?? const SizedBox(),
      gap0_5,
      Text(
        text,
        style: textStyle ??
            AppTheme.titleSmall16.copyWith(
              color: isEnable ? txtColor : AppColors.mono60,
            ),
      ),
    ];

    return Container(
      height: height ?? 48.sp,
      decoration: BoxDecoration(
        color: isEnable
            ? (isOutline ? Colors.transparent : bgColor)
            : (context.isDarkMode ? AppColors.mono90 : AppColors.mono40),
        borderRadius: BorderRadius.circular(10.sp),
        border: isOutline
            ? Border.all(color: txtColor, width: 2) // Outline border
            : null,
      ),
      child: MaterialInkWell(
        onTap: isEnable ? onPressed : null,
        radius: 10.sp,
        child: Container(
          width: setBlocked ? double.infinity : null,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding ?? 14.sp,
            horizontal: 10.sp,
          ),
          child: icon != null
              ? isIconRow
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: items,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: items,
                    )
              : Text(
                  text,
                  style: textStyle ??
                      AppTheme.titleSmall16.copyWith(
                        color: isEnable ? txtColor : AppColors.mono60,
                      ),
                ),
        ),
      ),
    );
  }
}
