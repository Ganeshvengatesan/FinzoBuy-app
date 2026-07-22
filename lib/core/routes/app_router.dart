import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/men_fashion/presentation/screens/men_fashion_screen.dart';
import '../../features/men_fashion/presentation/screens/men_fashion_detail_screen.dart';
import '../../features/men_fashion/data/models/men_product_model.dart';
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
    ],
  );
}
