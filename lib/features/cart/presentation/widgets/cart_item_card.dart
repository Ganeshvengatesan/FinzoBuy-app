import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String sizeText;
  final String rating;
  final String deliveryDate;
  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const CartItemCard({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.sizeText,
    required this.rating,
    required this.deliveryDate,
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    // EXACT FIGMA SPEC: Group 1000011165 (Width: 401px, Height: 217px, Radius: 16px, Background: #FFFFFF)
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 401),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white,
          width: 0.92,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // EXACT FIGMA SPEC: Rectangle 3463293 Product Image (Width: 119px, Height: 141px, Radius: 10px)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 119,
                  height: 141,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white,
                      width: 0.92,
                    ),
                  ),
                  child: Image.asset(
                    imageAsset,
                    width: 119,
                    height: 141,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 119,
                        height: 141,
                        color: const Color(0xFFF1F1F1),
                        child: const Icon(Icons.checkroom, color: Colors.grey, size: 40),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Product Info Column (Frame 1261154843: Gap 6px)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand/Title Text (16px SemiBold #151515)
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'AnekLatin',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF151515),
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Size Subtitle Text (13px Regular #767676)
                    Text(
                      sizeText,
                      style: const TextStyle(
                        fontFamily: 'AnekLatin',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF767676),
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Star Rating Row (4 Gold Stars + 1 Grey Star + Rating Text 4.0)
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Color(0xFFFFB800)),
                        const Icon(Icons.star, size: 14, color: Color(0xFFFFB800)),
                        const Icon(Icons.star, size: 14, color: Color(0xFFFFB800)),
                        const Icon(Icons.star, size: 14, color: Color(0xFFFFB800)),
                        const Icon(Icons.star, size: 14, color: Color(0xFFCCCCCC)),
                        const SizedBox(width: 6),
                        Text(
                          rating,
                          style: const TextStyle(
                            fontFamily: 'AnekLatin',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF767676),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // EXACT FIGMA SPEC: Group 100001164 (#EAFCEB Light Green Box)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAFCEB),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: const [
                                Icon(Icons.local_shipping, size: 14, color: Color(0xFF00A859)),
                                SizedBox(width: 4),
                                Text(
                                  'Eligible For FREE delivery',
                                  style: TextStyle(
                                    fontFamily: 'AnekLatin',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF00A859),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            deliveryDate,
                            style: const TextStyle(
                              fontFamily: 'AnekLatin',
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF151515),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Action Buttons Row: Quantity Counter (- 02 +), Remove Button with 18px Trash Icon, Save Later Button with 18px Bookmark Icon
          Row(
            children: [
              // Quantity Counter Pill Container (#FFF9E6)
              Container(
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9E6),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: onDecrement,
                      child: const Icon(Icons.remove, size: 14, color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        quantity < 10 ? '0$quantity' : '$quantity',
                        style: const TextStyle(
                          fontFamily: 'AnekLatin',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onIncrement,
                      child: const Icon(Icons.add, size: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Remove Button (Frame 1261154839: Icon 18px x 18px, #FFE5E5)
              Expanded(
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE5E5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            width: 18,
                            height: 18,
                            child: Icon(Icons.delete_outline, size: 18, color: Color(0xFFD32F2F)),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Remove',
                            style: TextStyle(
                              fontFamily: 'AnekLatin',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFD32F2F),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Save Later Button (Icon 18px x 18px, #E0F8E6)
              Expanded(
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F8E6),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            width: 18,
                            height: 18,
                            child: Icon(Icons.bookmark_outline, size: 18, color: Color(0xFF008B15)),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Save Later',
                            style: TextStyle(
                              fontFamily: 'AnekLatin',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF008B15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
