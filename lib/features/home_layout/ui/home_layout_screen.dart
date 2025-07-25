import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/ui/under_construction_screen.dart';
import '../../home/ui/home_screen.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/cart_button.dart';
import 'view_model/change_screen_current_index_view_model.dart';
import 'view_model/change_screen_view_model.dart';

class HomeLayoutScreen extends ConsumerStatefulWidget {
  const HomeLayoutScreen({super.key});

  @override
  ConsumerState createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends ConsumerState<HomeLayoutScreen> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void changePage(int index) {
    final currentIndex =
        ref.read(changeScreenCurrentIndexViewModelProvider).value?.index ?? 0;
    if (index == currentIndex) return;

    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    ref.listen(changeScreenViewModelProvider, (previous, next) async {
      if (next is AsyncData) {
        if (next.value?.index != null) {
          changePage(next.value!.index!);
        }
      }
    });

    return Scaffold(
      floatingActionButton: CartButton(() => changePage(2)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: keyboardIsOpened ? null : BottomNavigation(),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          ref
              .read(changeScreenCurrentIndexViewModelProvider.notifier)
              .to(index);
        },
        children: const [
          HomeScreen(),
          UnderConstructionScreen(screenName: "Favorites"),
          UnderConstructionScreen(screenName: "Cart"),
          UnderConstructionScreen(screenName: "Orders"),
          UnderConstructionScreen(screenName: "Settings"),
        ],
      ),
    );
  }
}
