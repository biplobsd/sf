import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../constants/assets.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme.dart';
import '../../../../theme/gaps.dart';

class LoadingLogo extends StatefulWidget {
  const LoadingLogo({super.key, this.isBlur = true, this.bgColor});

  final bool isBlur;
  final Color? bgColor;

  @override
  _LoadingLogoState createState() => _LoadingLogoState();
}

class _LoadingLogoState extends State<LoadingLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _zoomController;
  late Animation<double> _zoomAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _zoomController = AnimationController(
      duration: const Duration(seconds: 2), // Slow zoom over 2 seconds
      vsync: this,
    );

    // Create a curved animation for a smooth zoom effect
    _zoomAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _zoomController,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation when the widget is first created
    _zoomController.forward();
  }

  @override
  void dispose() {
    // Always dispose of the controller when no longer needed
    _zoomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      enabled: widget.isBlur,
      filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
      child: Container(
        constraints: const BoxConstraints.expand(),
        color: widget.bgColor ?? AppColors.mono100.withAlpha(100),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.blueberry100,
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: [
                // Wrap the logo with ScaleTransition for zoom effect
                Align(
                  alignment: Alignment.center,
                  child: ScaleTransition(
                    scale: _zoomAnimation,
                    child: Image.asset(
                      Assets.logo,
                      width: 130.sp,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: 110.sp),
                    child: Lottie.asset(
                      Assets.loading,
                      width: 60,
                      delegates: LottieDelegates(
                        values: [
                          ValueDelegate.color(
                            const ['**'], // Targets all colors
                            value: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 30.sp,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.sp,
                            vertical: 5.sp,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mono0.withAlpha(50),
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Made in Bangladesh",
                                style: AppTheme.bodySmall12.copyWith(
                                  color: AppColors.mono0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        gap0_5,
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.sp,
                            vertical: 5.sp,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mono0.withAlpha(50),
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Developed by",
                                style: AppTheme.bodySmall12.copyWith(
                                  color: AppColors.mono0,
                                ),
                              ),
                              gap0_2,
                              Text(
                                "SpeedOut Source",
                                style: AppTheme.bodySmall12.copyWith(
                                  color: AppColors.mono0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
