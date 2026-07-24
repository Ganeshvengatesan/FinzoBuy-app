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
  final VoidCallback? onRemove;
  final VoidCallback? onSaveLater;

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
    this.onRemove,
    this.onSaveLater,
  });

  @override
  Widget build(BuildContext context) {
    // EXACT FIGMA SPEC: Group 1000011165 (Width: 401px, MinHeight: 215px, Radius: 16px, Background: #FFFFFF)
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 215),
      padding: const EdgeInsets.all(14),
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

                    // EXACT FIGMA SPEC: Group 100001164 (Width: 233px, Height: 56px, #EAFCEB Light Green Box)
                    Container(
                      width: 233,
                      height: 56,
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
                          Row(
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
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9E6),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: onDecrement,
                      borderRadius: BorderRadius.circular(4),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        child: Icon(Icons.remove, size: 16, color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
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
                    InkWell(
                      onTap: onIncrement,
                      borderRadius: BorderRadius.circular(4),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        child: Icon(Icons.add, size: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Remove Button
              Expanded(
                child: GestureDetector(
                  onTap: onRemove,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE5E5),
                      borderRadius: BorderRadius.circular(6),
                    ),
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

              const SizedBox(width: 8),

              // Save Later Button
              Expanded(
                child: GestureDetector(
                  onTap: onSaveLater,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0F8E6),
                      borderRadius: BorderRadius.circular(6),
                    ),
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
            ],
          ),
        ],
      ),
    );
  }
}
