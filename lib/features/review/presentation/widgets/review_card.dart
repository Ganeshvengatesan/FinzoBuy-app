import 'package:flutter/material.dart';

class ProductReviewItemModel {
  final String id;
  final int rating;
  final String title;
  final String comment;
  final String timeAgo;
  final String authorName;
  final bool isVerifiedBuyer;
  final int likesCount;
  final int dislikesCount;

  const ProductReviewItemModel({
    required this.id,
    required this.rating,
    required this.title,
    required this.comment,
    required this.timeAgo,
    required this.authorName,
    this.isVerifiedBuyer = true,
    required this.likesCount,
    required this.dislikesCount,
  });
}

class ReviewCard extends StatelessWidget {
  final ProductReviewItemModel review;
  final VoidCallback? onLikeTap;
  final VoidCallback? onDislikeTap;

  const ReviewCard({
    super.key,
    required this.review,
    this.onLikeTap,
    this.onDislikeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0), // 10px per Figma
        border: Border.all(
          color: Colors.white,
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Rating Badge + Star + Title
          Row(
            children: [
              // Rating Badge (e.g. "4")
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF4C4DDC), // Blue rating badge
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  '${review.rating}',
                  style: const TextStyle(
                    fontFamily: 'AnekLatin',
                    fontWeight: FontWeight.w700,
                    fontSize: 13.0,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 6.0),
              const Icon(
                Icons.star_rounded,
                color: Color(0xFFFFB800), // Yellow star
                size: 18.0,
              ),
              const SizedBox(width: 6.0),
              Text(
                review.title,
                style: const TextStyle(
                  fontFamily: 'AnekLatin',
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                  color: Color(0xFF151515),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),

          // Inner Comment Box (Lavender fill #EDEDFF)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: const Color(0xFFEDEDFF), // Soft lavender fill
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              review.comment,
              style: const TextStyle(
                fontFamily: 'AnekLatin',
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                height: 1.45,
                color: Color(0xFF333333),
              ),
            ),
          ),
          const SizedBox(height: 12.0),

          // Footer: Time Ago + Author Name + Verified Buyer + Likes/Dislikes
          Text(
            review.timeAgo,
            style: const TextStyle(
              fontFamily: 'AnekLatin',
              fontWeight: FontWeight.w400,
              fontSize: 13.0,
              color: Color(0xFF888888),
            ),
          ),
          const SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Author Name & Verified Buyer
              Row(
                children: [
                  Text(
                    review.authorName,
                    style: const TextStyle(
                      fontFamily: 'AnekLatin',
                      fontWeight: FontWeight.w500,
                      fontSize: 13.0,
                      color: Color(0xFF5E49FF),
                    ),
                  ),
                  if (review.isVerifiedBuyer) ...[
                    const SizedBox(width: 4.0),
                    const Icon(
                      Icons.check_circle_outline,
                      size: 14.0,
                      color: Color(0xFF5E49FF),
                    ),
                    const SizedBox(width: 4.0),
                    const Text(
                      'Verified Buyer',
                      style: TextStyle(
                        fontFamily: 'AnekLatin',
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0,
                        color: Color(0xFF5E49FF),
                      ),
                    ),
                  ],
                ],
              ),

              // Likes & Dislikes
              Row(
                children: [
                  GestureDetector(
                    onTap: onLikeTap,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.thumb_up_outlined,
                          size: 15.0,
                          color: Color(0xFF666666),
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          review.likesCount < 10
                              ? '0${review.likesCount}'
                              : '${review.likesCount}',
                          style: const TextStyle(
                            fontFamily: 'AnekLatin',
                            fontSize: 12.0,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14.0),
                  GestureDetector(
                    onTap: onDislikeTap,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.thumb_down_outlined,
                          size: 15.0,
                          color: Color(0xFF666666),
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          review.dislikesCount < 10
                              ? '0${review.dislikesCount}'
                              : '${review.dislikesCount}',
                          style: const TextStyle(
                            fontFamily: 'AnekLatin',
                            fontSize: 12.0,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
