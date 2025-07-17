import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/about/ui/about_screen.dart';
import '../features/home_layout/ui/home_layout_screen.dart';
import '../features/onboarding/ui/splash_screen.dart';
import '../routing/routes.dart';

enum SlideDirection {
  right,
  left,
  up,
  down,
}

extension GoRouterStateExtension on GoRouterState {
  SlideRouteTransition slidePage(
    Widget child, {
    SlideDirection direction = SlideDirection.left,
  }) {
    return SlideRouteTransition(
      key: pageKey,
      child: child,
      direction: direction,
    );
  }
}

class SlideRouteTransition extends CustomTransitionPage<void> {
  SlideRouteTransition({
    required super.key,
    required super.child,
    SlideDirection direction = SlideDirection.left,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curve = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            );

            Offset begin;
            switch (direction) {
              case SlideDirection.right:
                begin = const Offset(-1.0, 0.0);
                break;
              case SlideDirection.left:
                begin = const Offset(1.0, 0.0);
                break;
              case SlideDirection.up:
                begin = const Offset(0.0, 1.0);
                break;
              case SlideDirection.down:
                begin = const Offset(0.0, -1.0);
                break;
            }
            final tween = Tween(begin: begin, end: Offset.zero);
            final offsetAnimation = tween.animate(curve);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}

final GoRouter router = GoRouter(
  initialLocation: Routes.splash,
  routes: [
    GoRoute(
      path: Routes.splash,
      pageBuilder: (context, state) => state.slidePage(const SplashScreen()),
    ),
    GoRoute(
      path: Routes.home,
      pageBuilder: (context, state) =>
          state.slidePage(const HomeLayoutScreen()),
    ),
    GoRoute(
      path: Routes.about,
      pageBuilder: (context, state) => state.slidePage(
        const About(),
      ),
    ),
  ],
);
