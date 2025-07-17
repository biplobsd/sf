import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../extensions/build_context_extension.dart';
import '../../../../features/common/ui/widgets/common_back_button.dart';
import '../../../../theme/app_theme.dart';

class CommonHeader extends ConsumerWidget {
  final String header;
  final bool isShowBack;
  final Color? bg;
  final Widget? tailing;

  const CommonHeader({
    super.key,
    required this.header,
      this.isShowBack = true,
      this.bg,
      this.tailing});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top + 16,
        left: 6,
        right: 6,
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: bg ?? context.secondaryWidgetColor,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isShowBack) const CommonBackButton(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              header,
              style: AppTheme.titleSmall16,
            ),
          ),
          if (tailing != null) tailing! else SizedBox(width: 36.sp),
        ],
      ),
    );
  }
}
