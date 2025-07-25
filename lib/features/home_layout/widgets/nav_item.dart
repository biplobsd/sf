import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_colors.dart';
import '../ui/view_model/change_screen_current_index_view_model.dart';
import '../ui/view_model/change_screen_view_model.dart';

class NavItem extends ConsumerWidget {
  final IconData selectedIcon;
  final IconData unselectedIcon;
  final int id;

  const NavItem(
    this.selectedIcon,
    this.unselectedIcon,
    this.id, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = AppColors.watermelon100;
    final unselectedColor = AppColors.mono60;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        onTap: () {
          ref.read(changeScreenViewModelProvider.notifier).to(id);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 16.w,
          ),
          child: Consumer(
            builder: (context, ref, child) {
              final value =
                  ref.watch(changeScreenCurrentIndexViewModelProvider);
              final isSelected = (value.valueOrNull?.index ?? 0) == id;
              return Icon(
                isSelected ? selectedIcon : unselectedIcon,
                color: isSelected ? selectedColor : unselectedColor,
                size: 28.sp,
              );
            },
          ),
        ),
      ),
    );
  }
}
