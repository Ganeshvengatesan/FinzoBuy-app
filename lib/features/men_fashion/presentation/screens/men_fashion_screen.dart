import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/route_names.dart';
import '../widgets/men_category_bar.dart';
import '../widgets/men_hero_banner.dart';
import '../widgets/men_product_card.dart';
import '../../data/models/men_product_model.dart';

class MenFashionScreen extends StatefulWidget {
  const MenFashionScreen({super.key});

  @override
  State<MenFashionScreen> createState() => _MenFashionScreenState();
}

class _MenFashionScreenState extends State<MenFashionScreen> {
  String _selectedCategory = 'formal_wear';

  // Formal Shirts mock data
  final List<MenProductModel> _formalShirts = const [
    MenProductModel(
      id: 'shirt_1',
      title: 'Regular Fit Shirt',
      subtitle: 'Regular Fit Shirt | Cotton...',
      imageAsset: 'assets/images/men_shirt_dark_blue.png',
      originalPrice: 59.99,
      discountPrice: 5535,
      rating: 5.0,
      reviewCount: 453,
      isFavorite: false,
      colorVariants: [
        MenColorVariant(
          colorName: 'Dark Green',
          imageAsset: 'assets/images/men_shirt_dark_green.png',
          price: 399,
          hexCode: '#1C3F34',
        ),
        MenColorVariant(
          colorName: 'Cream',
          imageAsset: 'assets/images/men_banner.png',
          price: 399,
          hexCode: '#FDF8E2',
        ),
        MenColorVariant(
          colorName: 'Light Blue',
          imageAsset: 'assets/images/men_shirt_dark_blue.png',
          price: 599,
          hexCode: '#87CEEB',
        ),
        MenColorVariant(
          colorName: 'Pink',
          imageAsset: 'assets/images/men_shirt_pink.png',
          price: 399,
          hexCode: '#E87EA1',
        ),
      ],
    ),
    MenProductModel(
      id: 'shirt_2',
      title: 'Regular Fit Shirt',
      subtitle: 'Regular Fit Shirt | Cotton...',
      imageAsset: 'assets/images/recently_view_3.png',
      originalPrice: 59.99,
      discountPrice: 5535,
      rating: 5.0,
      reviewCount: 453,
      isFavorite: true,
      colorVariants: [
        MenColorVariant(
          colorName: 'Cream',
          imageAsset: 'assets/images/men_banner.png',
          price: 399,
          hexCode: '#FDF8E2',
        ),
        MenColorVariant(
          colorName: 'Dark Green',
          imageAsset: 'assets/images/men_shirt_dark_green.png',
          price: 399,
          hexCode: '#1C3F34',
        ),
      ],
    ),
    MenProductModel(
      id: 'shirt_3',
      title: 'Formal Cotton Shirt',
      subtitle: 'Regular Fit Shirt | Cotton...',
      imageAsset: 'assets/images/recently_view_1.png',
      originalPrice: 59.99,
      discountPrice: 5535,
      rating: 5.0,
      reviewCount: 453,
      isFavorite: false,
      colorVariants: [
        MenColorVariant(
          colorName: 'Light Blue',
          imageAsset: 'assets/images/men_shirt_dark_blue.png',
          price: 599,
          hexCode: '#87CEEB',
        ),
      ],
    ),
    MenProductModel(
      id: 'shirt_4',
      title: 'Slim Fit Shirt',
      subtitle: 'Regular Fit Shirt | Cotton...',
      imageAsset: 'assets/images/recently_view_2.png',
      originalPrice: 59.99,
      discountPrice: 5535,
      rating: 5.0,
      reviewCount: 453,
      isFavorite: false,
      colorVariants: [
        MenColorVariant(
          colorName: 'Dark Green',
          imageAsset: 'assets/images/men_shirt_dark_green.png',
          price: 399,
          hexCode: '#1C3F34',
        ),
      ],
    ),
  ];

