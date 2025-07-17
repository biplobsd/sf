import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sf/features/home/ui/view_model/get_banners_view_model.dart';

import '../../../../theme/gaps.dart';
import 'banner_shimmer.dart';

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
              CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: 100,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.85,
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
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(
                                alpha: 0.1,
                              ),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
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
              gap1,
              SizedBox(
                height: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: banners.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _carouselController.animateToPage(entry.key),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: _currentBannerIndex == entry.key ? 8 : 4,
                        height: _currentBannerIndex == entry.key ? 8 : 4,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
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
        error: (error, stack) => Container(),
      ),
    );
  }
}
