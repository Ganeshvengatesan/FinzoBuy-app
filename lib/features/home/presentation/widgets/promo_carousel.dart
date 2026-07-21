import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';

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
        // PageView Banner
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: _banners.length,
            itemBuilder: (context, index) {
              return Image.asset(
                _banners[index],
                fit: BoxFit.cover,
                width: double.infinity,
              );
            },
          ),
        ),
        AppSizes.hGap12,
        // Hollow Circle Indicator Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _banners.length,
            (index) {
              final isSelected = _currentIndex == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: isSelected ? 32.0 : 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF4D43FE) : Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF4D43FE) : const Color(0xFFCCD4FF),
                    width: 1.5,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
