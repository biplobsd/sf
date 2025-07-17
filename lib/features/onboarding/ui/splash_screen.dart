import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routing/routes.dart';
import '../../../theme/app_colors.dart';
import '../../common/ui/widgets/loading_logo.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _checkLoginStatus(ref, context);
    return Scaffold(
      backgroundColor: AppColors.blueberry100,
      body: Center(
        child: LoadingLogo(isBlur: false, bgColor: AppColors.blueberry100),
      ),
    );
  }

  Future<void> _checkLoginStatus(WidgetRef ref, BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    if (!context.mounted) return;
    context.pushReplacement(Routes.home);
  }
}
