import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_colors.dart';

class FashionBottomNavBarItem {
  final String iconPath;
  final String label;

  const FashionBottomNavBarItem({
    required this.iconPath,
    required this.label,
  });
}

class FashionBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const FashionBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<FashionBottomNavBarItem> _items = [
    FashionBottomNavBarItem(
      iconPath: 'assets/icons/ic_home.svg',
      label: 'Home',
    ),
    FashionBottomNavBarItem(
      iconPath: 'assets/icons/ic_category.svg',
      label: 'Category',
    ),
    FashionBottomNavBarItem(
      iconPath: 'assets/icons/ic_cart.svg',
      label: 'Cart',
    ),
    FashionBottomNavBarItem(
      iconPath: 'assets/icons/ic_profile.svg',
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final activeColor = isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary;
    final inactiveColor = isDarkMode ? AppColors.darkTextMuted : const Color(0xFF6E6E6E);
    final navBgColor = isDarkMode ? theme.colorScheme.surface : Colors.white;
    final dividerColor = isDarkMode ? AppColors.darkDivider : AppColors.lightDivider;

    return Container(
      decoration: BoxDecoration(
        color: navBgColor,
        border: Border(
          top: BorderSide(
            color: dividerColor,
            width: 1.0,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 56.0,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final tabWidth = constraints.maxWidth / _items.length;

              return Stack(
                children: [
                  // Animated sliding background gradient & top indicator bar
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.fastOutSlowIn,
                    left: currentIndex * tabWidth,
                    top: 0,
                    width: tabWidth,
                    height: 56.0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            activeColor.withValues(alpha: 0.18),
                            activeColor.withValues(alpha: 0.0),
                          ],
                        ),
                        border: Border(
                          top: BorderSide(
                            color: activeColor,
                            width: 2.8,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Row of tab buttons
                  Row(
                    children: List.generate(_items.length, (index) {
                      final isSelected = currentIndex == index;
                      final item = _items[index];

                      return Expanded(
                        child: InkWell(
                          onTap: () => onTap(index),
                          highlightColor: Colors.transparent,
                          splashColor: activeColor.withValues(alpha: 0.08),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedScale(
                                  duration: const Duration(milliseconds: 200),
                                  scale: isSelected ? 1.08 : 1.0,
                                  child: SvgPicture.asset(
                                    item.iconPath,
                                    width: 20,
                                    height: 20,
                                    colorFilter: ColorFilter.mode(
                                      isSelected ? activeColor : inactiveColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 200),
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                    color: isSelected ? activeColor : inactiveColor,
                                    letterSpacing: -0.1,
                                    fontFamily: theme.textTheme.bodyMedium?.fontFamily,
                                  ),
                                  child: Text(
                                    item.label,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
