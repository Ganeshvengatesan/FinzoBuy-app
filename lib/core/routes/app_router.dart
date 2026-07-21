import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/screens/home_screen.dart';
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
