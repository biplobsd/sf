import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/assets.dart';
import '../../../../extensions/build_context_extension.dart';
import '../../../../theme/app_theme.dart';
import '../../../../theme/gaps.dart';

class CommonEmptyData extends StatelessWidget {
  const CommonEmptyData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100.w,
            height: 100.h,
            child: Image.asset(Assets.empty),
          ),
          gap1,
          Text(
            'No data available',
            style: AppTheme.bodyMedium14.copyWith(
              color: context.secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
