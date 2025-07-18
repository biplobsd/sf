import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sf/extensions/build_context_extension.dart';
import 'package:sf/features/home/ui/view_model/get_restaurants_view_model.dart';

import '../../../../theme/app_theme.dart';
import '../../../common/ui/widgets/common_empty_data.dart';
import '../../model/restaurant.dart';
import 'banner_shimmer.dart';

class RestaurantsLayout extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  const RestaurantsLayout({
    super.key,
    required this.scrollController,
  });

  @override
  ConsumerState<RestaurantsLayout> createState() => _RestaurantsLayoutState();
}

class _RestaurantsLayoutState extends ConsumerState<RestaurantsLayout> {
  bool _isLoading = false;
  bool _hasMoreData = true;
  bool _needsMoreContent = false;
  bool isNotFirstLaunch = false;
  final List<Restaurant> _restaurantsData = [];

  void _onScroll() {
    if (widget.scrollController.position.pixels >=
            widget.scrollController.position.maxScrollExtent - 100 &&
        !_isLoading &&
        _hasMoreData) {
      final ctl = ref.read(getRestaurantsViewModelProvider.notifier);
      ctl.getAll();
    }
  }

  Future<void> _checkIfMoreContentNeeded() async {
    if (widget.scrollController.hasClients) {
      if (widget.scrollController.position.maxScrollExtent < 50 &&
          _hasMoreData) {
        _needsMoreContent = true;
        final ctl = ref.read(getRestaurantsViewModelProvider.notifier);
        await ctl.getAll();
      } else {
        _needsMoreContent = false;
      }
    }
  }

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(getRestaurantsViewModelProvider.notifier).getAll(
            isReset: true,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(getRestaurantsViewModelProvider, (previous, next) async {
      if (next.isLoading != previous?.isLoading && mounted) {
        if (next.isLoading == true) {
          setState(() {
            _isLoading = true;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      }

      if (next is AsyncError) {
        context.showErrorSnackBar(next.error.toString());
      }

      if (next is AsyncData) {
        if (next.value?.data != null) {
          final result = next.value!.data;

          if (next.value!.currentOffset == 1) {
            _restaurantsData.clear();
          }

          if (result.isEmpty) {
            setState(() {
              _hasMoreData = false;
            });
          } else {
            setState(() {
              _restaurantsData.addAll(result);
              _hasMoreData = next.value!.hasMore!;
            });

            WidgetsBinding.instance.addPostFrameCallback((_) {
              _checkIfMoreContentNeeded();
            });
          }
        }
      }
    });

    if (_restaurantsData.isEmpty && !_isLoading) {
      return SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: const CommonEmptyData(),
        ),
      );
    }

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index == _restaurantsData.length) {
              return _isLoading || _needsMoreContent
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : const SizedBox.shrink();
            }

            final restaurant = _restaurantsData[index];
            return Container(
              margin: EdgeInsets.only(bottom: 10.h),
              padding: EdgeInsets.only(right: 5.w),
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 70.h,
                    width: 80.w,
                    margin: EdgeInsets.all(3.r),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Center(
                        child: CachedNetworkImage(
                          height: 70.h,
                          width: 80.w,
                          imageUrl: restaurant.logoFullUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => BannerShimmer(
                            withOutMargin: true,
                          ),
                          errorWidget: (context, url, error) => BannerShimmer(
                            withOutMargin: true,
                          ),
                        ),
                      ),
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
                        spacing: 1.h,
                        children: [
                          Text(
                            restaurant.name,
                            style: AppTheme.titleTiny12,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            restaurant.name,
                            style: AppTheme.bodySmall10.copyWith(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: List.generate(5, (starIndex) {
                              return Icon(
                                Icons.star,
                                color:
                                    starIndex < restaurant.ratingCount.round()
                                        ? Colors.green
                                        : Colors.grey[300],
                                size: 12.sp,
                              );
                            }),
                          ),
                          Text(
                            restaurant.address,
                            style: AppTheme.bodySmall10,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(5.r),
                          ),
                          minimumSize: WidgetStateProperty.all<Size>(
                            Size(0, 0),
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.grey.shade400,
                          size: 20.sp,
                        ),
                      ),
                      IconButton(
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(5.r),
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
                          color: Colors.black87,
                          size: 20.sp,
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
          childCount: _restaurantsData.length + (_hasMoreData ? 1 : 0),
        ),
      ),
    );
  }
}
