import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/route_names.dart';
import '../../../cart/controllers/cart_controller.dart';
import '../../../cart/presentation/widgets/order_summary_card.dart';
import '../../controllers/payment_controller.dart';
import '../widgets/payment_method_card.dart';

class SelectPaymentMethodScreen extends StatefulWidget {
  const SelectPaymentMethodScreen({super.key});

  @override
  State<SelectPaymentMethodScreen> createState() => _SelectPaymentMethodScreenState();
}

class _SelectPaymentMethodScreenState extends State<SelectPaymentMethodScreen> {
  final PaymentController _paymentController = PaymentController();
  final CartController _cartController = CartController();

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
        child: ListenableBuilder(
          listenable: Listenable.merge([_paymentController, _cartController]),
          builder: (context, _) {
            final selectedIndex = _paymentController.selectedMethodIndex;
            final summary = _cartController.summary;

            return Column(
              children: [
                // Header Bar
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
                        // UPI ID Payment Card
                        PaymentMethodCard(
                          icon: Icons.account_balance_wallet_outlined,
                          title: 'UPI ID',
                          isSelected: selectedIndex == 0,
                          onTap: () => _paymentController.selectPaymentMethod(0),
                        ),

                        const SizedBox(height: 12),

                        // Credit Card Expanded Card
                        _buildCreditCardExpandedCard(selectedIndex == 1),

                        const SizedBox(height: 12),

                        // Net Banking Card
                        PaymentMethodCard(
                          icon: Icons.account_balance_outlined,
                          title: 'Net Banking',
                          isSelected: selectedIndex == 2,
                          onTap: () => _paymentController.selectPaymentMethod(2),
                        ),

                        const SizedBox(height: 12),

                        // Cash on Delivery Card
                        PaymentMethodCard(
                          icon: Icons.payments_outlined,
                          title: 'Cash on Delivery',
                          isSelected: selectedIndex == 3,
                          onTap: () => _paymentController.selectPaymentMethod(3),
                        ),

                        const SizedBox(height: 18),

                        // Order Summary Card Widget
                        OrderSummaryCard(
                          mrp: summary.mrpFormatted,
                          platformFee: summary.platformFeeFormatted,
                          discounts: summary.discountsFormatted,
                          couponDiscount: summary.couponDiscountFormatted,
                          total: summary.totalFormatted,
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),

                // Sticky Bottom Action Bar
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
                      SizedBox(
                        height: 24,
                        child: Text(
                          '₹${_cartController.totalPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
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
            );
          },
        ),
      ),
    );
  }

  Widget _buildCreditCardExpandedCard(bool isSelected) {
    return GestureDetector(
      onTap: () => _paymentController.selectPaymentMethod(1),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.menPrimaryBlue : Colors.transparent,
            width: isSelected ? 1.5 : 0,
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
            Row(
              children: [
                // Group 1000011169 Credit Card Icon (21px x 15px, #4D43FE)
                const SizedBox(
                  width: 21,
                  height: 15,
                  child: Icon(Icons.credit_card, size: 18, color: AppColors.menPrimaryBlue),
                ),
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

            Row(
              children: [
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
      ),
    );
  }
}
