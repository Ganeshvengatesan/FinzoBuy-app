import 'package:flutter/material.dart';

class MenHeroBanner extends StatelessWidget {
  final VoidCallback? onShopNow;

  const MenHeroBanner({
    super.key,
    this.onShopNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      height: 185,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Rotated vertical "Fashion" text on the left side
          RotatedBox(
            quarterTurns: 3,
            child: Center(
              child: Text(
                'Fashion',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4,
                  color: Colors.grey.shade400.withValues(alpha: 0.5),
                  fontFamily: 'AnekLatin',
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Main Hero Banner Card
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFFFFFDF5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Row(
                  children: [
                    // Left Image Container
                    Expanded(
                      flex: 4,
                      child: Image.asset(
                        'assets/images/men_banner.png',
                        fit: BoxFit.cover,
                        height: double.infinity,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.amber.shade50,
                          child: const Icon(
                            Icons.person,
                            size: 64,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ),

                    // Right Offer & Text Container
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Men's Clothing\nCollection",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                                color: Color(0xFF1F2937),
                                fontFamily: 'AnekLatin',
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '25% OFF',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 12),
                            OutlinedButton(
                              onPressed: onShopNow,
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.black, width: 1.2),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                minimumSize: const Size(90, 30),
                              ),
                              child: const Text(
                                'Shop Now',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
