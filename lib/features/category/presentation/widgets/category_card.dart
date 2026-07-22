import 'package:flutter/material.dart';
import '../../data/models/shop_category_model.dart';

class CategoryCard extends StatelessWidget {
  final ShopCategoryModel category;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: category.backgroundColor,
          borderRadius: BorderRadius.circular(19.0), // 19px per Figma
          border: Border.all(
            color: Colors.white, // 1px #FFFFFF per Figma
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
        padding: const EdgeInsets.all(10.0), // 10px padding per Figma (193 outer -> 173 inner)
        child: Column(
          children: [
            // Inner White Image Box (Rectangle 3463293)
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(19.0), // 19px per Figma
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(19.0),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Image.network(
                      category.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: Colors.grey,
                            size: 32,
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            // Category Title Label
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 2.0, left: 4.0, right: 4.0),
              child: Text(
                category.title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'AnekLatin',
                  fontWeight: FontWeight.w700, // 700 Bold per Figma
                  fontSize: 16.0,
                  height: 1.1,
                  letterSpacing: 0.0,
                  color: Color(0xFF151515), // #151515 per Figma
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

