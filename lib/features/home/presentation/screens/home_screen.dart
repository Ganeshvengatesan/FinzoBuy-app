import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../domain/repositories/product_repository.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../controllers/home_controller.dart';
import '../widgets/home_header.dart';
import '../widgets/category_bar.dart';
import '../widgets/promo_carousel.dart';
import '../widgets/recently_viewed_section.dart';
import '../widgets/top_deals_section.dart';
import '../widgets/spotlight_section.dart';
import '../widgets/tech_deals_section.dart';
import '../widgets/ai_banner_section.dart';
import '../widgets/best_sellers_section.dart';
import '../widgets/home_shimmer_loading.dart';
import '../widgets/fashion_bottom_nav_bar.dart';
import '../../../category/presentation/screens/shop_by_category_screen.dart';
import '../../../profile/presentation/screens/profile_menu_screen.dart';
import '../../../cart/presentation/screens/my_cart_screen.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class HomeScreen extends StatefulWidget {
  final ProductRepository? repository;
  const HomeScreen({super.key, this.repository});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeController _controller;
  String _selectedCategoryId = 'cat_for_you';

  @override
  void initState() {
    super.initState();
    _controller = HomeController(widget.repository ?? ProductRepositoryImpl());
    _controller.loadHomeData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  DateTime? _lastBackPressTime;

  void _showExitToast() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Tap again to exit',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'AnekLatin',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: const Color(0xFF1E1E1E),
        margin: const EdgeInsets.only(bottom: 30, left: 80, right: 80),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            if (_controller.currentNavIndex != 0) {
              _controller.setNavIndex(0);
              return;
            }
            final now = DateTime.now();
            if (_lastBackPressTime == null ||
                now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
              _lastBackPressTime = now;
              _showExitToast();
            } else {
              SystemNavigator.pop();
            }
          },
          child: Scaffold(
          backgroundColor: Colors.white,
          body: _controller.isLoading
              ? const HomeShimmerLoading()
              : _controller.errorMessage != null
                  ? SafeArea(child: _buildErrorState(theme))
                  : _controller.currentNavIndex == 1
                      ? ShopByCategoryScreen(
                          isEmbedded: true,
                          onBackTap: () => _controller.setNavIndex(0),
                        )
                      : _controller.currentNavIndex == 2
                          ? const MyCartScreen()
                          : _controller.currentNavIndex == 3
                              ? const ProfileMenuScreen()
                              : Stack(
                                  children: [
                                    // Full-bleed top gradient starting behind status bar
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      height: 240.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            stops: const [0.0, 0.65, 1.0],
                                            colors: [
                                              AppColors.lightPrimary.withValues(alpha: 0.18),
                                              AppColors.lightPrimary.withValues(alpha: 0.05),
                                              AppColors.lightPrimary.withValues(alpha: 0.0),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SafeArea(
                                      child: RefreshIndicator(
                                        onRefresh: _controller.loadHomeData,
                                        child: SingleChildScrollView(
                                          physics: const AlwaysScrollableScrollPhysics(),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // 1. Header (Location + Notifications + Search)
                                              const HomeHeader(),
                                              AppSizes.hGap8,

                                              // 2. Horizontal Categories
                                              CategoryBar(
                                                categories: _controller.categories,
                                                selectedCategoryId: _selectedCategoryId,
                                                onCategorySelected: (categoryId) {
                                                  setState(() {
                                                    _selectedCategoryId = categoryId;
                                                  });
                                                },
                                              ),
                                              AppSizes.hGap16,

                                              // 3. Sliding Banners (Carousel)
                                              const PromoCarousel(),
                                              AppSizes.hGap24,

                                              // 4. Recently Viewed Products
                                              RecentlyViewedSection(products: _controller.recentlyViewed),
                                              AppSizes.hGap24,

                                              // 5. Top Deals (2x2 Grid Categories)
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16),
                                                child: TopDealsSection(dealCategories: _controller.topDeals),
                                              ),
                                              AppSizes.hGap24,

                                              // 6. In the Spotlight (Galaxy S24 Banner)
                                              const SpotlightSection(),
                                              AppSizes.hGap24,

                                              // 7. Top Deals on Tech
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16),
                                                child: TechDealsSection(techProducts: _controller.techDeals),
                                              ),
                                              AppSizes.hGap24,

                                              // 8. AI Banner (Earbuds Banner)
                                              const AiBannerSection(),
                                              AppSizes.hGap24,

                                              // 9. Best Sellers in Clothing & Accessories
                                              BestSellersSection(products: _controller.bestSellers),

                                              // Bottom spacer
                                              AppSizes.hGap32,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
          bottomNavigationBar: FashionBottomNavBar(
            currentIndex: _controller.currentNavIndex,
            onTap: _controller.setNavIndex,
          ),
        ),
      );
    },
    );
  }

  Widget _buildErrorState(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.p24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.redAccent,
            ),
            AppSizes.hGap16,
            Text(
              'Failed to load Home data',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            AppSizes.hGap8,
            Text(
              _controller.errorMessage ?? 'Unknown error occurred.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            AppSizes.hGap24,
            ElevatedButton(
              onPressed: _controller.loadHomeData,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
