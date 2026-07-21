import 'package:flutter/material.dart';

class AiBannerSection extends StatelessWidget {
  const AiBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.zero, // Flat edge-to-edge
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.zero, // Sharp borders
        child: Image.asset(
          'assets/images/banner_3.png',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}
