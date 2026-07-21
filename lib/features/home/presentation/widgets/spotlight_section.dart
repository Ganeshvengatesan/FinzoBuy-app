import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class SpotlightSection extends StatelessWidget {
  const SpotlightSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          const Text(
            'In the Spotlight',
            style: TextStyle(
              fontFamily: 'AnekLatin',
              fontWeight: FontWeight.w700,
              fontSize: 20.0,
              height: 1.0,
              letterSpacing: 0.0,
              color: Colors.black,
            ),
          ),
          AppSizes.hGap12,
          // Banner Image Card with Pink Bar
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner Image
                  Image.asset(
                    'assets/images/banner_2.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  // Pink Bar displaying From ₹5,535
                  Container(
                    width: double.infinity,
                    color: const Color(0xFFFFC1FE), // Solid pink bar
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontFamily: 'AnekLatin',
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0,
                          height: 1.0,
                          letterSpacing: 0.0,
                        ),
                        children: [
                          TextSpan(
                            text: 'From ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: '₹5,535',
                            style: TextStyle(color: AppColors.lightPrimary), // Brand color #4D43FE
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
