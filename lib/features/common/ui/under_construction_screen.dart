import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_theme.dart';
import '../../../theme/gaps.dart';
import '../../home_layout/ui/view_model/change_screen_view_model.dart';

class UnderConstructionScreen extends ConsumerWidget {
  final String screenName;

  const UnderConstructionScreen({super.key, required this.screenName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 80.h,
            ),
            gap1,
            Text(
              'Under Construction',
              style: AppTheme.headLineLarge32Colored,
            ),
            gap1,
            Text(
              '$screenName is being built',
              style: AppTheme.bodyMedium14,
              textAlign: TextAlign.center,
            ),
            gap2,
            SizedBox(
              width: 200.w,
              child: LinearProgressIndicator(),
            ),
            gap0_5,
            Text(
              'Coming Soon!',
              style: AppTheme.bodySmall12,
            ),
            gap4,
            ElevatedButton.icon(
              onPressed: () {
                // Base on current implementation, this will navigate back to the first screen
                ref.read(changeScreenViewModelProvider.notifier).to(0);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go Back'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 12.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
