import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_names.dart';


class PromoCarousel extends StatefulWidget {
  const PromoCarousel({super.key});

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  final List<String> _banners = [
    'assets/images/banner_1.png',
    'assets/images/banner_1.png', // Duplicate to simulate multiple slides
    'assets/images/banner_1.png',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.round() + 1;
        if (nextPage >= _banners.length) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // PageView Banner (Height increased)
        SizedBox(
          height: 225,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: _banners.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => context.push(RouteNames.menFashionDetailPath),
                child: Image.asset(
                  _banners[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
          ),
        ),
        AppSizes.hGap12,
        // Sleek Minimalist Dot/Pill Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _banners.length,
            (index) {
              final isSelected = _currentIndex == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3.5),
                width: isSelected ? 22.0 : 6.0,
                height: 6.0,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.lightPrimary : const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(3.0),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
