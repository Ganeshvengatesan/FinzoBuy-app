import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/route_names.dart';
import '../../../address/controllers/address_controller.dart';
import '../../../address/presentation/widgets/delivery_address_header_card.dart';
import '../../controllers/cart_controller.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/order_summary_card.dart';

class OrderReviewScreen extends StatefulWidget {
  const OrderReviewScreen({super.key});

  @override
  State<OrderReviewScreen> createState() => _OrderReviewScreenState();
}

class _OrderReviewScreenState extends State<OrderReviewScreen> {
  final CartController _cartController = CartController();
  final AddressController _addressController = AddressController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: Listenable.merge([_cartController, _addressController]),
          builder: (context, _) {
            final cartItems = _cartController.items;
            final summary = _cartController.summary;
            final activeAddress = _addressController.selectedAddress;

            return Column(
              children: [
                // Top Header Bar (< Order Review with Right Search Icon)
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

                // Main Body Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Cart Items List Widget
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartItems.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item = cartItems[index];
                            return CartItemCard(
                              imageAsset: item.imageAsset,
                              title: item.title,
                              sizeText: item.sizeText,
                              rating: item.rating,
                              deliveryDate: item.deliveryDate,
                              quantity: item.quantity,
                              onDecrement: () => _cartController.decrementQuantity(item.id),
                              onIncrement: () => _cartController.incrementQuantity(item.id),
                              onRemove: () => _cartController.removeItem(item.id),
                            );
                          },
                        ),

                        const SizedBox(height: 16),

                        // Order Summary Card Widget
                        OrderSummaryCard(
                          mrp: summary.mrpFormatted,
                          platformFee: summary.platformFeeFormatted,
                          discounts: summary.discountsFormatted,
                          couponDiscount: summary.couponDiscountFormatted,
                          total: summary.totalFormatted,
                        ),

                        const SizedBox(height: 16),

                        // Delivery Address Container Widget (Placed at the bottom)
                        DeliveryAddressHeaderCard(
                          name: activeAddress.name,
                          address: activeAddress.fullAddress,
                          onChangeAddress: () {
                            context.push(RouteNames.selectAddressPath);
                          },
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
            );
          },
        ),
      ),
    );
  }
}
