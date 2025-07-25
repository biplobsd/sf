import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/gaps.dart';
import 'nav_item.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        color: AppColors.mono0,
        border: Border(
          top: BorderSide(
            color: AppColors.blueberry20.withAlpha(150),
            width: 1.w,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavItem(Icons.home, Icons.home_outlined, 0),
          NavItem(Icons.favorite, Icons.favorite_border, 1),
          gap4,
          NavItem(Icons.receipt_long, Icons.receipt_long_outlined, 3),
          NavItem(Icons.menu, Icons.menu_outlined, 4),
        ],
      ),
    );
  }
}
