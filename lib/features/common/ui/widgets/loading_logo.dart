import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../constants/assets.dart';
import '../../../../theme/app_colors.dart';

class LoadingLogo extends StatefulWidget {
  const LoadingLogo({super.key, this.isBlur = true, this.bgColor});

  final bool isBlur;
  final Color? bgColor;

  @override
  LoadingLogoState createState() => LoadingLogoState();
}

class LoadingLogoState extends State<LoadingLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _zoomController;
  late Animation<double> _zoomAnimation;

  @override
  void initState() {
    super.initState();

    _zoomController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _zoomAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _zoomController,
        curve: Curves.easeInOut,
      ),
    );

    _zoomController.forward();
  }

  @override
  void dispose() {
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
              color: widget.bgColor ?? AppColors.mono100.withAlpha(100),
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ScaleTransition(
                    scale: _zoomAnimation,
                    child: Image.asset(
                      Assets.fullLogo,
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
                      width: 60.w,
                      delegates: LottieDelegates(
                        values: [
                          ValueDelegate.color(
                            const ['**'],
                            value: AppColors.watermelon100,
                          ),
                        ],
                      ),
                    ),
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
