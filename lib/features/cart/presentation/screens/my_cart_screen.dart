import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/route_names.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  int _item1Qty = 2;
  int _item2Qty = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // EXACT FIGMA SPEC: Top Header Bar (Group 1000011089: Width 400px, Height 30px, Left 19px)
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 19),
              color: Colors.white,
              child: Row(
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
                    'My Cart',
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
            ),

            // Scrollable Content Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // EXACT FIGMA SPEC: Delivery Address Bar (Group 1000011161: 400px x 51px, Background #E8E7FF)
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
                          // 34px x 34px Circle Home Icon Container (Radius 17px, Border 1px #FFFFFF, Background #FFFFFF)
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
                              child: SizedBox(
                                width: 17,
                                height: 14,
                                child: Icon(
                                  Icons.home_outlined,
                                  color: AppColors.menPrimaryBlue,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),

                          // Frame 1261154817: Address Text Row (Gap 7px, Height 16px)
                          const Expanded(
                            child: SizedBox(
                              height: 16,
                              child: Text(
                                'Home  Polt 4 White Avenue 1st Street...',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'AnekLatin',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                  height: 1.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 7),

                          // Frame 1261154861: Right Arrow Circular Button (28px x 28px, Radius 14.74px, Background #4D43FE)
                          Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.menPrimaryBlue,
                            ),
                            child: const Center(
                              child: SizedBox(
                                width: 11.2,
                                height: 11.2,
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 11,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // EXACT FIGMA SPEC: Cart Product Item 1 (Dark Green Shirt)
                    _buildCartItemCard(
                      imageAsset: 'assets/images/men_shirt_dark_green.png',
                      title: 'Regular Fit Shirt | Cotton...',
                      sizeText: 'Size : 38',
                      rating: '4.0',
                      deliveryDate: 'Apr 01 Wed',
                      quantity: _item1Qty,
                      onDecrement: () {
                        if (_item1Qty > 1) {
                          setState(() => _item1Qty--);
                        }
                      },
                      onIncrement: () {
                        setState(() => _item1Qty++);
                      },
                    ),

                    const SizedBox(height: 14),

                    // EXACT FIGMA SPEC: Cart Product Item 2 (Cream Shirt)
                    _buildCartItemCard(
                      imageAsset: 'assets/images/men_banner.png',
                      title: 'Regular Fit Shirt | Cotton...',
                      sizeText: 'Size : 38',
                      rating: '4.0',
                      deliveryDate: 'Apr 01 Wed',
                      quantity: _item2Qty,
                      onDecrement: () {
                        if (_item2Qty > 1) {
                          setState(() => _item2Qty--);
                        }
                      },
                      onIncrement: () {
                        setState(() => _item2Qty++);
                      },
                    ),

                    const SizedBox(height: 16),

                    // EXACT FIGMA SPEC: Apply Coupon Card (Rectangle 3463318: 400px x 66px, Radius 10px, Border 2px #FFFFFF, #FFF6DB Soft Yellow)
                    Container(
                      width: 400,
                      height: 66,
                      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.menSectionBg,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Rectangle 3463320: Blue Ticket Box (41px x 37px, Radius 10px, Background #4D43FE)
                          Container(
                            width: 41,
                            height: 37,
                            decoration: BoxDecoration(
                              color: AppColors.menPrimaryBlue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              // Layer_1: White Ticket Icon (19px x 13px)
                              child: SizedBox(
                                width: 19,
                                height: 13,
                                child: Icon(
                                  Icons.local_offer_outlined,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),

                          // Text Column
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              // Apply Coupon Title Text: 93px x 16px, Anek Latin 16px 500 Medium #000000
                              Text(
                                'Apply Coupon',
                                style: TextStyle(
                                  fontFamily: 'AnekLatin',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF000000),
                                  height: 1.0,
                                ),
                              ),
                              SizedBox(height: 2),
                              // SBI4356 Subtitle Text: 48px x 20px, Anek Latin 14px 400 Regular #151515
                              Text(
                                'SBI4356',
                                style: TextStyle(
                                  fontFamily: 'AnekLatin',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF151515),
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),

                          // Right Arrow Circle Button (30px x 30px, #4D43FE)
                          Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.menPrimaryBlue,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // EXACT FIGMA SPEC: Order Summary Card Container (Group 1000011178: 401px x 237px, Border 1px #FFFFFF)
                    Container(
                      width: 401,
                      height: 237,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white,
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Order Summary',
                            style: TextStyle(
                              fontFamily: 'AnekLatin',
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),

                          _buildSummaryRow(label: 'MRP', value: '₹3,999'),
                          const SizedBox(height: 8),
                          _buildSummaryRow(label: 'Platfrom Fee', value: '20'),
                          const SizedBox(height: 8),
                          _buildSummaryRow(label: 'Discounts', value: '-2600', isGreen: true),
                          const SizedBox(height: 8),
                          _buildSummaryRow(label: 'Coupon Discount', value: '-20', isGreen: true),

                          const SizedBox(height: 12),

                          // Rectangle 3463319: Total Pill Row Container (376px x 41px, Radius 10px, Border 1px #FFFFFF, #E8E7FF Soft Lavender)
                          Container(
                            width: 376,
                            height: 41,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8E7FF),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Total',
                                  style: TextStyle(
                                    fontFamily: 'AnekLatin',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                // Total Price ₹699 Text: 36px x 16px, Anek Latin 16px 700 Bold #4D43FE
                                SizedBox(
                                  width: 36,
                                  height: 16,
                                  child: Text(
                                    '₹699',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontFamily: 'AnekLatin',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.menPrimaryBlue,
                                      height: 1.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // EXACT FIGMA SPEC: Sticky Bottom Action Bar (Price Left ₹409: 54px x 24px, Place Order Button Frame 1261154834: 193px x 45px)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Sticky Price Text ₹409: 54px x 24px, Anek Latin Bold #4D43FE
                  const SizedBox(
                    width: 54,
                    height: 24,
                    child: Text(
                      '₹409',
                      style: TextStyle(
                        fontFamily: 'AnekLatin',
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.menPrimaryBlue,
                        height: 1.0,
                      ),
                    ),
                  ),

                  // Frame 1261154834: Place Order Button Container (193px x 45px, Gap 15px, Radius 10px, Background #4D43FE)
                  SizedBox(
                    width: 193,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push(RouteNames.checkoutPath);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.menPrimaryBlue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const SizedBox(
                        width: 88,
                        height: 20,
                        child: Center(
                          child: Text(
                            'Place Order',
                            style: TextStyle(
                              fontFamily: 'AnekLatin',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Cart Item Card Helper Widget (Frame 1261154846: Width 377px, Height 183px, Gap 11px)
  Widget _buildCartItemCard({
    required String imageAsset,
    required String title,
    required String sizeText,
    required String rating,
    required String deliveryDate,
    required int quantity,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Frame 1261154845: Top Row Container (Height 141px, Gap 19px)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rectangle 3463293: Product Image (119px x 141px, Radius 10px, Border 0.92px #FFFFFF)
              Container(
                width: 119,
                height: 141,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100,
                  border: Border.all(
                    color: Colors.white,
                    width: 0.92,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.person, color: Colors.grey),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 19),

              // Frame 1261154844: Cart Item Right Info Column Container (Width 196px, Gap 8px)
              SizedBox(
                width: 196,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Title Text (196px x 19px, Anek Latin 16px 500 Medium #221F1F)
                    SizedBox(
                      width: 196,
                      height: 19,
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'AnekLatin',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF221F1F),
                          height: 1.16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),

                    // Size Subtitle Text (196px x 14px, Weight 400 Regular 14px #A7A5A5)
                    SizedBox(
                      width: 196,
                      height: 14,
                      child: Text(
                        sizeText,
                        style: const TextStyle(
                          fontFamily: 'AnekLatin',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFA7A5A5),
                          height: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Group 1000011151: Rating Stars Row (116px x 14.67px, Star 5: 14.67px x 14.67px #EBA928, 4.0: 17px x 12px #A7A5A5)
                    SizedBox(
                      width: 116,
                      height: 14.67,
                      child: Row(
                        children: [
                          Row(
                            children: List.generate(
                              4,
                              (index) => const Icon(Icons.star_rounded, size: 14.67, color: Color(0xFFEBA928)),
                            ),
                          ),
                          const Icon(Icons.star_rounded, size: 14.67, color: Colors.grey),
                          const SizedBox(width: 4),
                          const SizedBox(
                            width: 17,
                            height: 12,
                            child: Text(
                              '4.0',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFA7A5A5),
                                height: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // EXACT FIGMA SPEC: Rectangle 3463313 (233px x 56px, Radius 5px, Border 1px #FFFFFF, Colors: #F7F7F7 Soft Grey)
                    Container(
                      width: 233,
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Group 20: "Eligible For FREE delivery" Row (175px x 18px)
                          SizedBox(
                            width: 175,
                            height: 18,
                            child: Row(
                              children: const [
                                Icon(Icons.local_shipping_outlined, size: 14, color: Color(0xFF00A859)),
                                SizedBox(width: 4),
                                Text(
                                  'Eligible For FREE delivery',
                                  style: TextStyle(
                                    fontFamily: 'AnekLatin',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF00A859),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 2),

                          // Delivery Subtext: 133px x 14px, Anek Latin 14px 400 Regular #151515
                          SizedBox(
                            width: 133,
                            height: 14,
                            child: Text(
                              'Delivery by $deliveryDate',
                              style: const TextStyle(
                                fontFamily: 'AnekLatin',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF151515),
                                height: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 11),

          // Frame 1261154843: Actions Row (Height 31px, Gap 6px)
          SizedBox(
            height: 31,
            child: Row(
              children: [
                // Group 1000011163: Quantity Counter Box (110px x 29px, Border 1px #FFFFFF, Soft Cream #FFF9E6)
                Container(
                  width: 110,
                  height: 29,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF9E6),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: onDecrement,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text('-', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      // Quantity 02 Text: 15px x 14px, Anek Latin 14px 400 Regular #151515
                      SizedBox(
                        width: 15,
                        height: 14,
                        child: Center(
                          child: Text(
                            quantity.toString().padLeft(2, '0'),
                            style: const TextStyle(
                              fontFamily: 'AnekLatin',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF151515),
                              height: 1.0,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onIncrement,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text('+', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 6),

                // Frame 1261154841: Remove Button (Expanded, Radius 5px, Border 1px #FFFFFF, Background #FFDCDC Soft Pink)
                Expanded(
                  child: Container(
                    height: 31,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFDCDC),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(5),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.delete_outline, size: 14, color: Color(0xFF151515)),
                            SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                'Remove',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'AnekLatin',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF151515),
                                  height: 1.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 6),

                // Frame 1261154842: Save Later Button (Expanded, Radius 5px, Border 1px #FFFFFF, Background #DEFFE3 Soft Mint)
                Expanded(
                  child: Container(
                    height: 31,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDEFFE3),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(5),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: Icon(Icons.bookmark_border, size: 15, color: Color(0xFF151515)),
                            ),
                            SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                'Save Later',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'AnekLatin',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF151515),
                                  height: 1.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Summary Row Helper (Label: Anek Latin 14px 400 Regular #151515 127px x 20px, Green Value: Anek Latin 16px 500 Medium #008B15 41px x 16px)
  Widget _buildSummaryRow({required String label, required String value, bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 127,
          height: 20,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'AnekLatin',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF151515),
              height: 1.44,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'AnekLatin',
            fontSize: isGreen ? 16 : 15,
            fontWeight: isGreen ? FontWeight.w500 : FontWeight.w600,
            color: isGreen ? const Color(0xFF008B15) : Colors.black,
            height: 1.0,
          ),
        ),
      ],
    );
  }
}
