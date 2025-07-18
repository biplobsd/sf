import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'extensions/build_context_extension.dart';
import 'features/common/ui/providers/app_theme_mode_provider.dart';
import 'features/common/ui/widgets/offline_container.dart';
import 'routing/router.dart';
import 'utils/provider_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Performance optimizations for release mode
  if (kReleaseMode) {
    // Disable debug flags
    debugPrintRebuildDirtyWidgets = false;
    debugPrint = (String? message, {int? wrapWidth}) {};

    // Optimize for performance
    PaintingBinding.instance.imageCache.maximumSizeBytes =
        1024 * 1024 * 100; // 100 MB

    // Set preferred orientations for better performance
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  await ScreenUtil.ensureScreenSize();

  runApp(
    ProviderScope(
      observers: kDebugMode ? [AppObserver()] : [],
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeProvider);

    return MaterialApp.router(
      theme: context.lightTheme,
      darkTheme: context.darkTheme,
      themeMode: themeMode.value,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
      ),
      builder: (context, child) {
        ScreenUtil.init(
          context,
          minTextAdapt: true,
        );
        ScreenUtil.enableScale(enableWH: () => false, enableText: () => false);
        return OfflineContainer(child: child);
      },
    );
  }
}
