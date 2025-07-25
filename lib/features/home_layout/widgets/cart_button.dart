import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_colors.dart';

class CartButton extends StatelessWidget {
  final VoidCallback onTap;
  const CartButton(this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: onTap,
      shape: CircleBorder(),
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.shopping_cart,
          color: AppColors.mono0,
          size: 28.sp,
        ),
      ),
    );
  }
}
