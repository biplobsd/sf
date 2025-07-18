import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sf/theme/app_theme.dart';

import '../../../../theme/gaps.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: false,
      snap: false,
      backgroundColor: const Color(0xFFFDFDFD),
      elevation: 0,
      expandedHeight: 100.sp,
      flexibleSpace: SafeArea(
        child: FlexibleSpaceBar(
          background: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 10.sp, 16.w, 0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.house,
                            color: Colors.grey.shade500,
                            size: 14.r,
                          ),
                          gap1,
                          Flexible(
                            child: Text(
                              "76A eighth avenue, New York, US",
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 14.sp,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    gap1,
                    Badge(
                      alignment: Alignment.topRight,
                      smallSize: 8.r,
                      backgroundColor: Colors.transparent,
                      label: Container(
                        padding: EdgeInsets.all(1.5.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(3.5.r),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      child: Icon(
                        FontAwesomeIcons.solidBell,
                        size: 18.r,
                      ),
                    ),
                  ],
                ),
                gap1,
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8.r,
                        offset: Offset(0, 2.h),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search food or restaurant here...",
                      hintStyle: AppTheme.bodyMedium14.copyWith(
                        color: Colors.grey.shade500,
                      ),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 16.w,
                      ),
                      suffixIcon: Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: Colors.grey.shade400,
                        size: 16.r,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.w,
                        ),
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
