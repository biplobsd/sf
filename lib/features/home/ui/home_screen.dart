import 'package:flutter/material.dart';

import 'widgets/banner_slider.dart';
import 'widgets/categories_section.dart';
import 'widgets/food_campaign_section.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/popular_food_nearby_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDFDFD),
      body: CustomScrollView(
        slivers: [
          HomeAppBar(),
          BannerSlider(),
          CategoriesSection(),
          PopularFoodNearbySection(),
          FoodCampaignSection()
        ],
      ),
    );
  }
}
