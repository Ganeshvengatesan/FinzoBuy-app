import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import '../../../category/presentation/screens/shop_by_category_screen.dart';
import '../../../order/presentation/screens/my_order_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final Color activeNavColor = AppColors.lightPrimary;
    final Color inactiveNavColor = AppColors.unselectedIcon;

    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        return Scaffold(
          body: _controller.isLoading
              ? const SafeArea(child: Center(child: CircularProgressIndicator()))
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
                              ? MyOrderScreen(
                                  onBackTap: () => _controller.setNavIndex(0),
                                )
                              : SafeArea(
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
          bottomNavigationBar: SizedBox(
            height: 76.0,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: isDarkMode ? AppColors.darkDivider : AppColors.lightDivider,
                    width: 1.0,
                  ),
                ),
              ),
              child: BottomNavigationBar(
                currentIndex: _controller.currentNavIndex,
                onTap: _controller.setNavIndex,
                type: BottomNavigationBarType.fixed,
                backgroundColor: isDarkMode ? theme.colorScheme.surface : Colors.white,
                selectedItemColor: activeNavColor,
                unselectedItemColor: inactiveNavColor,
                selectedFontSize: 11.0,
                unselectedFontSize: 11.0,
                items: [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: SvgPicture.asset(
                        'assets/icons/ic_home.svg',
                        width: 22,
                        height: 22,
                        colorFilter: ColorFilter.mode(
                          _controller.currentNavIndex == 0 ? activeNavColor : inactiveNavColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Image.asset(
                        'assets/icons/ic_category.png',
                        width: 22,
                        height: 22,
                        color: _controller.currentNavIndex == 1 ? activeNavColor : inactiveNavColor,
                      ),
                    ),
                    label: 'Category',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Image.asset(
                        'assets/icons/ic_cart.png',
                        width: 22,
                        height: 22,
                        color: _controller.currentNavIndex == 2 ? activeNavColor : inactiveNavColor,
                      ),
                    ),
                    label: 'Cart',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Image.asset(
                        'assets/icons/ic_profile.png',
                        width: 22,
                        height: 22,
                        color: _controller.currentNavIndex == 3 ? activeNavColor : inactiveNavColor,
                      ),
                    ),
                    label: 'Profile',
                  ),
                ],
              ),
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
