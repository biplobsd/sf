import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/home_data_refetch_provider.dart';
import 'widgets/banner_slider.dart';
import 'widgets/categories_section.dart';
import 'widgets/food_campaign_section.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/popular_food_nearby_section.dart';
import 'widgets/restaurants_layout.dart';
import 'widgets/section_header.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: ref.read(homeDataRefetchProviderProvider.notifier).now,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            HomeAppBar(),
            BannerSlider(),
            CategoriesSection(),
            PopularFoodNearbySection(),
            FoodCampaignSection(),
            SliverToBoxAdapter(
              child: SectionHeader(
                title: "Restaurants",
                onPressedViewAll: () {},
              ),
            ),
            RestaurantsLayout(
              scrollController: _scrollController,
            ),
          ],
        ),
      ),
    );
  }
}
