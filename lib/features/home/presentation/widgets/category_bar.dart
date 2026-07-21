import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/models/category_model.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class CategoryBar extends StatelessWidget {
  final List<CategoryModel> categories;
  final String selectedCategoryId;
  final ValueChanged<String> onCategorySelected;

  const CategoryBar({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: SizedBox(
        height: 96,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: categories.map((category) {
            final isSelected = category.id == selectedCategoryId;
            final activeColor = AppColors.lightPrimary;
            final unselectedColor = AppColors.unselectedIcon;

            return GestureDetector(
              onTap: () => onCategorySelected(category.id),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Circular Double-Ring / Shaded Icon Container
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: isSelected ? 60 : 56,
                    height: isSelected ? 60 : 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: activeColor.withValues(alpha: 0.15),
                                blurRadius: 8,
                                spreadRadius: 1,
                                offset: const Offset(0, 4),
                              )
                            ]
                          : [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.02),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ],
                    ),
                    padding: isSelected ? const EdgeInsets.all(2.0) : EdgeInsets.zero,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? const Color(0xFFF0EFFF) // Premium soft lavender
                            : Colors.white, // Inactive background as white
                      ),
                      child: Center(
                        child: TweenAnimationBuilder<Color?>(
                          tween: ColorTween(
                            begin: isSelected ? unselectedColor : activeColor,
                            end: isSelected ? activeColor : unselectedColor,
                          ),
                          duration: const Duration(milliseconds: 250),
                          builder: (context, color, child) {
                            return SvgPicture.asset(
                              category.iconPath,
                              width: 26,
                              height: 26,
                              colorFilter: ColorFilter.mode(
                                color ?? unselectedColor,
                                BlendMode.srcIn,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  AppSizes.hGap4,
                  // Category Label with Smooth Color Transition
                  TweenAnimationBuilder<Color?>(
                    tween: ColorTween(
                      begin: isSelected ? unselectedColor : activeColor,
                      end: isSelected ? activeColor : unselectedColor,
                    ),
                    duration: const Duration(milliseconds: 250),
                    builder: (context, color, child) {
                      return Text(
                        category.name,
                        style: TextStyle(
                          fontFamily: 'AnekLatin',
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: color ?? unselectedColor,
                          fontSize: 12.0,
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
