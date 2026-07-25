import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/route_names.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _autoSlideTimer;

  final List<Map<String, String>> _onboardingSlides = const [
    {
      'image': 'assets/images/get_started_1.png',
      'title': 'Redefine Your Everyday Style',
      'subtitle': 'Explore premium fashion collections, curated looks, and exclusive luxury trends tailored just for you.',
    },
    {
      'image': 'assets/images/get_started_2.png',
      'title': 'Unmatched Quality & Comfort',
      'subtitle': 'Discover top-tier streetwear and formal wear designed with luxury fabrics and precision craftsmanship.',
    },
    {
      'image': 'assets/images/get_started_3.png',
      'title': 'Fast Delivery & Seamless Shopping',
      'subtitle': 'Shop your favorite outfits effortlessly with instant location delivery, easy returns, and secure checkout.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentIndex + 1) % _onboardingSlides.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToLogin() {
    context.push(RouteNames.loginPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Sliding Portrait Background Images
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: _onboardingSlides.length,
            itemBuilder: (context, index) {
              final slide = _onboardingSlides[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    slide['image']!,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFF1F1F1F),
                        child: const Center(
                          child: Icon(Icons.style, size: 64, color: Colors.white30),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),

          // 2. Full Bottom Black Gradient Overlay for High Contrast Text & Buttons
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.35, 0.65, 1.0],
                  colors: [
                    Colors.black.withValues(alpha: 0.15),
                    Colors.black.withValues(alpha: 0.30),
                    Colors.black.withValues(alpha: 0.85),
                    Colors.black.withValues(alpha: 0.98),
                  ],
                ),
              ),
            ),
          ),



          // 4. Bottom Content: Attractive Animated Copy, Page Indicators & Get Started Button
          Positioned(
            left: 20,
            right: 20,
            bottom: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated Title & Subtitle based on active page
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: Column(
                    key: ValueKey<int>(_currentIndex),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _onboardingSlides[_currentIndex]['title']!,
                        style: const TextStyle(
                          fontFamily: 'AnekLatin',
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _onboardingSlides[_currentIndex]['subtitle']!,
                        style: const TextStyle(
                          fontFamily: 'AnekLatin',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Sleek Page Indicator Dots
                Row(
                  children: List.generate(
                    _onboardingSlides.length,
                    (index) {
                      final isSelected = _currentIndex == index;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 6.0),
                        width: isSelected ? 24.0 : 8.0,
                        height: 6.0,
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.lightPrimary : Colors.white38,
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 32),

                // Main "Get Started" Button
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _navigateToLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightPrimary,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: AppColors.lightPrimary.withValues(alpha: 0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Get Started',
                          style: TextStyle(
                            fontFamily: 'AnekLatin',
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward_rounded, size: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
