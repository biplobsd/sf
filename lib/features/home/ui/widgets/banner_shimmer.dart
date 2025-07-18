import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/ui/widgets/common_shimmer.dart';

class BannerShimmer extends StatelessWidget {
  final bool withOutMargin;
  const BannerShimmer({super.key, this.withOutMargin = false});

  @override
  Widget build(BuildContext context) {
    return CommonShimmer(
      child: Container(
        height: 90.h,
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: withOutMargin ? 0 : 30.w,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}
