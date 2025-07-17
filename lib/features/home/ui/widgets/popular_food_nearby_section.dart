import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';
import '../../../../theme/gaps.dart';
import 'section_header.dart';

class FoodItem {
  final String name;
  final String restaurant;
  final String price;
  final double rating;
  final String emoji;

  FoodItem({
    required this.name,
    required this.restaurant,
    required this.price,
    required this.rating,
    required this.emoji,
  });
}

class PopularFoodNearbySection extends StatelessWidget {
  const PopularFoodNearbySection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FoodItem> foodItems = [
      FoodItem(
        name: 'Fried Noodles',
        restaurant: 'Warung Herbal',
        price: '7.56',
        rating: 4.9,
        emoji: '🍜',
      ),
      FoodItem(
        name: 'Fried Noodles',
        restaurant: 'Warung Herbal',
        price: '7.56',
        rating: 4.9,
        emoji: '🍜',
      ),
      FoodItem(
        name: 'Fried Rice',
        restaurant: 'Asian Kitchen',
        price: '8.99',
        rating: 4.7,
        emoji: '🍚',
      ),
      FoodItem(
        name: 'Chicken Curry',
        restaurant: 'Spice House',
        price: '12.50',
        rating: 4.8,
        emoji: '🍛',
      ),
      FoodItem(
        name: 'Beef Burger',
        restaurant: 'Burger Palace',
        price: '9.99',
        rating: 4.6,
        emoji: '🍔',
      ),
    ];

    return SliverToBoxAdapter(
      child: Column(
        children: [
          SectionHeader(
            title: "Popular Food Nearby",
            onPressedViewAll: () {},
          ),
          SizedBox(
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: foodItems.length,
              padding: EdgeInsets.symmetric(horizontal: 8),
              itemBuilder: (context, index) {
                final food = foodItems[index];
                return Container(
                  width: 160,
                  margin: EdgeInsets.only(right: 16, bottom: 10),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Food Image
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.orange.withValues(
                                    alpha: 0.2,
                                  ),
                                  Colors.orange.withValues(
                                    alpha: 0.1,
                                  ),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                food.emoji,
                                style: TextStyle(fontSize: 40),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Food Details
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              food.name,
                              style: AppTheme.titleTiny12,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            gap0_1,
                            Text(
                              food.restaurant,
                              style: AppTheme.bodySmall10.copyWith(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            gap0_2,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${food.price}',
                                  style: AppTheme.titleTiny12,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.green,
                                      size: 12,
                                    ),
                                    gap0_1,
                                    Text(
                                      food.rating.toString(),
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
      ),
    );
  }
}
