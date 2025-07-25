import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../theme/app_theme.dart';
import '../../../../theme/gaps.dart';
import '../view_model/get_products_view_model.dart';
import 'banner_shimmer.dart';
import 'popular_food_nearby_shimmer.dart';
import 'section_header.dart';
import 'shimmer_error.dart';

class PopularFoodNearbySection extends ConsumerStatefulWidget {
  const PopularFoodNearbySection({super.key});

  @override
  ConsumerState<PopularFoodNearbySection> createState() =>
      _PopularFoodNearbySectionState();
}

class _PopularFoodNearbySectionState
    extends ConsumerState<PopularFoodNearbySection> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(getProductsViewModelProvider.notifier).getProductList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(getProductsViewModelProvider);

    return SliverToBoxAdapter(
      child: asyncValue.when(
        data: (state) {
          if (state.data == null || state.data!.products.isEmpty) {
            return PopularFoodNearbyShimmer();
          }
          final products = state.data!.products;

          return Column(
            children: [
              SectionHeader(
                title: "Popular Food Nearby",
                onPressedViewAll: () {},
              ),
              SizedBox(
                height: 145.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Container(
                      width: 140.w,
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
                            height: 70.h,
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
                              child: CachedNetworkImage(
                                imageUrl: product.imageFullUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => BannerShimmer(
                                  withOutMargin: true,
                                ),
                                errorWidget: (context, url, error) =>
                                    BannerShimmer(
                                  withOutMargin: true,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(7.r),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: AppTheme.titleTiny12,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                gap0_1,
                                Text(
                                  product.restaurantName,
                                  style: AppTheme.bodySmall8.copyWith(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                gap0_2,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '\$${product.price}',
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
                                          product.avgRating.toStringAsFixed(2),
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
          );
        },
        loading: () => PopularFoodNearbyShimmer(),
        error: (error, stack) => ShimmerError(
          shimmer: PopularFoodNearbyShimmer(),
        ),
      ),
    );
  }
}
