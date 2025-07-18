import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sf/features/home/ui/widgets/section_header.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../theme/app_theme.dart';
import '../../../../theme/gaps.dart';
import 'banner_shimmer.dart';

class PopularFoodNearbyShimmer extends StatelessWidget {
  const PopularFoodNearbyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Column(
        children: [
          SectionHeader(
            title: "Popular Food Nearby",
            onPressedViewAll: () {},
          ),
          SizedBox(
            height: 190.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              itemBuilder: (context, index) {
                return Container(
                  width: 160.w,
                  margin: EdgeInsets.only(right: 16.w, bottom: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: 0.1,
                        ),
                        blurRadius: 8.r,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.r),
                            topRight: Radius.circular(12.r),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.r),
                            topRight: Radius.circular(12.r),
                          ),
                          child: const BannerShimmer(withOutMargin: true),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Food Name',
                              style: AppTheme.titleTiny12,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            gap0_1,
                            Text(
                              'Restaurant Name',
                              style: AppTheme.bodySmall8.copyWith(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            gap0_2,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$--.--',
                                  style: AppTheme.titleTiny12,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.green,
                                      size: 12.sp,
                                    ),
                                    gap0_1,
                                    Text(
                                      '--.-',
                                      style: AppTheme.bodySmall12Colored,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
