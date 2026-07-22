import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class CategoryItemData {
  final String id;
  final String label;
  final String imagePath;
  final IconData? fallbackIcon;

  const CategoryItemData({
    required this.id,
    required this.label,
    required this.imagePath,
    this.fallbackIcon,
  });
}

class MenCategoryBar extends StatelessWidget {
  final String selectedCategoryId;
  final ValueChanged<String> onCategorySelected;

  static const List<CategoryItemData> categories = [
    CategoryItemData(
      id: 'formal_wear',
      label: 'Formal Wear',
      imagePath: 'assets/images/men_shirt_dark_blue.png',
      fallbackIcon: Icons.checkroom,
    ),
    CategoryItemData(
      id: 'casual_wear',
      label: 'Casual Wear',
      imagePath: 'assets/images/recently_view_2.png',
      fallbackIcon: Icons.dry_cleaning,
    ),
    CategoryItemData(
      id: 'luggage',
      label: 'Luggage',
      imagePath: 'assets/images/banner_3.png',
      fallbackIcon: Icons.card_travel,
    ),
    CategoryItemData(
      id: 'watches',
      label: 'Watches',
      imagePath: 'assets/images/tech_1.png',
      fallbackIcon: Icons.watch,
    ),
    CategoryItemData(
      id: 'footwear',
      label: 'Footwear',
      imagePath: 'assets/images/banner_1.png',
      fallbackIcon: Icons.roller_skating,
    ),
  ];

  const MenCategoryBar({
    super.key,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 106,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          final item = categories[index];
          final isSelected = item.id == selectedCategoryId;

          return GestureDetector(
            onTap: () => onCategorySelected(item.id),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 74,
                  height: 74,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? AppColors.menActiveCategoryBg : Colors.grey.shade100,
                    border: Border.all(
                      color: isSelected ? AppColors.menPrimaryBlue : Colors.transparent,
                      width: 2.5,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.menPrimaryBlue.withValues(alpha: 0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            )
                          ]
                        : null,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      item.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.blue.shade50,
                        child: Icon(
                          item.fallbackIcon ?? Icons.category,
                          color: AppColors.menPrimaryBlue,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? AppColors.menPrimaryBlue : const Color(0xFF374151),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
