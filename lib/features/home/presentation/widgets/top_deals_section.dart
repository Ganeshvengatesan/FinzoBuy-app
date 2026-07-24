import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_names.dart';


class TopDealsSection extends StatelessWidget {
  final List<ProductModel> dealCategories;

  const TopDealsSection({super.key, required this.dealCategories});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.p16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9E6), // Pure soft cream yellow matching screenshot
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: Colors.white,
          width: 3.0, // Solid white border
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Deals',
                style: const TextStyle(
                  fontFamily: 'AnekLatin',
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                  height: 1.0,
                  letterSpacing: 0.0,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () => context.push(RouteNames.menFashionPath),
                child: Row(
                  children: [
                    Text(
                      'See All',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppSizes.wGap8,
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.lightPrimary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        size: 12.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSizes.hGap16,
          // 2x2 Grid of Category Cards
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dealCategories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSizes.p12,
              mainAxisSpacing: AppSizes.p12,
              childAspectRatio: 0.88,
            ),
            itemBuilder: (context, index) {
              final deal = dealCategories[index];
              return _buildCategoryGridCard(context, deal, isDarkMode, theme);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGridCard(
    BuildContext context,
    ProductModel deal,
    bool isDarkMode,
    ThemeData theme,
  ) {
    return GestureDetector(
      onTap: () => context.push(RouteNames.menFashionPath),
      behavior: HitTestBehavior.opaque,
      child: Container(
      decoration: BoxDecoration(
        color: isDarkMode ? theme.cardTheme.color : Colors.white,
        borderRadius: AppSizes.br12,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSizes.p8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 2x2 Mini Images Grid
          Expanded(
            child: ClipRRect(
              borderRadius: AppSizes.br8,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, idx) {
                  // Fallback in case list is smaller
                  final imageUrl = deal.images.length > idx
                      ? deal.images[idx]
                      : 'https://images.unsplash.com/photo-1525507119028-ed4c629a60a3';
                  return Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          // Category Label
          Text(
            deal.title,
            style: const TextStyle(
              fontFamily: 'AnekLatin',
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              height: 1.0,
              letterSpacing: 0.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}
}
