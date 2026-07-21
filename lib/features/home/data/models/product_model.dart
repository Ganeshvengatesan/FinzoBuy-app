class ProductModel {
  final String id;
  final String title;
  final String brand;
  final double rating;
  final int reviewCount;
  final double? oldPrice;
  final double price;
  final List<String> images;
  final String? tag;

  ProductModel({
    required this.id,
    required this.title,
    required this.brand,
    required this.rating,
    required this.reviewCount,
    this.oldPrice,
    required this.price,
    required this.images,
    this.tag,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      title: json['title'] as String,
      brand: json['brand'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      oldPrice: json['oldPrice'] != null ? (json['oldPrice'] as num).toDouble() : null,
      price: (json['price'] as num).toDouble(),
      images: List<String>.from(json['images'] as List),
      tag: json['tag'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'brand': brand,
      'rating': rating,
      'reviewCount': reviewCount,
      'oldPrice': oldPrice,
      'price': price,
      'images': images,
      'tag': tag,
    };
  }
}
