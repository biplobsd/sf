import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'extensions/build_context_extension.dart';
import 'features/common/ui/widgets/offline_container.dart';
import 'routing/router.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();

  runApp(
    ProviderScope(
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: context.lightTheme,
      themeMode: ThemeMode.light,
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
        ScreenUtil.enableScale(
          enableWH: () => false,
          enableText: () => false,
        );
        return OfflineContainer(child: child);
      },
    );
  }
}
