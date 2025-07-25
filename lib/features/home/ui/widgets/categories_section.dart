import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../theme/app_theme.dart';
import '../../../../theme/gaps.dart';
import '../view_model/get_categories_view_model.dart';
import 'banner_shimmer.dart';
import 'categories_shimmer.dart';
import 'section_header.dart';
import 'shimmer_error.dart';

class CategoriesSection extends ConsumerStatefulWidget {
  const CategoriesSection({super.key});

  @override
  ConsumerState<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends ConsumerState<CategoriesSection> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(getCategoriesViewModelProvider.notifier).getCategoriesList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(getCategoriesViewModelProvider);

    return SliverToBoxAdapter(
      child: asyncValue.when(
        data: (state) {
          if (state.data.isEmpty) {
            return CategoriesShimmer();
          }
          final categories = state.data;

          return Column(
            children: [
              SectionHeader(
                title: "Categories",
                onPressedViewAll: () {},
              ),
              SizedBox(
                height: 70.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return SizedBox(
                      width: 70.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.15),
                                  blurRadius: 4.r,
                                  offset: Offset(0, 2.h),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Center(
                                child: CachedNetworkImage(
                                  width: 50.w,
                                  height: 50.h,
                                  imageUrl: category.imageFullUrl,
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
                          ),
                          gap0_5,
                          Text(
                            category.name,
                            style: AppTheme.titleExtraTiny10,
                            textAlign: TextAlign.center,
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
        loading: () => CategoriesShimmer(),
        error: (error, stack) => ShimmerError(
          shimmer: CategoriesShimmer(),
        ),
      ),
    );
  }
}
