import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/widgets/discrete_progress_indicator.dart';
import '../../../category/presentation/widgets/category_header.dart';
import '../../controllers/cart_controller.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/order_summary_card.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  final CartController _cartController = CartController();
  bool _isExploring = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        body: ListenableBuilder(
          listenable: _cartController,
          builder: (context, _) {
            final cartItems = _cartController.items;
            final summary = _cartController.summary;

            return Column(
              children: [
                // Header Bar (Same style as Category Screen app bar)
                CategoryHeader(
                  title: 'My Cart',
                  onBackTap: () {
                    if (context.canPop()) {
                      context.pop();
                    }
                  },
                ),

                // Scrollable Cart Items List or Empty State
                Expanded(
                  child: cartItems.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/empty-cart.png',
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.shopping_bag_outlined,
                                      size: 100,
                                      color: Colors.grey,
                                    );
                                  },
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Your Cart is Empty',
                                  style: TextStyle(
                                    fontFamily: 'AnekLatin',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF151515),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Looks like you haven\'t added anything to your cart yet.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'AnekLatin',
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 42,
                                  child: ElevatedButton(
                                    onPressed: _isExploring
                                        ? null
                                        : () {
                                            HapticFeedback.mediumImpact();
                                            setState(() {
                                              _isExploring = true;
                                            });
                                            Future.delayed(const Duration(milliseconds: 300), () {
                                              if (mounted) {
                                                if (context.canPop()) {
                                                  context.pop();
                                                } else {
                                                  context.go(RouteNames.menFashionPath);
                                                }
                                              }
                                            });
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.menPrimaryBlue,
                                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: _isExploring
                                        ? const DiscreteProgressIndicator(color: Colors.white, size: 18)
                                        : const Text(
                                            'Explore Products',
                                            style: TextStyle(
                                              fontFamily: 'AnekLatin',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsets.only(left: 19, right: 19, top: 2, bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Cart Items List
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

                              // Apply Coupon Outer Card
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF8E7),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 38,
                                      height: 38,
                                      decoration: BoxDecoration(
                                        color: AppColors.menPrimaryBlue,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(Icons.percent_rounded, color: Colors.white, size: 20),
                                    ),
                                    const SizedBox(width: 12),

                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Apply Coupon',
                                            style: TextStyle(
                                              fontFamily: 'AnekLatin',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            'SBI4356',
                                            style: TextStyle(
                                              fontFamily: 'AnekLatin',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF767676),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.menPrimaryBlue,
                                      ),
                                      child: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 11,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 16),

                              // Order Summary Card
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

                // Sticky Bottom Action Bar (Only shown when cart is not empty)
                if (cartItems.isNotEmpty)
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
            );
          },
        ),
      ),
    );
  }
}
