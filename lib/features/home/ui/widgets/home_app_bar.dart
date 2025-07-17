import 'package:flutter/material.dart';

import '../../../../theme/gaps.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: false,
      snap: false,
      backgroundColor: const Color(0xFFFDFDFD),
      elevation: 0,
      expandedHeight: 120,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.home, color: Colors.grey[600], size: 20),
                      const SizedBox(width: 8),
                      Text(
                        "76A eighth avenue, New York, US",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Badge(
                    alignment: Alignment.topRight,
                    smallSize: 8,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.notifications_none, size: 26),
                  ),
                ],
              ),
              gap1,
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search food or restaurant here...",
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.2,
                    ),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    suffixIcon:
                        Icon(Icons.search, color: Colors.grey[400], size: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey[300]!,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey[500]!,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
