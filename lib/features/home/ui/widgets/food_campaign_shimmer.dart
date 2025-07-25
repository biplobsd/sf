import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../theme/app_theme.dart';
import '../../../../theme/gaps.dart';
import 'banner_shimmer.dart';
import 'section_header.dart';

class FoodCampaignShimmer extends StatelessWidget {
  const FoodCampaignShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Column(
        children: [
          SectionHeader(
            title: "Food Campaign",
            onPressedViewAll: () {},
          ),
          SizedBox(
            height: 100.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              itemBuilder: (context, index) {
                return Container(
                  width: 220.w,
                  margin: EdgeInsets.only(right: 16.w, bottom: 20.h),
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
                  child: Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 80.h,
                            width: 70.w,
                            margin: EdgeInsets.all(3.r),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: const BannerShimmer(withOutMargin: true),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 6.h,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Food Name',
                                    style: AppTheme.titleTiny12,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 1.h),
                                  Expanded(
                                    child: Text(
                                      'Restaurant Name',
                                      style: AppTheme.bodySmall10.copyWith(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    children: List.generate(5, (starIndex) {
                                      return Icon(
                                        Icons.star,
                                        color: starIndex < 4
                                            ? Colors.green
                                            : Colors.grey[300],
                                        size: 12.sp,
                                      );
                                    }),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '\$--.--',
                                        style: AppTheme.titleTiny12,
                                      ),
                                      gap1,
                                      Text(
                                        '\$--.--',
                                        style: AppTheme.titleTiny12.copyWith(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.grey,
                                          decorationColor: Colors.grey.shade800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.only(top: 16.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400.withValues(
                              alpha: 0.3,
                            ),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5.r),
                              bottomRight: Radius.circular(5.r),
                            ),
                          ),
                          child: Text(
                            '--% off',
                            style: AppTheme.bodySmall10.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(8.r),
                            ),
                            minimumSize: WidgetStateProperty.all<Size>(
                              Size(0, 0),
                            ),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: Icon(
                            Icons.add_outlined,
                            color: Colors.black,
                            size: 25.sp,
                          ),
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
