import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/men_fashion/presentation/screens/men_fashion_screen.dart';
import '../../features/men_fashion/presentation/screens/men_fashion_detail_screen.dart';
import '../../features/men_fashion/data/models/men_product_model.dart';
import '../../features/category/presentation/screens/shop_by_category_screen.dart';
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
        name: RouteNames.category,
        path: RouteNames.categoryPath,
        builder: (context, state) => const ShopByCategoryScreen(),
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
