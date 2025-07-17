import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sf/features/home/ui/view_model/get_campaigns_view_model.dart';

import '../../../../theme/app_theme.dart';
import '../../../../theme/gaps.dart';
import 'banner_shimmer.dart';
import 'food_campaign_shimmer.dart';
import 'section_header.dart';

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
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: campaigns.length,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  itemBuilder: (context, index) {
                    final food = campaigns[index];
                    return Container(
                      width: 220,
                      margin: EdgeInsets.only(right: 16, bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                      child: Stack(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Food Image
                              Container(
                                height: 80,
                                width: 70,
                                margin: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
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
                                    horizontal: 6,
                                    vertical: 6,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 1,
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
                                            size: 12,
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
                                top: 16,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 2,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
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
                                  EdgeInsets.all(8),
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
                                size: 25,
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
        error: (error, stack) => Container(),
      ),
    );
  }
}
