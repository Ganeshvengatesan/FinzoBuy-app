import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/route_names.dart';

class OrderReviewScreen extends StatefulWidget {
  const OrderReviewScreen({super.key});

  @override
  State<OrderReviewScreen> createState() => _OrderReviewScreenState();
}

class _OrderReviewScreenState extends State<OrderReviewScreen> {
  int _item1Qty = 1;
  int _item2Qty = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // EXACT FIGMA SPEC: Top Header Bar (< Order Review with Right Search Icon)
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
                    'Order Review',
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
                    // Cart Product Item 1 (Dark Green Shirt, Quantity 01)
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

                    // Cart Product Item 2 (Dark Green Shirt, Quantity 01)
                    _buildCartItemCard(
                      imageAsset: 'assets/images/men_shirt_dark_green.png',
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

                    const SizedBox(height: 18),

                    // EXACT FIGMA SPEC: Order Summary Card Container (401px x 237px, Border 1px #FFFFFF)
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

                          // Total Pill Row Container (376px x 41px, Radius 10px, Border 1px #FFFFFF, #E8E7FF Soft Lavender)
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

                    const SizedBox(height: 18),

                    // EXACT FIGMA SPEC: Delivery Address Container (Group 1000011180: 401px x 217px, Radius 16px, Border 1px #FFFFFF)
                    Container(
                      width: 401,
                      height: 217,
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
                            'Delivery Address',
                            style: TextStyle(
                              fontFamily: 'AnekLatin',
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Rectangle 3463320: Address Lavender Box (376px x 96px, Radius 10px, Border 1px #FFFFFF, Background #E8E7FF)
                          Container(
                            width: 376,
                            height: 96,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8E7FF),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'John Deo',
                                  style: TextStyle(
                                    fontFamily: 'AnekLatin',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF151515),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'No: 4, White avenue Green park Extension, Madurai, Tamil Nadu - 625018, India',
                                  style: TextStyle(
                                    fontFamily: 'AnekLatin',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF151515),
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Change Delivery Address Button (Width 212px, Height 40px, Radius 5px, Border 1px #C5C5C5)
                          Container(
                            width: 212,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: const Color(0xFFC5C5C5),
                                width: 1.0,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                context.push(RouteNames.selectAddressPath);
                              },
                              borderRadius: BorderRadius.circular(5),
                              child: const Center(
                                child: Text(
                                  'Change Delivery Address',
                                  style: TextStyle(
                                    fontFamily: 'AnekLatin',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF151515),
                                  ),
                                ),
                              ),
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
                  SizedBox(
                    width: 193,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push(RouteNames.paymentMethodPath);
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

  // Cart Item Card Helper Widget
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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

              SizedBox(
                width: 196,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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

          SizedBox(
            height: 31,
            child: Row(
              children: [
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
