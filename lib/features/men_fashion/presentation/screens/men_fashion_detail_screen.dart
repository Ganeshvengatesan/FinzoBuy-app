import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/men_product_model.dart';

class MenFashionDetailScreen extends StatefulWidget {
  final MenProductModel? product;

  const MenFashionDetailScreen({
    super.key,
    this.product,
  });

  @override
  State<MenFashionDetailScreen> createState() => _MenFashionDetailScreenState();
}

class _MenFashionDetailScreenState extends State<MenFashionDetailScreen> {
  late int _selectedColorIndex;
  String _selectedSize = '38';

  // 4 Color Swatches matching Figma specs
  static final List<MenColorVariant> defaultVariants = [
    const MenColorVariant(
      colorName: 'Dark Green',
      imageAsset: 'assets/images/men_shirt_dark_green.png',
      price: 399,
      hexCode: '#1C3F34',
    ),
    const MenColorVariant(
      colorName: 'Cream',
      imageAsset: 'assets/images/men_banner.png',
      price: 399,
      hexCode: '#FDF8E2',
    ),
    const MenColorVariant(
      colorName: 'Light Blue',
      imageAsset: 'assets/images/men_shirt_dark_blue.png',
      price: 599,
      hexCode: '#87CEEB',
    ),
    const MenColorVariant(
      colorName: 'Pink',
      imageAsset: 'assets/images/men_shirt_pink.png',
      price: 399,
      hexCode: '#E87EA1',
    ),
  ];

  static const List<String> sizes = ['38', '39', '40', '42', '44', '46'];

