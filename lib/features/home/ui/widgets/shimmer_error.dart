import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/ui/widgets/common_error.dart';

class ShimmerError extends StatelessWidget {
  final Widget shimmer;
  final double? paddingBottom;
  const ShimmerError({
    super.key,
    required this.shimmer,
    this.paddingBottom,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: paddingBottom ?? 0.h),
      child: Stack(
        alignment: Alignment.center,
        children: [shimmer, CommonError()],
      ),
    );
  }
}
