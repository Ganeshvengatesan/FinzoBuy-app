class ReviewModel {
  final String orderId;
  final String productId;
  final String productTitle;
  final String productImageUrl;
  final double rating;
  final String comment;
  final List<String> mediaPaths;

  const ReviewModel({
    required this.orderId,
    required this.productId,
    required this.productTitle,
    required this.productImageUrl,
    this.rating = 5.0,
    this.comment = '',
    this.mediaPaths = const [],
  });

  ReviewModel copyWith({
    String? orderId,
    String? productId,
    String? productTitle,
    String? productImageUrl,
    double? rating,
    String? comment,
    List<String>? mediaPaths,
  }) {
    return ReviewModel(
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      productTitle: productTitle ?? this.productTitle,
      productImageUrl: productImageUrl ?? this.productImageUrl,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      mediaPaths: mediaPaths ?? this.mediaPaths,
    );
  }
}
