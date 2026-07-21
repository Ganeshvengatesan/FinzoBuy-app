import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16, vertical: AppSizes.p8),
      child: Column(
        children: [
          // Deliver Location + Icons Row
          Row(
            children: [
              // Location Icon (SVG)
              SvgPicture.asset(
                'assets/icons/location.svg',
                width: AppSizes.iconSm,
                height: AppSizes.iconSm,
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              AppSizes.wGap8,
              // Location Text Block
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deliver to',
                      style: TextStyle(
                        fontFamily: 'AnekLatin',
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        height: 1.0,
                        letterSpacing: 0.0,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Madurai-625006',
                      style: TextStyle(
                        fontFamily: 'AnekLatin',
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                        height: 1.08,
                        letterSpacing: 0.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              // Bell Button (with Notification Dot)
              Stack(
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/Bell.svg',
                      width: AppSizes.iconMd,
                      height: AppSizes.iconMd,
                      colorFilter: const ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  Positioned(
                    right: 12,
                    top: 12,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              // Menu Button (SVG)
              IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/Menu.svg',
                  width: AppSizes.iconMd,
                  height: AppSizes.iconMd,
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
          AppSizes.hGap8,
          // Search Field
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: const Color(0x221F1F1A), // Subtle grey border #221F1F1A
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11.0),
              child: TextField(
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.lightTextPrimary,
                  fontSize: 14.0,
                ),
                decoration: InputDecoration(
                  hintText: 'Search For Product',
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.unselectedIcon,
                    fontSize: 14.0,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      'assets/icons/ic_search.svg',
                      width: AppSizes.iconXs,
                      height: AppSizes.iconXs,
                      colorFilter: const ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      'assets/icons/mic.svg',
                      width: AppSizes.iconXs,
                      height: AppSizes.iconXs,
                      colorFilter: const ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
