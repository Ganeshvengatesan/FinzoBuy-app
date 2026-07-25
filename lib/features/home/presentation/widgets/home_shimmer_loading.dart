import 'package:flutter/material.dart';

class HomeShimmerLoading extends StatefulWidget {
  const HomeShimmerLoading({super.key});

  @override
  State<HomeShimmerLoading> createState() => _HomeShimmerLoadingState();
}

class _HomeShimmerLoadingState extends State<HomeShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.35, end: 0.85).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildShimmerBox({
    required double width,
    required double height,
    double borderRadius = 8.0,
  }) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey.shade300.withValues(alpha: _animation.value),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Skeleton Box
          Container(
            padding: const EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 16),
            color: Colors.grey.shade100,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildShimmerBox(width: 140, height: 28, borderRadius: 14),
                    Row(
                      children: [
                        _buildShimmerBox(width: 36, height: 36, borderRadius: 18),
                        const SizedBox(width: 10),
                        _buildShimmerBox(width: 36, height: 36, borderRadius: 18),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _buildShimmerBox(width: double.infinity, height: 46, borderRadius: 12),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Categories Skeleton Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                5,
                (index) => Column(
                  children: [
                    _buildShimmerBox(width: 52, height: 52, borderRadius: 26),
                    const SizedBox(height: 8),
                    _buildShimmerBox(width: 44, height: 12, borderRadius: 6),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Promo Banner Skeleton Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildShimmerBox(width: double.infinity, height: 160, borderRadius: 16),
          ),
          const SizedBox(height: 24),

          // Section Title Skeleton
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildShimmerBox(width: 150, height: 20, borderRadius: 6),
                _buildShimmerBox(width: 60, height: 16, borderRadius: 6),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // 2x2 Grid Skeleton
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                return _buildShimmerBox(width: double.infinity, height: double.infinity, borderRadius: 16);
              },
            ),
          ),
        ],
      ),
    );
  }
}
