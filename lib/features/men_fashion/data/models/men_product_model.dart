class MenColorVariant {
  final String colorName;
  final String imageAsset;
  final double price;
  final String hexCode;

  const MenColorVariant({
    required this.colorName,
    required this.imageAsset,
    required this.price,
    required this.hexCode,
  });
}

class MenProductModel {
  final String id;
  final String title;
  final String subtitle;
  final String imageAsset;
  final double originalPrice;
  final double discountPrice;
  final double rating;
  final int reviewCount;
  final bool isFavorite;
  final List<MenColorVariant> colorVariants;

  const MenProductModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.originalPrice,
    required this.discountPrice,
    required this.rating,
    required this.reviewCount,
    this.isFavorite = false,
    this.colorVariants = const [],
  });

  MenProductModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? imageAsset,
    double? originalPrice,
    double? discountPrice,
    double? rating,
    int? reviewCount,
    bool? isFavorite,
    List<MenColorVariant>? colorVariants,
  }) {
    return MenProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      imageAsset: imageAsset ?? this.imageAsset,
      originalPrice: originalPrice ?? this.originalPrice,
      discountPrice: discountPrice ?? this.discountPrice,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isFavorite: isFavorite ?? this.isFavorite,
      colorVariants: colorVariants ?? this.colorVariants,
    );
  }
}
