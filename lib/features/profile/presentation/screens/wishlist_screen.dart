import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/route_names.dart';
import '../../../men_fashion/data/models/men_product_model.dart';
import '../../controllers/wishlist_controller.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistController = WishlistController();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // EXACT FIGMA SPEC: Top Header Container (Rectangle 1632: Height 148px, Background #F4F3FF, Radius 30px, Border 1px #FFFFFF)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F3FF),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
                border: Border.all(
                  color: Colors.white,
                  width: 1.0,
                ),
              ),
              child: Column(
                children: [
                  // Top Status Bar (09:30 PM & Icons)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '09:30 PM',
                        style: TextStyle(
                          fontFamily: 'AnekLatin',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.bluetooth, size: 16, color: Colors.black),
                          SizedBox(width: 6),
                          Icon(Icons.wifi, size: 16, color: Colors.black),
                          SizedBox(width: 6),
                          Icon(Icons.signal_cellular_alt, size: 16, color: Colors.black),
                          SizedBox(width: 6),
                          Icon(Icons.battery_full, size: 16, color: Colors.black),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Navigation Row: < Whistlist & Search Icon
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (context.canPop()) {
                            context.pop();
                          }
                        },
                        child: const SizedBox(
                          width: 24,
                          height: 24,
                          child: Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Whistlist',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          fontFamily: 'AnekLatin',
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(
                        width: 30,
                        height: 30,
                        child: Icon(Icons.search, size: 24, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Scrollable Dynamic Grid of Wishlist Items
            Expanded(
              child: ListenableBuilder(
                listenable: wishlistController,
                builder: (context, _) {
                  final items = wishlistController.items;

                  if (items.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border_rounded,
                            size: 72,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Your Wishlist is empty',
                            style: TextStyle(
                              fontFamily: 'AnekLatin',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF151515),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Explore items and save your favorites here!',
                            style: TextStyle(
                              fontFamily: 'AnekLatin',
                              fontSize: 14,
                              color: Color(0xFF767676),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () => context.push(RouteNames.menFashionPath),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.menPrimaryBlue,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Explore Products',
                              style: TextStyle(
                                fontFamily: 'AnekLatin',
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.65,
                    ),
                    itemBuilder: (context, index) {
                      final product = items[index];
                      return _buildWishlistCard(context, wishlistController, product, index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWishlistCard(
    BuildContext context,
    WishlistController wishlistController,
    MenProductModel product,
    int index,
  ) {
    // EXACT FIGMA SPEC: Group 1000011114 Card Container (Width 190.6px x Height 228.28px image container, bg #F8F8F8)
    return GestureDetector(
      onTap: () {
        context.push(
          RouteNames.menFashionDetailPath,
          extra: product,
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Image Container with Top-Right Red Heart Badge Button (17.23px x 17.23px icon)
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white,
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Product Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Image.asset(
                          product.imageAsset,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.image_not_supported_outlined,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Red Heart Wishlist Remove Button Overlay
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        wishlistController.removeItem(product.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.title} removed from Wishlist'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.favorite,
                            size: 17.23,
                            color: Color(0xFFFF2B2B), // Solid Red filled heart
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),

          // 2. Product Title (Figma Spec: Anek Latin 500 Medium, 14px, #221F1F)
          Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'AnekLatin',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF221F1F),
            ),
          ),

          const SizedBox(height: 4),

          // 3. Rating Row (★★★★☆ 453)
          Row(
            children: [
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    i < 4 ? Icons.star : Icons.star_border,
                    size: 12,
                    color: const Color(0xFFFFC107),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '${product.reviewCount}',
                style: const TextStyle(
                  fontFamily: 'AnekLatin',
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF767676),
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          // 4. Price Row: Strikethrough Original Price + Discount Offer Price (Figma Spec: #4D43FE)
          Row(
            children: [
              Text(
                '₹${product.originalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontFamily: 'AnekLatin',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF9E9E9E),
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '₹${product.discountPrice.toInt()}',
                style: const TextStyle(
                  fontFamily: 'AnekLatin',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.menPrimaryBlue, // Brand color #4D43FE
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
