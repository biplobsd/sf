import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme.dart';

class StyledDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final Function(String) onChanged;

  const StyledDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: value,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: AppTheme.titleTiny12.copyWith(
                color: AppColors.blueberry100,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            onChanged(newValue);
          }
        },
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.blueberry100,
        ),
        isExpanded: false,
        // dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(12),
        menuMaxHeight: 300,
        itemHeight: 48,
        style: AppTheme.bodySmall12.copyWith(color: Colors.black),
      ),
    );
  }
}
