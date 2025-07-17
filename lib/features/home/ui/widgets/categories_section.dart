import 'package:flutter/material.dart';

import '../../../../theme/app_theme.dart';
import '../../../../theme/gaps.dart';
import 'section_header.dart';

class CategoryItem {
  final String name;
  final String emoji;
  final Color backgroundColor;

  CategoryItem({
    required this.name,
    required this.emoji,
    required this.backgroundColor,
  });
}

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CategoryItem> categories = [
      CategoryItem(
          name: 'All', emoji: '🍽️', backgroundColor: Color(0xFFFFF3E0)),
      CategoryItem(
          name: 'Coffee', emoji: '☕', backgroundColor: Color(0xFFEFEBE9)),
      CategoryItem(
          name: 'Drink', emoji: '🥤', backgroundColor: Color(0xFFE8F5E8)),
      CategoryItem(
          name: 'Fast Food', emoji: '🍔', backgroundColor: Color(0xFFFFE8E8)),
      CategoryItem(
          name: 'Cake', emoji: '🍰', backgroundColor: Color(0xFFF3E5F5)),
      CategoryItem(
          name: 'Sushi', emoji: '🍣', backgroundColor: Color(0xFFE0F2F1)),
      CategoryItem(
          name: 'Pizza', emoji: '🍕', backgroundColor: Color(0xFFFFF8E1)),
      CategoryItem(
          name: 'Salad', emoji: '🥗', backgroundColor: Color(0xFFE8F5E8)),
    ];

    return SliverToBoxAdapter(
        child: Column(
      children: [
        SectionHeader(
          title: "Categories",
          onPressedViewAll: () {},
        ),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return SizedBox(
                width: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          category.emoji,
                          style: TextStyle(fontSize: 24),
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
    ));
  }
}
