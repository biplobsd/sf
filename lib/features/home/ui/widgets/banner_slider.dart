import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../theme/gaps.dart';

class BannerItem {
  final String image;

  BannerItem({
    required this.image,
  });
}

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int _currentBannerIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  // Sample banner data
  final List<BannerItem> _banners = [
    BannerItem(
      image:
          'https://stackfood-admin.6amtech.com/storage/app/public/product/2021-08-21-611ff39525320.png',
    ),
    BannerItem(
      image:
          'https://stackfood-admin.6amtech.com/storage/app/public/product/2021-08-21-6120ccf4496ea.png',
    ),
    BannerItem(
      image:
          'https://stackfood-admin.6amtech.com/storage/app/public/product/2021-08-21-6120ce51dd6f2.png',
    ),
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
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
            items: _banners.map((banner) {
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
                      child: Image.network(
                        banner.image,
                        fit: BoxFit.cover,
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
              children: _banners.asMap().entries.map((entry) {
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
      ),
    );
  }
}
