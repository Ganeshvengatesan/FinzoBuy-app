import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class TechDealsSection extends StatelessWidget {
  final List<ProductModel> techProducts;

  const TechDealsSection({super.key, required this.techProducts});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.p16), // Restored full padding
      decoration: BoxDecoration(
        color: const Color(0xFFDCFFF6), // Mint green background
        borderRadius: BorderRadius.circular(24.0), // Restored rounded corners
        border: Border.all(
          color: Colors.white,
          width: 3.0, // Solid surrounding white border
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
          // Section Title
          const Text(
            'Top Deals on tech',
            style: TextStyle(
              fontFamily: 'AnekLatin',
              fontWeight: FontWeight.w700,
              fontSize: 20.0,
              height: 1.0,
              letterSpacing: 0.0,
              color: Colors.black,
            ),
          ),
          AppSizes.hGap16,
          // Horizontal Deals list
          SizedBox(
            height: 185, // Comfortable height for floating card layout
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: techProducts.length,
              separatorBuilder: (context, index) => AppSizes.wGap12,
              itemBuilder: (context, index) {
                final product = techProducts[index];
                return _buildTechCard(context, product);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechCard(
    BuildContext context,
    ProductModel product,
  ) {
    // Select local asset image path based on product ID
    final String imagePath = product.id == 'td_infinix'
        ? 'assets/images/tech_1.png'
        : product.id == 'td_jbl'
            ? 'assets/images/tech_2.png'
            : 'assets/images/tech_3.png';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Image Container (White Card Box for image only)
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: Colors.white,
              width: 2.0, // White border outline
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.0), // Rounded corners respecting border
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        // 2. Product name (Infinix, JBL Speaker, OPPO)
        SizedBox(
          width: 130,
          child: Text(
            product.title,
            style: const TextStyle(
              fontFamily: 'AnekLatin',
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
              height: 1.0,
              letterSpacing: 0.0,
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 4.0),
        // 3. Price Tag ("From ₹[Price]")
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontFamily: 'AnekLatin',
              fontWeight: FontWeight.w700,
              fontSize: 14.0,
              height: 1.0,
              letterSpacing: 0.0,
            ),
            children: [
              const TextSpan(
                text: 'From ',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: '₹${product.price.toStringAsFixed(0)}',
                style: const TextStyle(color: AppColors.lightPrimary), // Brand Indigo #4D43FE
              ),
            ],
          ),
        ),
      ],
    );
  }
}
