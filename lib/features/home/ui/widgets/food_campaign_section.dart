import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sf/features/home/ui/view_model/get_campaigns_view_model.dart';

import '../../../../theme/app_theme.dart';
import '../../../../theme/gaps.dart';
import 'banner_shimmer.dart';
import 'food_campaign_shimmer.dart';
import 'section_header.dart';
import 'shimmer_error.dart';

class FoodCampaignSection extends ConsumerStatefulWidget {
  const FoodCampaignSection({super.key});

  @override
  ConsumerState<FoodCampaignSection> createState() =>
      _FoodCampaignSectionState();
}

class _FoodCampaignSectionState extends ConsumerState<FoodCampaignSection> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(getCampaignsViewModelProvider.notifier).getCampaignsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(getCampaignsViewModelProvider);

    return SliverToBoxAdapter(
      child: asyncValue.when(
        data: (state) {
          if (state.data.isEmpty) {
            return FoodCampaignShimmer();
          }
          final campaigns = state.data;

          return Column(
            children: [
              SectionHeader(
                title: "Food Campaign",
                onPressedViewAll: () {},
              ),
              SizedBox(
                height: 100.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: campaigns.length,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  itemBuilder: (context, index) {
                    final food = campaigns[index];
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
                              // Food Image
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
                                  child: Center(
                                    child: CachedNetworkImage(
                                      imageUrl: food.imageFullUrl,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          BannerShimmer(
                                        withOutMargin: true,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          BannerShimmer(
                                        withOutMargin: true,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Food Details
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.w,
                                    vertical: 6.h,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 1.h,
                                    children: [
                                      Text(
                                        food.name,
                                        style: AppTheme.titleTiny12,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            text: food.restaurantName,
                                            style:
                                                AppTheme.bodySmall10.copyWith(
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.w600,
                                            ),
                                            // children: [
                                            //   TextSpan(
                                            //     text: '',
                                            //     style:
                                            //     AppTheme.bodySmall10.copyWith(
                                            //       color: Colors.grey[500],
                                            //       fontWeight: FontWeight.w400,
                                            //     ),
                                            //   ),
                                            // ],
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Row(
                                        children: List.generate(5, (starIndex) {
                                          return Icon(
                                            Icons.star,
                                            color: starIndex <
                                                    food.ratingCount.round()
                                                ? Colors.green
                                                : Colors.grey[300],
                                            size: 12.r,
                                          );
                                        }),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            '\$${food.price}',
                                            style: AppTheme.titleTiny12,
                                          ),
                                          gap1,
                                          Text(
                                            '\$${food.price + food.discount * food.price / 100}',
                                            style:
                                                AppTheme.titleTiny12.copyWith(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.grey,
                                              decorationColor:
                                                  Colors.grey.shade800,
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
                              margin: EdgeInsets.only(
                                top: 16.h,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5.r),
                                  bottomRight: Radius.circular(5.r),
                                ),
                              ),
                              child: Text(
                                '${food.discount}% off',
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
                                size: 25.r,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
        loading: () => FoodCampaignShimmer(),
        error: (error, stack) => ShimmerError(
          shimmer: FoodCampaignShimmer(),
        ),
      ),
    );
  }
}
