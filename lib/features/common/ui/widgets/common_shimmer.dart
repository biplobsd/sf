import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../theme/app_colors.dart';

class CommonShimmer extends StatelessWidget {
  final Widget child;

  const CommonShimmer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.gradient10,
      highlightColor: AppColors.gradient0,
      child: child,
    );
  }
}
