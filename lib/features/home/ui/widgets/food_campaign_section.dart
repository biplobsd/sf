import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';
import '../../../../theme/gaps.dart';
import 'section_header.dart';

class FoodCampaignItem {
  final String name;
  final String restaurant;
  final int discountPercentage;
  final double discountPrice;
  final String address;
  final String price;
  final double rating;
  final String emoji;

  FoodCampaignItem({
    required this.name,
    required this.restaurant,
    required this.address,
    required this.price,
    required this.discountPercentage,
    required this.discountPrice,
    required this.rating,
    required this.emoji,
  });
}

class FoodCampaignSection extends StatelessWidget {
  const FoodCampaignSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FoodCampaignItem> _foodCampaignItems = [
      FoodCampaignItem(
        name: 'Spicy Chicken Wings',
        restaurant: 'Wings Delight',
        address: '123 Flavor St, Food City',
        price: '10.99',
        discountPercentage: 20,
        discountPrice: 8.79,
        rating: 4.5,
        emoji: '🍗',
      ),
      FoodCampaignItem(
        name: 'Vegan Salad Bowl',
        restaurant: 'Green Eats',
        address: '456 Healthy Ave, Veggie Town',
        price: '9.50',
        discountPercentage: 15,
        discountPrice: 8.08,
        rating: 4.2,
        emoji: '🥗',
      ),
      FoodCampaignItem(
        name: 'Classic Margherita Pizza',
        restaurant: 'Pizza Paradise',
        address: '789 Cheesy Blvd, Pizzaville',
        price: '12.00',
        discountPercentage: 10,
        discountPrice: 10.80,
        rating: 4.8,
        emoji: '🍕',
      ),
    ];

    return SliverToBoxAdapter(
      child: Column(
        children: [
          SectionHeader(
            title: "Food Campaign",
            onPressedViewAll: () {},
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _foodCampaignItems.length,
              padding: EdgeInsets.symmetric(horizontal: 8),
              itemBuilder: (context, index) {
                final food = _foodCampaignItems[index];
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
                            child: Center(
                              child: Text(
                                food.emoji,
                                style: TextStyle(fontSize: 40),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        text: food.restaurant,
                                        style: AppTheme.bodySmall10.copyWith(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w600,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: ', ${food.address}',
                                            style:
                                                AppTheme.bodySmall10.copyWith(
                                              color: Colors.grey[500],
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    children: List.generate(5, (starIndex) {
                                      return Icon(
                                        Icons.star,
                                        color: starIndex < food.rating.round()
                                            ? Colors.green
                                            : Colors.grey[300],
                                        size: 12,
                                      );
                                    }),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '\$${food.price}',
                                        style: AppTheme.titleTiny12,
                                      ),
                                      gap1,
                                      Text(
                                        '\$${food.price}',
                                        style: AppTheme.titleTiny12.copyWith(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.grey,
                                          decorationColor: Colors.grey.shade800,
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
                            '${food.discountPercentage}% off',
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
      ),
    );
  }
}
