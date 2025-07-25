import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../theme/gaps.dart';
import '../view_model/get_banners_view_model.dart';
import 'banner_shimmer.dart';
import 'shimmer_error.dart';

class BannerSlider extends ConsumerStatefulWidget {
  const BannerSlider({super.key});

  @override
  ConsumerState<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends ConsumerState<BannerSlider> {
  int _currentBannerIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(getBannersViewModelProvider.notifier).getBannerList();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  double viewportFraction() {
    final currentWidth = MediaQuery.of(context).size.width;

    if (currentWidth < 640) {
      return 0.85; // xs: Extra small screens (less than 640px)
    } else if (currentWidth < 768) {
      return 0.65; // sm: Small screens (640px to 767px)
    } else if (currentWidth < 1024) {
      return 0.45; // md: Medium screens (768px to 1023px)
    } else if (currentWidth < 1280) {
      return 0.25; // lg: Large screens (1024px to 1279px)
    } else {
      return 0.25; // xl and 2xl: Extra large screens (1280px and above)
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(getBannersViewModelProvider);

    return SliverToBoxAdapter(
      child: asyncValue.when(
        data: (state) {
          if (state.data == null || state.data!.banners.isEmpty) {
            return BannerShimmer();
          }
          final banners = state.data!.banners;

          return Column(
            children: [
              gap1,
              CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: 100.sp,
                  aspectRatio: 16 / 9,
                  viewportFraction: viewportFraction(),
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.0,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentBannerIndex = index;
                    });
                  },
                ),
                items: banners.map((banner) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: 1.sw,
                        margin: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: CachedNetworkImage(
                            imageUrl: banner.imageFullUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => BannerShimmer(
                              withOutMargin: true,
                            ),
                            errorWidget: (context, url, error) =>
                                BannerShimmer(),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              gap0_5,
              SizedBox(
                height: 10.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: banners.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _carouselController.animateToPage(entry.key),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: _currentBannerIndex == entry.key ? 5.w : 3.w,
                        height: _currentBannerIndex == entry.key ? 5.h : 3.h,
                        margin: EdgeInsets.symmetric(horizontal: 3.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.r),
                          color: _currentBannerIndex == entry.key
                              ? Colors.green
                              : Colors.grey[300],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
        loading: () => BannerShimmer(),
        error: (error, stack) => ShimmerError(
          shimmer: BannerShimmer(),
        ),
      ),
    );
  }
}
