import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/route_names.dart';

class SelectPaymentMethodScreen extends StatefulWidget {
  const SelectPaymentMethodScreen({super.key});

  @override
  State<SelectPaymentMethodScreen> createState() => _SelectPaymentMethodScreenState();
}

class _SelectPaymentMethodScreenState extends State<SelectPaymentMethodScreen> {
  int _selectedMethodIndex = 1; // 0 for UPI, 1 for Credit Card, 2 for Net Banking, 3 for COD

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _validThruController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _validThruController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // EXACT FIGMA SPEC: Top Header Bar (< Select Payment Method with Right Search Icon)
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
                    'Select Payment Method',
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

            // Scrollable Content Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 12),
                child: Column(
                  children: [
                    // EXACT FIGMA SPEC: Group 1000011175: UPI ID Payment Card (400px x 65px)
                    _buildCollapsedPaymentCard(
                      index: 0,
                      icon: Icons.account_balance_wallet_outlined,
                      title: 'UPI ID',
                    ),

                    const SizedBox(height: 12),

                    // EXACT FIGMA SPEC: Group 1000011174: Credit Card Expanded Payment Card (400px x 251px)
                    _buildCreditCardExpandedCard(),

                    const SizedBox(height: 12),

                    // Net Banking Card (Group 1000011172: 400px x 65px)
                    _buildCollapsedPaymentCard(
                      index: 2,
                      icon: Icons.account_balance_outlined,
                      title: 'Net Banking',
                    ),

                    const SizedBox(height: 12),

                    // Cash on Delivery Card (400px x 65px)
                    _buildCollapsedPaymentCard(
                      index: 3,
                      icon: Icons.payments_outlined,
                      title: 'Cash on Delivery',
                    ),

                    const SizedBox(height: 18),

                    // EXACT FIGMA SPEC: Group 1000011181: Order Summary Card Container (401px x 237px, Radius 10px, Border 1px #FFFFFF)
                    Container(
                      width: 401,
                      height: 237,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
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

                  // Place Order Button Container (193px x 45px, Radius 10px, Background #4D43FE)
                  SizedBox(
                    width: 193,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push(RouteNames.orderSuccessPath);
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

  // Collapsed Payment Card Helper (Group 1000011175: 400px x 65px, Radius 16px)
  Widget _buildCollapsedPaymentCard({
    required int index,
    required IconData icon,
    required String title,
  }) {
    final isSelected = _selectedMethodIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethodIndex = index;
        });
      },
      child: Container(
        width: 400,
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.menPrimaryBlue : Colors.transparent,
            width: isSelected ? 1.5 : 0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 22, color: AppColors.menPrimaryBlue),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'AnekLatin',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const Spacer(),
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
    );
  }

  // Expanded Credit Card Payment Card Helper (Group 1000011174: 400px x 251px, Radius 16px)
  Widget _buildCreditCardExpandedCard() {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              const Icon(Icons.credit_card, size: 22, color: AppColors.menPrimaryBlue),
              const SizedBox(width: 12),
              const Text(
                'Credit card',
                style: TextStyle(
                  fontFamily: 'AnekLatin',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.menPrimaryBlue,
                ),
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Card Number Field Label
          const Text(
            'Card Number',
            style: TextStyle(
              fontFamily: 'AnekLatin',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),

          // Card Number Input Box (Rectangle 3463325: Width 367px, Height 55px, Radius 10px, Border 2px #FFFFFF, Background #EDF6FF)
          Container(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFEDF6FF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            child: Center(
              child: TextField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontFamily: 'AnekLatin',
                  fontSize: 16,
                  letterSpacing: 2.0,
                  color: Colors.black87,
                ),
                decoration: const InputDecoration(
                  hintText: 'XXXX  XXXX  XXXX  XXXX',
                  hintStyle: TextStyle(
                    fontFamily: 'AnekLatin',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2.0,
                    color: Color(0xFFA7A5A5),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Valid Thru (68px x 19px, Anek Latin 16px 500 Medium #221F1F) & CVV Row
          Row(
            children: [
              // Valid Thru Box (Rectangle 3463326: 175px x 55px, Radius 10px, Border 2px #FFFFFF, Background #EDF6FF)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 68,
                      height: 19,
                      child: Text(
                        'Valid Thru',
                        style: TextStyle(
                          fontFamily: 'AnekLatin',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF221F1F),
                          height: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 175,
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDF6FF),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      child: Center(
                        child: TextField(
                          controller: _validThruController,
                          keyboardType: TextInputType.datetime,
                          style: const TextStyle(
                            fontFamily: 'AnekLatin',
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'MM/YY',
                            hintStyle: TextStyle(
                              fontFamily: 'AnekLatin',
                              fontSize: 14,
                              color: Color(0xFFA7A5A5),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 14),

              // CVV Box (175px x 55px, Radius 10px, Border 2px #FFFFFF, Background #EDF6FF)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 19,
                      child: Text(
                        'CVV',
                        style: TextStyle(
                          fontFamily: 'AnekLatin',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF221F1F),
                          height: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 175,
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDF6FF),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      child: Center(
                        child: TextField(
                          controller: _cvvController,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontFamily: 'AnekLatin',
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          decoration: const InputDecoration(
                            hintText: '***',
                            hintStyle: TextStyle(
                              fontFamily: 'AnekLatin',
                              fontSize: 14,
                              color: Color(0xFFA7A5A5),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
