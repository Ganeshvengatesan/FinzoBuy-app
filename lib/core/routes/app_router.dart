import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/get_started_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/profile/presentation/screens/profile_menu_screen.dart';
import '../../features/profile/presentation/screens/my_profile_screen.dart';
import '../../features/profile/presentation/screens/wishlist_screen.dart';
import '../../features/profile/presentation/screens/notifications_screen.dart';
import '../../features/profile/presentation/screens/terms_and_conditions_screen.dart';
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
import '../../features/search/presentation/screens/search_screen.dart';
import '../services/auth_service.dart';
import 'route_names.dart';

class AppRouter {
  AppRouter._();

  static CustomTransitionPage<void> _buildSlidePage({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;
        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.getStartedPath,
    redirect: (context, state) async {
      final loggedIn = await AuthService.isLoggedIn();
      final path = state.uri.toString();
      if (loggedIn && (path == RouteNames.getStartedPath || path == RouteNames.loginPath)) {
        return RouteNames.homePath;
      }
      return null;
    },
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('No route defined for ${state.uri.toString()}'),
      ),
    ),
    routes: [
      GoRoute(
        name: RouteNames.getStarted,
        path: RouteNames.getStartedPath,
        pageBuilder: (context, state) => _buildSlidePage(
          state: state,
          child: const GetStartedScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.login,
        path: RouteNames.loginPath,
        pageBuilder: (context, state) => _buildSlidePage(
          state: state,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.home,
        path: RouteNames.homePath,
        pageBuilder: (context, state) => _buildSlidePage(
          state: state,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.menFashion,
        path: RouteNames.menFashionPath,
        pageBuilder: (context, state) => _buildSlidePage(
          state: state,
          child: const MenFashionScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.menFashionDetail,
        path: RouteNames.menFashionDetailPath,
        pageBuilder: (context, state) {
          final product = state.extra as MenProductModel?;
          return _buildSlidePage(
            state: state,
            child: MenFashionDetailScreen(product: product),
          );
        },
      ),
      GoRoute(
        name: RouteNames.category,
        path: RouteNames.categoryPath,
        pageBuilder: (context, state) => _buildSlidePage(
          state: state,
          child: const ShopByCategoryScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.myOrder,
        path: RouteNames.myOrderPath,
        pageBuilder: (context, state) => _buildSlidePage(
          state: state,
          child: const MyOrderScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.orderDetails,
        path: RouteNames.orderDetailsPath,
        pageBuilder: (context, state) {
          final order = state.extra as OrderModel?;
          return _buildSlidePage(
            state: state,
            child: OrderDetailsScreen(order: order),
          );
        },
      ),
      GoRoute(
        name: RouteNames.trackOrder,
        path: RouteNames.trackOrderPath,
        pageBuilder: (context, state) {
          final order = state.extra as OrderModel?;
          return _buildSlidePage(
            state: state,
            child: TrackOrderScreen(orderId: order?.orderId ?? '#3454545'),
          );
        },
      ),
      GoRoute(
        name: RouteNames.writeReview,
        path: RouteNames.writeReviewPath,
        pageBuilder: (context, state) => _buildSlidePage(
          state: state,
          child: const WriteReviewScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.productReviews,
        path: RouteNames.productReviewsPath,
        pageBuilder: (context, state) => _buildSlidePage(
          state: state,
          child: const ProductReviewsScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.cart,
        path: RouteNames.cartPath,
        pageBuilder: (context, state) => _buildSlidePage(
          state: state,
          child: const MyCartScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.checkout,
        path: RouteNames.checkoutPath,
        pageBuilder: (context, state) => _buildSlidePage(
          state: state,
          child: const OrderReviewScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.selectAddress,
        path: RouteNames.selectAddressPath,
        pageBuilder: (context, state) => _buildSlidePage(
          state: state,
          child: const SelectAddressScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.addAddress,
        path: RouteNames.addAddressPath,
        pageBuilder: (context, state) => _buildSlidePage(
          state: state,
          child: const AddAddressScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.paymentMethod,
        path: RouteNames.paymentMethodPath,
        pageBuilder: (context, state) => _buildSlidePage(
          state: state,
          child: const SelectPaymentMethodScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.orderSuccess,
        path: RouteNames.orderSuccessPath,
        pageBuilder: (context, state) => _buildSlidePage(
          state: state,
          child: const OrderSuccessScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.profileMenu,
        path: RouteNames.profileMenuPath,
        pageBuilder: (context, state) => _buildSlidePage(
          state: state,
          child: const ProfileMenuScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.myProfile,
        path: RouteNames.myProfilePath,
        pageBuilder: (context, state) => _buildSlidePage(
          state: state,
          child: const MyProfileScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.wishlist,
        path: RouteNames.wishlistPath,
        pageBuilder: (context, state) => _buildSlidePage(
          state: state,
          child: const WishlistScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.notifications,
        path: RouteNames.notificationsPath,
        pageBuilder: (context, state) => _buildSlidePage(
          state: state,
          child: const NotificationsScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.termsAndConditions,
        path: RouteNames.termsAndConditionsPath,
        pageBuilder: (context, state) => _buildSlidePage(
          state: state,
          child: const TermsAndConditionsScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.search,
        path: RouteNames.searchPath,
        pageBuilder: (context, state) => _buildSlidePage(
          state: state,
          child: const SearchScreen(),
        ),
      ),
    ],
  );
}
