import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../extensions/build_context_extension.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/gaps.dart';
import '../../home/ui/home_screen.dart';

class HomeLayoutScreen extends ConsumerStatefulWidget {
  const HomeLayoutScreen({super.key});

  @override
  ConsumerState createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends ConsumerState<HomeLayoutScreen> {
  var _currentIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 1.0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _changePage(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor =
        context.isDarkMode ? AppColors.blueberry100 : AppColors.blueberry100;
    final unselectedColor =
        context.isDarkMode ? AppColors.mono40 : AppColors.mono60;
    final borderColor = context.isDarkMode
        ? AppColors.blueberry20.withAlpha(10)
        : AppColors.blueberry20.withAlpha(150);
    final backgroundColor =
        context.isDarkMode ? AppColors.mono100 : AppColors.mono0;
    return Scaffold(
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10.sp,
          children: [
            _buildNavItem(0, Icons.home, Icons.home_outlined, 'menu_home',
                selectedColor, unselectedColor),
            _buildNavItem(1, Icons.person_2, Icons.person_2_outlined,
                'menu_profile', selectedColor, unselectedColor),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: PageView(
        controller: _pageController,
        pageSnapping: true,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          HomeScreen(),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      int index,
      IconData selectedIcon,
      IconData unselectedIcon,
      String label,
      Color selectedColor,
      Color unselectedColor) {
    final isSelected = _currentIndex == index;

    return Container(
      margin: EdgeInsets.all(5.sp),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: () => _changePage(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? selectedColor.withAlpha(20)
                  : const Color.fromARGB(0, 83, 34, 34),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  isSelected ? selectedIcon : unselectedIcon,
                  color: isSelected ? selectedColor : unselectedColor,
                  size: 28.sp,
                ),
                gap0_5,
                Text(
                  label,
                  style: AppTheme.titleTiny12.copyWith(
                    color: isSelected ? selectedColor : unselectedColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
