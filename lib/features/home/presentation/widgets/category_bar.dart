import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/route_names.dart';
import '../../data/models/category_model.dart';

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

  // Light theme primary blue color token for active category background & text
  static const Color activePrimaryBlue = AppColors.menPrimaryBlue;
  static const Color inactiveCircleBg = Color(0xFFF3F3F5);
  static const Color inactiveIconColor = Color(0xFF555555);
  static const Color inactiveTextColor = Color(0xFF757575);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: SizedBox(
        height: 98,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: categories.map((category) {
            final isSelected = category.id == selectedCategoryId;

            return GestureDetector(
              onTap: () {
                onCategorySelected(category.id);
                context.push(RouteNames.menFashionPath);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Circular Icon Container with Soft Light Blue Fill, Thin Grey Border & Crisp Primary Blue Icon
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOutCubic,
                    width: isSelected ? 58 : 54,
                    height: isSelected ? 58 : 54,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? activePrimaryBlue.withValues(alpha: 0.12) : inactiveCircleBg,
                      border: Border.all(
                        color: isSelected ? const Color(0xFFD8D8E5) : const Color(0xFFE5E5E5),
                        width: 1.0,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: activePrimaryBlue.withValues(alpha: 0.08),
                                blurRadius: 6,
                                spreadRadius: 0,
                                offset: const Offset(0, 2),
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
                    child: Center(
                      child: SvgPicture.asset(
                        category.iconPath,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          isSelected ? activePrimaryBlue : inactiveIconColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Category Label with Smooth Color Transition
                  TweenAnimationBuilder<Color?>(
                    tween: ColorTween(
                      begin: isSelected ? inactiveTextColor : activePrimaryBlue,
                      end: isSelected ? activePrimaryBlue : inactiveTextColor,
                    ),
                    duration: const Duration(milliseconds: 250),
                    builder: (context, color, child) {
                      return Text(
                        category.name,
                        style: TextStyle(
                          fontFamily: 'AnekLatin',
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: color ?? (isSelected ? activePrimaryBlue : inactiveTextColor),
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
