import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/common/ui/under_construction_screen.dart';
import '../features/home_layout/ui/home_layout_screen.dart';
import '../features/onboarding/ui/splash_screen.dart';
import '../routing/routes.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.splash,
  routes: [
    GoRoute(
      path: Routes.splash,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: Routes.home,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const HomeLayoutScreen(),
      ),
    ),
    GoRoute(
      path: Routes.underConstruction,
      pageBuilder: (context, state) {
        final screenName = state.uri.queryParameters['screenName'] ?? 'Unknown';
        return MaterialPage(
          key: state.pageKey,
          child: UnderConstructionScreen(screenName: screenName),
        );
      },
    ),
  ],
);
