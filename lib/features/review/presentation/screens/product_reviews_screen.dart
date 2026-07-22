import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../order/presentation/widgets/order_header.dart';
import '../widgets/review_card.dart';

class ProductReviewsScreen extends StatelessWidget {
  final String productTitle;
  final String productImageUrl;
  final VoidCallback? onBackTap;

  const ProductReviewsScreen({
    super.key,
    this.productTitle = 'TURTLE Men Slim Fit Self Design Spread Collar Formal Shirt...',
    this.productImageUrl = 'https://images.unsplash.com/photo-1617137984095-74e4e5e3613f?q=80&w=600&auto=format&fit=crop',
    this.onBackTap,
  });

  List<ProductReviewItemModel> _getSampleReviews() {
    return const [
      ProductReviewItemModel(
        id: 'rev_1',
        rating: 4,
        title: 'Perfect Product',
        comment: 'Good quality and finish. Great value for money. Could have done with help for installation as the wood is heavy and a little difficult to install.',
        timeAgo: '1 year Ago',
        authorName: 'Perter park',
        isVerifiedBuyer: true,
        likesCount: 32,
        dislikesCount: 2,
      ),
      ProductReviewItemModel(
        id: 'rev_2',
        rating: 4,
        title: 'Perfect Product',
        comment: 'Good quality and finish. Great value for money. Could have done with help for installation as the wood is heavy and a little difficult to install.',
        timeAgo: '1 year Ago',
        authorName: 'Perter park',
        isVerifiedBuyer: true,
        likesCount: 32,
        dislikesCount: 2,
      ),
      ProductReviewItemModel(
        id: 'rev_3',
        rating: 4,
        title: 'Perfect Product',
        comment: 'Good quality and finish. Great value for money. Could have done with help for installation as the wood is heavy and a little difficult to install.',
        timeAgo: '1 year Ago',
        authorName: 'Perter park',
        isVerifiedBuyer: true,
        likesCount: 32,
        dislikesCount: 2,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final reviews = _getSampleReviews();

    final body = AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Container(
        color: const Color(0xFFF3F5F7), // Figma background #F3F5F7
        child: Column(
          children: [
            // Custom Figma Header Card
            OrderHeader(
              title: 'Review',
              onBackTap: onBackTap,
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                  bottom: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Top Product Summary Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14.0),
                          child: Image.network(
                            productImageUrl,
                            width: 64.0,
                            height: 64.0,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 64.0,
                              height: 64.0,
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.image_not_supported, color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14.0),
                        Expanded(
                          child: Text(
                            productTitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'AnekLatin',
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                              color: Color(0xFF151515),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18.0),

                    // 2. Ratings & Reviews Header Section
                    const Text(
                      'Ratings & Reviews',
                      style: TextStyle(
                        fontFamily: 'AnekLatin',
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        color: Color(0xFF000000),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Row(
                      children: [
                        // 4 yellow filled stars + 1 grey star
                        ...List.generate(
                          4,
                          (index) => const Icon(
                            Icons.star_rounded,
                            color: Color(0xFFFFB800),
                            size: 20.0,
                          ),
                        ),
                        const Icon(
                          Icons.star_rounded,
                          color: Color(0xFFD1D5DB),
                          size: 20.0,
                        ),
                        const SizedBox(width: 8.0),
                        const Text(
                          '(100 Review)',
                          style: TextStyle(
                            fontFamily: 'AnekLatin',
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                            color: Color(0xFF151515),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    const Row(
                      children: [
                        Text(
                          'based on ratings by Verified Buyers',
                          style: TextStyle(
                            fontFamily: 'AnekLatin',
                            fontWeight: FontWeight.w400,
                            fontSize: 13.0,
                            color: Color(0xFF666666),
                          ),
                        ),
                        SizedBox(width: 4.0),
                        Icon(
                          Icons.check_circle_outline,
                          size: 14.0,
                          color: Color(0xFF666666),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),

                    // 3. Reviews List
                    Column(
                      children: reviews.map((review) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: ReviewCard(
                            review: review,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      body: body,
    );
  }
}
