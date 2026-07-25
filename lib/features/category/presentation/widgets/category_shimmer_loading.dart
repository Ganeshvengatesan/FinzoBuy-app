import 'package:flutter/material.dart';

class CategoryShimmerLoading extends StatefulWidget {
  const CategoryShimmerLoading({super.key});

  @override
  State<CategoryShimmerLoading> createState() => _CategoryShimmerLoadingState();
}

class _CategoryShimmerLoadingState extends State<CategoryShimmerLoading>
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
    _animation = Tween<double>(begin: 0.40, end: 0.85).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: 24.0,
          ),
          itemCount: 8,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 193 / 199,
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(19.0),
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  // Inner Image Skeleton Box
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200.withValues(alpha: _animation.value),
                        borderRadius: BorderRadius.circular(19.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Inner Text Skeleton Line
                  Container(
                    width: 90,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300.withValues(alpha: _animation.value),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
