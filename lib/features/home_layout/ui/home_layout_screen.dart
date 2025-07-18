import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sf/features/common/ui/under_construction_screen.dart';
import 'package:sf/features/home_layout/ui/view_model/change_screen_view_model.dart';

import '../../../extensions/build_context_extension.dart';
import '../../../theme/app_colors.dart';
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
    final selectedColor = AppColors.watermelon100;
    final unselectedColor =
        context.isDarkMode ? AppColors.mono40 : AppColors.mono60;
    final borderColor = context.isDarkMode
        ? AppColors.blueberry20.withAlpha(10)
        : AppColors.blueberry20.withAlpha(150);
    final backgroundColor =
        context.isDarkMode ? AppColors.mono100 : AppColors.mono0;

    ref.listen(changeScreenViewModelProvider, (previous, next) async {
      if (next is AsyncData) {
        if (next.value?.index != null) {
          _changePage(next.value!.index!);
        }
      }
    });

    return Scaffold(
      floatingActionButton: Container(
        height: 60.h,
        width: 60.w,
        margin: EdgeInsets.only(top: 15.h),
        child: FloatingActionButton(
          elevation: 0,
          onPressed: () => _changePage(2), // Navigate to Cart
          backgroundColor: selectedColor,
          shape: CircleBorder(),
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: selectedColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shopping_cart,
              color: backgroundColor,
              size: 28.sp,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border(
            top: BorderSide(
              color: borderColor,
              width: 1.w,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(0, Icons.home, Icons.home_outlined, selectedColor,
                unselectedColor),
            _buildNavItem(1, Icons.favorite, Icons.favorite_border,
                selectedColor, unselectedColor),
            Opacity(
              opacity: 0,
              child: _buildCartItem(
                selectedColor,
                backgroundColor,
              ),
            ),
            _buildNavItem(3, Icons.receipt_long, Icons.receipt_long_outlined,
                selectedColor, unselectedColor),
            _buildNavItem(4, Icons.menu, Icons.menu_outlined, selectedColor,
                unselectedColor),
          ],
        ),
      ),
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
          UnderConstructionScreen(screenName: "Favorites"),
          UnderConstructionScreen(screenName: "Cart"),
          UnderConstructionScreen(screenName: "Orders"),
          UnderConstructionScreen(screenName: "Settings"),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData selectedIcon,
      IconData unselectedIcon, Color selectedColor, Color unselectedColor) {
    final isSelected = _currentIndex == index;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        onTap: () => _changePage(index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          child: Icon(
            isSelected ? selectedIcon : unselectedIcon,
            color: isSelected ? selectedColor : unselectedColor,
            size: 28.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildCartItem(Color selectedColor, Color backgroundColor) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30.r),
        onTap: () => _changePage(2),
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: selectedColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.shopping_cart,
            color: backgroundColor,
            size: 24.sp,
          ),
        ),
      ),
    );
  }
}
