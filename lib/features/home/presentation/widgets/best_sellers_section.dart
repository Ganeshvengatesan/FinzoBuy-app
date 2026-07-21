import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/models/product_model.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class BestSellersSection extends StatelessWidget {
  final List<ProductModel> products;

  const BestSellersSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Header Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Best Sellers in Clothing\n& Accessories',
                  style: const TextStyle(
                    fontFamily: 'AnekLatin',
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                    height: 1.08,
                    letterSpacing: 0.0,
                    color: Colors.black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      'See All',
                      style: const TextStyle(
                        fontFamily: 'AnekLatin',
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                    AppSizes.wGap8,
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.lightPrimary, // Brand color #4D43FE
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
        // Horizontal Product List
        SizedBox(
          height: 235, // Balanced height containing floating labels below cards
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16),
            itemCount: products.length,
            separatorBuilder: (context, index) => AppSizes.wGap16,
            itemBuilder: (context, index) {
              final product = products[index];
              return _buildProductCard(context, product);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    ProductModel product,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Image Container (White Card Box for image only)
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: Colors.white,
              width: 2.0, // White border outline
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
            borderRadius: BorderRadius.circular(14.0), // Rounded corners respecting border
            child: Image.network(
              product.images.first,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        // 2. Product title
        SizedBox(
          width: 140,
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
        const SizedBox(height: 4.0),
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
            const SizedBox(width: 4),
            Text(
              '(${product.reviewCount})',
              style: const TextStyle(
                fontFamily: 'AnekLatin',
                fontSize: 10.0,
                color: AppColors.unselectedIcon,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        // 4. Prices
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            if (product.oldPrice != null) ...[
              Text(
                '₹${product.oldPrice!.toStringAsFixed(0)}',
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
              const SizedBox(width: 4),
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
}