  // Pants Shirts Product Grid Data
  final List<MenProductModel> _pantsShirts = const [
    MenProductModel(
      id: 'pants_1',
      title: 'Style Straight Leg Pants',
      subtitle: 'Style Straight Leg Pants..',
      imageAsset: 'assets/images/men_pants_grey.png',
      originalPrice: 59.99,
      discountPrice: 5535,
      rating: 5.0,
      reviewCount: 453,
      isFavorite: false,
    ),
    MenProductModel(
      id: 'pants_2',
      title: 'Style Straight Leg Pants',
      subtitle: 'Style Straight Leg Pants..',
      imageAsset: 'assets/images/recently_view_2.png',
      originalPrice: 59.99,
      discountPrice: 5535,
      rating: 5.0,
      reviewCount: 453,
      isFavorite: false,
    ),
    MenProductModel(
      id: 'pants_3',
      title: 'Style Straight Leg Pants',
      subtitle: 'Style Straight Leg Pants..',
      imageAsset: 'assets/images/recently_view_1.png',
      originalPrice: 59.99,
      discountPrice: 5535,
      rating: 5.0,
      reviewCount: 453,
      isFavorite: false,
    ),
    MenProductModel(
      id: 'pants_4',
      title: 'Style Straight Leg Pants',
      subtitle: 'Style Straight Leg Pants..',
      imageAsset: 'assets/images/recently_view_3.png',
      originalPrice: 59.99,
      discountPrice: 5535,
      rating: 5.0,
      reviewCount: 453,
      isFavorite: false,
    ),
  ];

  // Images for "New Shirts" row (129.59 x 193.16px)
  final List<String> _newShirtsImages = const [
    'assets/images/recently_view_3.png',
    'assets/images/recently_view_2.png',
    'assets/images/men_shirt_dark_blue.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SECTION 1: Header Box (#F4F3FF background, rounded bottom corners)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: const BoxDecoration(
                  color: AppColors.menHeaderBg,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        }
                      },
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Men Fashion',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        fontFamily: 'AnekLatin',
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        size: 26,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // SECTION 2: Category Bar (Formal Wear, Casual Wear, Luggage, Watches, Footwear)
              MenCategoryBar(
                selectedCategoryId: _selectedCategory,
                onCategorySelected: (catId) {
                  setState(() {
                    _selectedCategory = catId;
                  });
                },
              ),

              const SizedBox(height: 12),

              // SECTION 3: Hero Banner 1 (Top Hero Banner - Figma Image 2 exact section position)
              MenHeroBanner(
                onShopNow: () {
                  context.push(RouteNames.menFashionDetailPath);
                },
              ),

              const SizedBox(height: 16),

              // SECTION 4: Formal Shirts Section (#FFF6DB background, 2.5px white border, 30px radius)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.menSectionBg,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.white,
                    width: 2.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Section Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Formal Shirts',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            fontFamily: 'AnekLatin',
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(20),
                          child: Row(
                            children: [
                              const Text(
                                'See All',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.menPrimaryBlue,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // 2-Column Product Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.67,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                      ),
                      itemCount: _formalShirts.length,
                      itemBuilder: (context, index) {
                        final product = _formalShirts[index];
                        return MenProductCard(
                          product: product,
                          onTap: () {
                            context.push(
                              RouteNames.menFashionDetailPath,
                              extra: product,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // SECTION 5: "New Shirts" Section (129.59px x 193.16px portrait cards)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'New Shirts',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        fontFamily: 'AnekLatin',
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(20),
                      child: Row(
                        children: [
                          const Text(
                            'See All',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.menPrimaryBlue,
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Horizontal list of 3 portrait photo cards (129.59 x 193.16px)
              SizedBox(
                height: 194,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _newShirtsImages.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 6.11),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 129.59,
                      height: 193.16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.78),
                        color: Colors.grey.shade100,
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          _newShirtsImages[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: Colors.grey.shade200,
                            child: const Icon(Icons.person, color: Colors.grey),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // SECTION 6: Hero Banner 2 (Middle Hero Banner - Figma Image 2 exact section position)
              MenHeroBanner(
                onShopNow: () {
                  context.push(RouteNames.menFashionDetailPath);
                },
              ),

              const SizedBox(height: 24),

              // SECTION 7: "Pants Shirts" Section (#FFF6DB background, 2x2 grid of trousers)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.menSectionBg,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.white,
                    width: 2.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Section Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Pants Shirts',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            fontFamily: 'AnekLatin',
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(20),
                          child: Row(
                            children: [
                              const Text(
                                'See All',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.menPrimaryBlue,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // 2-Column Product Grid for Pants Shirts
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.67,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                      ),
                      itemCount: _pantsShirts.length,
                      itemBuilder: (context, index) {
                        final product = _pantsShirts[index];
                        return MenProductCard(
                          product: product,
                          onTap: () {
                            context.push(
                              RouteNames.menFashionDetailPath,
                              extra: product,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
