import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/men_fashion/presentation/screens/men_fashion_screen.dart';
import '../../features/men_fashion/presentation/screens/men_fashion_detail_screen.dart';
import '../../features/men_fashion/data/models/men_product_model.dart';
import '../../features/category/presentation/screens/shop_by_category_screen.dart';
import '../../features/order/presentation/screens/my_order_screen.dart';
import '../../features/order/presentation/screens/order_details_screen.dart';
import '../../features/order/presentation/screens/track_order_screen.dart';
import '../../features/review/presentation/screens/write_review_screen.dart';
import '../../features/review/presentation/screens/product_reviews_screen.dart';
import '../../features/order/data/models/order_model.dart';
import '../../features/cart/presentation/screens/my_cart_screen.dart';
import '../../features/cart/presentation/screens/order_review_screen.dart';
import '../../features/address/presentation/screens/select_address_screen.dart';
import '../../features/address/presentation/screens/add_address_screen.dart';
import '../../features/payment/presentation/screens/select_payment_method_screen.dart';
import '../../features/payment/presentation/screens/order_success_screen.dart';
import 'route_names.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.homePath,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('No route defined for ${state.uri.toString()}'),
      ),
    ),
    routes: [
      GoRoute(
        name: RouteNames.home,
        path: RouteNames.homePath,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: RouteNames.menFashion,
        path: RouteNames.menFashionPath,
        builder: (context, state) => const MenFashionScreen(),
      ),
      GoRoute(
        name: RouteNames.menFashionDetail,
        path: RouteNames.menFashionDetailPath,
        builder: (context, state) {
          final product = state.extra as MenProductModel?;
          return MenFashionDetailScreen(product: product);
        },
      ),
      GoRoute(
        name: RouteNames.category,
        path: RouteNames.categoryPath,
        builder: (context, state) => const ShopByCategoryScreen(),
      ),
      GoRoute(
        name: RouteNames.myOrder,
        path: RouteNames.myOrderPath,
        builder: (context, state) => const MyOrderScreen(),
      ),
      GoRoute(
        name: RouteNames.orderDetails,
        path: RouteNames.orderDetailsPath,
        builder: (context, state) {
          final order = state.extra as OrderModel?;
          return OrderDetailsScreen(order: order);
        },
      ),
      GoRoute(
        name: RouteNames.trackOrder,
        path: RouteNames.trackOrderPath,
        builder: (context, state) => const TrackOrderScreen(),
      ),
      GoRoute(
        name: RouteNames.writeReview,
        path: RouteNames.writeReviewPath,
        builder: (context, state) => const WriteReviewScreen(),
      ),
      GoRoute(
        name: RouteNames.productReviews,
        path: RouteNames.productReviewsPath,
        builder: (context, state) => const ProductReviewsScreen(),
        name: RouteNames.cart,
        path: RouteNames.cartPath,
        builder: (context, state) => const MyCartScreen(),
      ),
      GoRoute(
        name: RouteNames.checkout,
        path: RouteNames.checkoutPath,
        builder: (context, state) => const OrderReviewScreen(),
      ),
      GoRoute(
        name: RouteNames.selectAddress,
        path: RouteNames.selectAddressPath,
        builder: (context, state) => const SelectAddressScreen(),
      ),
      GoRoute(
        name: RouteNames.addAddress,
        path: RouteNames.addAddressPath,
        builder: (context, state) => const AddAddressScreen(),
      ),
      GoRoute(
        name: RouteNames.paymentMethod,
        path: RouteNames.paymentMethodPath,
        builder: (context, state) => const SelectPaymentMethodScreen(),
      ),
      GoRoute(
        name: RouteNames.orderSuccess,
        path: RouteNames.orderSuccessPath,
        builder: (context, state) => const OrderSuccessScreen(),
      ),
      // Future routes can be registered here:
      // GoRoute(
      //   name: RouteNames.productDetails,
      //   path: RouteNames.productDetailsPath,
      //   builder: (context, state) {
      //     final id = state.pathParameters['id']!;
      //     return ProductDetailsScreen(productId: id);
      //   },
      // ),
    ],
  );
}
