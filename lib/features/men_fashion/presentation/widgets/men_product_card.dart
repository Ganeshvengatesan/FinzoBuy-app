import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/men_product_model.dart';

class MenProductCard extends StatefulWidget {
  final MenProductModel product;
  final VoidCallback onTap;
  final ValueChanged<bool>? onFavoriteToggle;

  const MenProductCard({
    super.key,
    required this.product,
    required this.onTap,
    this.onFavoriteToggle,
  });

  @override
  State<MenProductCard> createState() => _MenProductCardState();
}

class _MenProductCardState extends State<MenProductCard> {
  late bool _isFav;

  @override
  void initState() {
    super.initState();
    _isFav = widget.product.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200, width: 1),
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
            // Image (104 x 134 ratio in Figma)
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.asset(
                        widget.product.imageAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey.shade100,
                          child: const Icon(
                            Icons.person,
                            size: 48,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Favorite Button Top-Right
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isFav = !_isFav;
                        });
                        widget.onFavoriteToggle?.call(_isFav);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.9),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(
                          _isFav ? Icons.favorite : Icons.favorite_border,
                          size: 14,
                          color: _isFav ? Colors.redAccent : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Exact Product Typography & Specs from Figma
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Product Title: Anek Latin, 14px, Weight 500, #221F1F
                  Text(
                    widget.product.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'AnekLatin',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF221F1F),
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 3),

                  // Star Rating Row: 55.27px x 8px, 5 stars + count
                  Row(
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star_rounded,
                            size: 10,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${widget.product.reviewCount}',
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Price Row: Strikethrough #A7A5A5 9.19px + Bold #4D43FE 11.03px
                  Row(
                    children: [
                      Text(
                        '₹${widget.product.originalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontFamily: 'AnekLatin',
                          fontSize: 9.19,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.lineThrough,
                          color: Color(0xFFA7A5A5),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '₹${widget.product.discountPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontFamily: 'AnekLatin',
                          fontSize: 11.03,
                          fontWeight: FontWeight.w700,
                          color: AppColors.menPrimaryBlue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
