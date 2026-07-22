import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),

            // EXACT FIGMA SPEC: Top Title ("Payment Successfully")
            const Text(
              'Payment Successfully',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'AnekLatin',
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Colors.black,
                height: 1.1,
              ),
            ),

            const Spacer(),

            // EXACT FIGMA SPEC: image 1 (Width 207px, Height 207px) using payment_success_checkmark.png asset
            Center(
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // Decorative Confetti Ribbons
                  Positioned(
                    top: -50,
                    left: -60,
                    child: Container(
                      width: 16,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF4081),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -30,
                    right: -50,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFF29B6F6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -40,
                    left: -40,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFB74D),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -30,
                    right: -60,
                    child: Container(
                      width: 14,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFF26A69A),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),

                  // Exact image 1: payment_success_checkmark.png (207px x 207px)
                  SizedBox(
                    width: 207,
                    height: 207,
                    child: Image.asset(
                      'assets/images/payment_success_checkmark.png',
                      width: 207,
                      height: 207,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 207,
                          height: 207,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF76E037),
                                Color(0xFF45C01A),
                                Color(0xFF269500),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(52),
                            border: Border.all(
                              color: const Color(0xFFA5F476),
                              width: 4.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF269500).withValues(alpha: 0.4),
                                blurRadius: 28,
                                offset: const Offset(0, 14),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.check_rounded,
                              size: 110,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // EXACT FIGMA SPEC: Frame 49 Bottom Button (Width 367px, Height 45px, Radius 5px, Solid Royal Blue #4D43FE, "Continue to Shopping")
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SizedBox(
                width: 367,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.menPrimaryBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Continue to Shopping',
                    style: TextStyle(
                      fontFamily: 'AnekLatin',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
