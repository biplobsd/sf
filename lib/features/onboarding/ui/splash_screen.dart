import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routing/routes.dart';
import '../../common/ui/widgets/loading_logo.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _checkLoginStatus(ref, context);
    return Scaffold(
      body: Center(
        child: LoadingLogo(
          isBlur: false,
          bgColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }

  Future<void> _checkLoginStatus(WidgetRef ref, BuildContext context) async {
    // Simulate a network call or some initialization logic
    await Future.delayed(const Duration(seconds: 1));

    // Here you would typically check if the user is logged in or not.
    if (!context.mounted) return;

    // For demonstration, let's assume the user is not logged in.
    context.pushReplacement(Routes.home);
  }
}
