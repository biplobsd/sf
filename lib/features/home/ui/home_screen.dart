import 'package:flutter/material.dart';

import 'widgets/banner_slider.dart';
import 'widgets/categories_section.dart';
import 'widgets/food_campaign_section.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/popular_food_nearby_section.dart';
import 'widgets/restaurants_layout.dart';
import 'widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDFDFD),
      body: CustomScrollView(
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
    );
  }
}
