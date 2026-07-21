import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/models/product_model.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class RecentlyViewedSection extends StatelessWidget {
  final List<ProductModel> products;

  const RecentlyViewedSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Header Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recently View',
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
                onTap: () {},
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
                        size: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AppSizes.hGap12,
        // Horizontal list of products
        SizedBox(
          height: 245, // Comfortable height preventing vertical scroll bounds issues
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16),
            itemCount: products.length,
            separatorBuilder: (context, index) => AppSizes.wGap16,
            itemBuilder: (context, index) {
              final product = products[index];
              return _buildProductCard(context, product, theme);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    ProductModel product,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Outer Card Container (Contains image and overlay grid/text only)
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: Colors.white,
              width: 2.0, // Solid white border outline
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: _buildCardContent(product),
          ),
        ),
        AppSizes.hGap8,
        // 2. Product Title (Placed BELOW the card)
        SizedBox(
          width: 150,
          child: Text(
            product.title,
            style: const TextStyle(
              fontFamily: 'AnekLatin',
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              height: 1.16,
              letterSpacing: 0.0,
              color: Colors.black,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        AppSizes.hGap4,
        // 3. Ratings (Stars & Review Count)
        Row(
          children: [
            Row(
              children: List.generate(
                5,
                (index) {
                  final isFilled = index < product.rating.floor();
                  return Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: SvgPicture.asset(
                      'assets/icons/ic_rating.svg',
                      width: 11.0,
                      height: 11.0,
                      colorFilter: ColorFilter.mode(
                        isFilled ? const Color(0xFFEBA928) : const Color(0xFFE8E8E8),
                        BlendMode.srcIn,
                      ),
                    ),
                  );
                },
              ),
            ),
            AppSizes.wGap4,
            Text(
              // Match exact mockup rating count text format
              product.id == 'rv_sony_camera'
                  ? '11.619'
                  : product.id == 'rv_redmi_watch'
                      ? '453'
                      : '2.016',
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 10.0,
                color: AppColors.unselectedIcon,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        AppSizes.hGap4,
        // 4. Prices
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            if (product.oldPrice != null) ...[
              Text(
                product.id == 'rv_sony_camera'
                    ? '₹479,99'
                    : product.id == 'rv_redmi_watch'
                        ? '₹59,99'
                        : '₹74,99',
                style: const TextStyle(
                  fontFamily: 'Roobert TRIAL',
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                  height: 1.0,
                  letterSpacing: 0.0,
                  color: Color(0xFFB3B3B3),
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Color(0xFFB3B3B3),
                  decorationThickness: 1.5,
                ),
              ),
              AppSizes.wGap4,
            ],
            Text(
              '₹${product.price.toStringAsFixed(0)}',
              style: const TextStyle(
                fontFamily: 'AnekLatin',
                fontWeight: FontWeight.w700,
                fontSize: 14.0,
                height: 1.0,
                letterSpacing: 0.0,
                color: AppColors.lightPrimary, // Brand color #4D43FE
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCardContent(ProductModel product) {
    if (product.id == 'rv_sony_camera') {
      return Column(
        children: [
          // Image
          Expanded(
            flex: 5,
            child: Container(
              color: const Color(0xFFF3F4F6),
              child: Image.asset(
                'assets/images/recently_view_1.png',
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
          ),
          // Specs Grid
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
              child: _buildCameraSpecsGrid(),
            ),
          ),
        ],
      );
    }

    if (product.id == 'rv_redmi_watch') {
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/recently_view_2.png',
            fit: BoxFit.cover,
          ),
          // "Fastest growing smartwatch maker" Overlay
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fastest growing',
                  style: TextStyle(
                    color: Colors.greenAccent[400],
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    shadows: const [
                      Shadow(
                        blurRadius: 4.0,
                        color: Colors.black54,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'smartwatch maker',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 4.0,
                        color: Colors.black54,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    if (product.id == 'rv_boat_rockerz') {
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/recently_view_3.png',
            fit: BoxFit.cover,
          ),
          // "BEAST™ Mode 40ms Low Latency For..." Overlay
          Positioned(
            bottom: 10,
            right: 10,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'BEAST™ Mode',
                  style: TextStyle(
                    color: Colors.cyanAccent[100],
                    fontSize: 8.0,
                    fontWeight: FontWeight.bold,
                    shadows: const [
                      Shadow(
                        blurRadius: 4.0,
                        color: Colors.black54,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),
                const Text(
                  '40ms Low Latency For...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 6.0,
                    shadows: [
                      Shadow(
                        blurRadius: 4.0,
                        color: Colors.black54,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      );
    }

    // Default Fallback
    return Image.network(
      product.images.first,
      fit: BoxFit.cover,
    );
  }

  Widget _buildCameraSpecsGrid() {
    final specs = [
      'Ultra-wide\n20mm',
      '21.0\nMega Pixels',
      'Maximum\nAperture F2.0',
      'Vari-angle\nLCD',
      'Face Priority\nAE / Eye AF',
      'Creative\nLook',
      'Built-in\nDirectional\n3-Capsule Mic',
      'Lightweight\n& Compact'
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: specs.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        childAspectRatio: 1.4,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(2.0),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 0.5),
          ),
          padding: const EdgeInsets.all(1.0),
          child: Center(
            child: Text(
              specs[index],
              style: const TextStyle(
                fontSize: 5.5,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }
}
