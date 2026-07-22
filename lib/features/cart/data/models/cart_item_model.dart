class CartItemModel {
  final String id;
  final String title;
  final String sizeText;
  final String imageAsset;
  final String rating;
  final String deliveryDate;
  final double price;
  final double originalPrice;
  int quantity;

  CartItemModel({
    required this.id,
    required this.title,
    required this.sizeText,
    required this.imageAsset,
    required this.rating,
    required this.deliveryDate,
    required this.price,
    required this.originalPrice,
    this.quantity = 1,
  });

  CartItemModel copyWith({
    String? id,
    String? title,
    String? sizeText,
    String? imageAsset,
    String? rating,
    String? deliveryDate,
    double? price,
    double? originalPrice,
    int? quantity,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      sizeText: sizeText ?? this.sizeText,
      imageAsset: imageAsset ?? this.imageAsset,
      rating: rating ?? this.rating,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      quantity: quantity ?? this.quantity,
    );
  }
}
