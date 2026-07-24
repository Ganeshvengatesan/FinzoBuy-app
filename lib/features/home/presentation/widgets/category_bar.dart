import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
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

  // Softer Warm Charcoal Brown color token for active category background & text
  static const Color activeDarkGreyBrown = Color(0xFF4A413D);
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
                  // Animated Circular Icon Container with Dark Grey-Brown Active Fill & Pure White Icon
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOutCubic,
                    width: isSelected ? 58 : 54,
                    height: isSelected ? 58 : 54,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? activeDarkGreyBrown : inactiveCircleBg,
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: activeDarkGreyBrown.withValues(alpha: 0.28),
                                blurRadius: 10,
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
                    child: Center(
                      child: TweenAnimationBuilder<Color?>(
                        tween: ColorTween(
                          begin: isSelected ? inactiveIconColor : Colors.white,
                          end: isSelected ? Colors.white : inactiveIconColor,
                        ),
                        duration: const Duration(milliseconds: 250),
                        builder: (context, color, child) {
                          return SvgPicture.asset(
                            category.iconPath,
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              color ?? (isSelected ? Colors.white : inactiveIconColor),
                              BlendMode.srcIn,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Category Label with Smooth Color Transition
                  TweenAnimationBuilder<Color?>(
                    tween: ColorTween(
                      begin: isSelected ? inactiveTextColor : activeDarkGreyBrown,
                      end: isSelected ? activeDarkGreyBrown : inactiveTextColor,
                    ),
                    duration: const Duration(milliseconds: 250),
                    builder: (context, color, child) {
                      return Text(
                        category.name,
                        style: TextStyle(
                          fontFamily: 'AnekLatin',
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: color ?? (isSelected ? activeDarkGreyBrown : inactiveTextColor),
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