  // Style Specs key-value list from Figma Dev Mode specs
  static const List<Map<String, String>> styleSpecs = [
    {'label': 'Colour', 'value': 'Olive Green'},
    {'label': 'Fitting type', 'value': 'Regular Fit'},
    {'label': 'Occasion description', 'value': 'Date Night'},
    {'label': 'Style Name', 'value': 'Western'},
    {'label': 'Neck Style', 'value': 'V-Neck'},
    {'label': 'Sleeve Type', 'value': 'Long Sleeve'},
    {'label': 'Shirt Form Type', 'value': 'Polo Shirt'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedColorIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final variants = (widget.product != null && widget.product!.colorVariants.isNotEmpty)
        ? widget.product!.colorVariants
        : defaultVariants;

    final selectedVariant = variants[_selectedColorIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // EXACT FIGMA SPEC: Top Title Header Bar (Group 1000011089: Width 400px, Height 30px, Left 19px)
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 19),
              color: Colors.white,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const SizedBox(
                      width: 24,
                      height: 24,
                      child: Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Men Fashion',
                    style: TextStyle(
                      fontSize: 18,
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
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // EXACT FIGMA SPEC: Main Hero Product Image Container (Rectangle 3463296: 401px x 570px, Radius 17.46px, Border 0.92px #FFFFFF)
                    Container(
                      width: double.infinity,
                      height: 570,
                      margin: const EdgeInsets.symmetric(horizontal: 19, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17.46),
                        color: Colors.grey.shade100,
                        border: Border.all(
                          color: Colors.white,
                          width: 0.92,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.54),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Image.asset(
                            selectedVariant.imageAsset,
                            key: ValueKey(selectedVariant.imageAsset),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: Icon(Icons.person, size: 96, color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // EXACT FIGMA SPEC: Color Selector Outer Section Container (Frame 1261154814: Width 401px, Height 169px, Gap 16px, Left 18px)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Frame 1261154813: "Select Color : Dark Green" (Height 20px, Gap 6px)
                          SizedBox(
                            height: 20,
                            child: Row(
                              children: [
                                const Text(
                                  'Select Color : ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                    fontFamily: 'AnekLatin',
                                  ),
                                ),
                                Text(
                                  selectedVariant.colorName,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF2E3A4B),
                                    fontFamily: 'AnekLatin',
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // EXACT FIGMA SPEC: Color Swatches Row (Rectangle 3463302: 84px x 96px, Radius 11px)
                          SizedBox(
                            height: 130,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: variants.length,
                              separatorBuilder: (_, __) => const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                final variant = variants[index];
                                final isSelected = index == _selectedColorIndex;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedColorIndex = index;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: 84,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(11),
                                      border: Border.all(
                                        color: isSelected ? AppColors.menPrimaryBlue : Colors.grey.shade300,
                                        width: isSelected ? 2.0 : 1.0,
                                      ),
                                      boxShadow: isSelected
                                          ? [
                                              BoxShadow(
                                                color: AppColors.menPrimaryBlue.withValues(alpha: 0.25),
                                                blurRadius: 8,
                                                offset: const Offset(0, 3),
                                              )
                                            ]
                                          : [
                                              BoxShadow(
                                                color: Colors.black.withValues(alpha: 0.04),
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              )
                                            ],
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 84,
                                          height: 96,
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                            child: Image.asset(
                                              variant.imageAsset,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) => Container(
                                                color: Colors.grey.shade100,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4),
                                          child: Text(
                                            '₹${variant.price.toStringAsFixed(0)}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                                              color: isSelected ? AppColors.menPrimaryBlue : Colors.black87,
                                              fontFamily: 'AnekLatin',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // EXACT FIGMA SPEC: Frame 1261154835 (Width 371px, Gap 9px, Left 20px)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Select Size',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              fontFamily: 'AnekLatin',
                            ),
                          ),
                          const SizedBox(height: 9),

                          // EXACT FIGMA SPEC: Frame 1261154810 & Group 1000011138 (52px x 52px, Border 1px #DBDBDB, Typography Anek Latin 18px Medium)
                          SizedBox(
                            height: 52,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: sizes.length,
                              separatorBuilder: (_, __) => const SizedBox(width: 7),
                              itemBuilder: (context, index) {
                                final size = sizes[index];
                                final isSelected = size == _selectedSize;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedSize = size;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: 52,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected ? AppColors.menPrimaryBlue : Colors.white,
                                      border: Border.all(
                                        color: isSelected ? AppColors.menPrimaryBlue : const Color(0xFFDBDBDB),
                                        width: 1.0,
                                      ),
                                      boxShadow: isSelected
                                          ? [
                                              BoxShadow(
                                                color: AppColors.menPrimaryBlue.withValues(alpha: 0.3),
                                                blurRadius: 6,
                                                offset: const Offset(0, 3),
                                              )
                                            ]
                                          : null,
                                    ),
                                    child: Center(
                                      child: Text(
                                        size,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: isSelected ? Colors.white : const Color(0xFF000000),
                                          fontFamily: 'AnekLatin',
                                          height: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 9),

                          // EXACT FIGMA SPEC: Product Description Title (Anek Latin, Weight 400, Size 18px, Line Height 150%, #000000)
                          const Text(
                            "Pinkmint Men's Solid Shirt | Soft Cotton Blend | Casual Shirt | Plain | Full Sleeve - Regular Fit (Combo | Available in Plus Size)",
                            style: TextStyle(
                              fontFamily: 'AnekLatin',
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF000000),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // EXACT FIGMA DEV MODE SPEC: Group 1000011152 (Width 401px, Height 72px) & Group 1000011150 (Width 121px, Height 57px)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 19.0),
                      child: SizedBox(
                        height: 72,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFF2B2B),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    'Hot Deal',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 2),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      '₹${selectedVariant.price.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                        fontFamily: 'AnekLatin',
                                        fontSize: 34,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.menPrimaryBlue,
                                        height: 1.0,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Text(
                                      '-80%',
                                      style: TextStyle(
                                        fontFamily: 'AnekLatin',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFFF2B2B),
                                        height: 1.0,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 2),

                                const Text(
                                  '₹1,999',
                                  style: TextStyle(
                                    fontFamily: 'AnekLatin',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.lineThrough,
                                    color: Color(0xFF000000),
                                    height: 1.0,
                                  ),
                                ),
                              ],
                            ),

                            const Spacer(),

                            SizedBox(
                              width: 88,
                              height: 40,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: List.generate(
                                      5,
                                      (index) => const Icon(
                                        Icons.star_rounded,
                                        size: 14.67,
                                        color: Color(0xFFEBA928),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    '(100 Review)',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Delivery Details Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 19.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Delivery Details',
                            style: TextStyle(
                              fontFamily: 'AnekLatin',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF000000),
                              height: 1.0,
                            ),
                          ),
                          const SizedBox(height: 13),

                          // Home Address Card
                          Container(
                            height: 51,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8E7FF),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 34,
                                  height: 34,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.home_outlined,
                                      color: AppColors.menPrimaryBlue,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Expanded(
                                  child: Text(
                                    'Home  Polt 4 White Avenue 1st Street...',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'AnekLatin',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 7),
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.menPrimaryBlue,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Fulfilled By Card
                          Container(
                            height: 67,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.menSectionBg,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.storefront_outlined,
                                    color: AppColors.menPrimaryBlue,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'FulFilled By VKfashion',
                                      style: TextStyle(
                                        fontFamily: 'AnekLatin',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF151515),
                                        height: 1.0,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Text(
                                          '4.3 ★ ',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Text(
                                          '4 Years with finzopay',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // "About this item" Card
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 19),
                      height: 176,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.menSectionBg,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'About this item',
                                style: TextStyle(
                                  fontFamily: 'AnekLatin',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF000000),
                                  height: 1.0,
                                ),
                              ),
                              Container(
                                width: 26,
                                height: 26,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.menPrimaryBlue,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: Icon(Icons.check_circle, size: 16, color: Colors.green),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Cotton Shirts for Men|| Style:- Solid Shirts for Men',
                                  style: TextStyle(
                                    fontFamily: 'AnekLatin',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF000000),
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: Icon(Icons.check_circle, size: 16, color: Colors.green),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Truly comfortable and easy to wear in every season it is insulating in winter and breathable in summer.',
                                  style: TextStyle(
                                    fontFamily: 'AnekLatin',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF000000),
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Style Specs Table Section
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 19),
                      height: 307,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Style',
                                style: TextStyle(
                                  fontFamily: 'AnekLatin',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF000000),
                                  height: 1.0,
                                ),
                              ),
                              Container(
                                width: 26,
                                height: 26,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.menPrimaryBlue,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          Expanded(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 142,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: styleSpecs.map((spec) {
                                      return Text(
                                        spec['label']!,
                                        style: const TextStyle(
                                          fontFamily: 'AnekLatin',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF151515),
                                          height: 1.44,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),

                                const Spacer(),

                                SizedBox(
                                  width: 120,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: styleSpecs.map((spec) {
                                      return Text(
                                        spec['value']!,
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                          fontFamily: 'AnekLatin',
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Feature Showcase Banner 1
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 19),
                      height: 164,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade100,
                        border: Border.all(color: Colors.white, width: 2.0),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/men_shirt_dark_green.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Feature Showcase Banner 2
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 19),
                      height: 163,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade100,
                        border: Border.all(color: Colors.white, width: 2.0),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/men_shirt_dark_blue.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Feature Showcase Banner 3
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 19),
                      height: 164,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade100,
                        border: Border.all(color: Colors.white, width: 2.0),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/men_banner.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Ratings & Reviews Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 19.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                width: 163,
                                height: 20,
                                child: Text(
                                  'Ratings & Reviews',
                                  style: TextStyle(
                                    fontFamily: 'AnekLatin',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF000000),
                                    height: 1.0,
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 86,
                                height: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'See All',
                                      style: TextStyle(
                                        fontFamily: 'AnekLatin',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.menPrimaryBlue,
                                      ),
                                      child: const Icon(
                                        Icons.arrow_forward,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          SizedBox(
                            width: 186,
                            height: 37,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: List.generate(
                                        5,
                                        (index) => const Icon(
                                          Icons.star_rounded,
                                          size: 14.67,
                                          color: Color(0xFFEBA928),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Text(
                                      '(100 Review)',
                                      style: TextStyle(
                                        fontFamily: 'AnekLatin',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF000000),
                                        height: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'based on ratings by Verified Buyers ✔',
                                  style: TextStyle(
                                    fontFamily: 'AnekLatin',
                                    fontSize: 9.5,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Customer Review Cards
                          SizedBox(
                            height: 194,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 2,
                              separatorBuilder: (_, __) => const SizedBox(width: 14),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 247,
                                  height: 194,
                                  padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 14),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: Colors.grey.shade200),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.04),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Frame 1261154825: Rating badge + title (Gap 4px, Height 20px, Top 14px, Left 13px)
                                      Row(
                                        children: [
                                          // Frame 1261154824: Blue Pill Badge (20px x 20px, Radius 5px, Background #4D43FE)
                                          Container(
                                            width: 20,
                                            height: 20,
                                            padding: const EdgeInsets.only(top: 1, right: 5, bottom: 3, left: 6),
                                            decoration: BoxDecoration(
                                              color: AppColors.menPrimaryBlue,
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                '4',
                                                style: TextStyle(
                                                  fontFamily: 'AnekLatin',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                  height: 1.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          // Star 7: Gold Star icon (14.67px x 14.67px, Color #EBA928)
                                          const Icon(
                                            Icons.star_rounded,
                                            size: 14.67,
                                            color: Color(0xFFEBA928),
                                          ),
                                          const SizedBox(width: 4),
                                          // Perfect Product title: Anek Latin 16px 500 Medium #000000
                                          const Text(
                                            'Perfect Product',
                                            style: TextStyle(
                                              fontFamily: 'AnekLatin',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF000000),
                                              height: 1.0,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 10),

                                      // Rectangle 3463311 (227px x 60px, Radius 10px, Border 1px #FFFFFF, Background #F3F2FF)
                                      Container(
                                        width: 227,
                                        height: 60,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF3F2FF),
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: const Text(
                                          'Nice fabric same colour very nice everything is perfect',
                                          style: TextStyle(
                                            fontFamily: 'AnekLatin',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF151515),
                                            height: 1.44,
                                          ),
                                        ),
                                      ),

                                      const Spacer(),

                                      // "1 year Ago" (Anek Latin 14px 300 Light #151515)
                                      const SizedBox(
                                        width: 58,
                                        height: 20,
                                        child: Text(
                                          '1 year Ago',
                                          style: TextStyle(
                                            fontFamily: 'AnekLatin',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Color(0xFF151515),
                                            height: 1.44,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 3),

                                      // "Perter park" & "Verified Buyer"
                                      Row(
                                        children: [
                                          const Text(
                                            'Perter park ',
                                            style: TextStyle(
                                              fontFamily: 'AnekLatin',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                              color: AppColors.menPrimaryBlue,
                                              height: 1.44,
                                            ),
                                          ),
                                          Container(
                                            width: 9,
                                            height: 9,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(color: AppColors.menPrimaryBlue, width: 0.5),
                                            ),
                                            child: const Icon(
                                              Icons.check,
                                              size: 6,
                                              color: AppColors.menPrimaryBlue,
                                            ),
                                          ),
                                          const SizedBox(width: 3),
                                          const Text(
                                            'Verified Buyer',
                                            style: TextStyle(
                                              fontFamily: 'AnekLatin',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                              color: AppColors.menPrimaryBlue,
                                              height: 1.44,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 6),

                                      // EXACT FIGMA SPEC: Frame 1261154829 & Frame 1261154831 (Width 36px, Height 20px, Gap 4px, Count Text Anek Latin 12px 400 Regular #151515)
                                      SizedBox(
                                        height: 20,
                                        child: Row(
                                          children: [
                                            // Frame 1261154829 (36px x 20px, Gap 4px)
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: const [
                                                Icon(Icons.thumb_up_alt_outlined, size: 12, color: Color(0xFF151515)),
                                                SizedBox(width: 4),
                                                Text(
                                                  '32',
                                                  style: TextStyle(
                                                    fontFamily: 'AnekLatin',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xFF151515),
                                                    height: 1.44,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 12),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: const [
                                                Icon(Icons.thumb_down_alt_outlined, size: 12, color: Color(0xFF151515)),
                                                SizedBox(width: 4),
                                                Text(
                                                  '02',
                                                  style: TextStyle(
                                                    fontFamily: 'AnekLatin',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xFF151515),
                                                    height: 1.44,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // EXACT FIGMA SPEC STICKY BOTTOM ACTION BAR (Rectangle 3463312: Height 90px, Frame 1261154834: Width 401px, Height 45px, Gap 15px)
            Container(
              height: 90,
              padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 22.5),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 10,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: SizedBox(
                height: 45,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Added ${selectedVariant.colorName} shirt (Size $_selectedSize) to Cart!',
                                ),
                                backgroundColor: AppColors.menPrimaryBlue,
                              ),
                            );
                          },
                          icon: const SizedBox(
                            width: 20,
                            height: 20,
                            child: Icon(Icons.shopping_cart_outlined, size: 20, color: AppColors.menPrimaryBlue),
                          ),
                          label: const Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontFamily: 'AnekLatin',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.menPrimaryBlue,
                              height: 1.0,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Color(0xFFC5C5C5), width: 1.0),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Proceeding to Checkout!'),
                                backgroundColor: AppColors.menPrimaryBlue,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.menPrimaryBlue,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Buy Now',
                            style: TextStyle(
                              fontFamily: 'AnekLatin',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
