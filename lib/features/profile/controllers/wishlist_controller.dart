import 'package:flutter/material.dart';
import '../../men_fashion/data/models/men_product_model.dart';

class WishlistController extends ChangeNotifier {
  static final WishlistController _instance = WishlistController._internal();
  factory WishlistController() => _instance;
  WishlistController._internal();

  final List<MenProductModel> _items = [
    const MenProductModel(
      id: 'wish_1',
      title: 'Regular Fit Shirt | Cotton...',
      subtitle: 'Regular Fit Shirt | Cotton...',
      imageAsset: 'assets/images/men_shirt_dark_blue.png',
      originalPrice: 59.99,
      discountPrice: 5535,
      rating: 4.0,
      reviewCount: 453,
      isFavorite: true,
    ),
    const MenProductModel(
      id: 'wish_2',
      title: 'Regular Fit Shirt | Cotton...',
      subtitle: 'Regular Fit Shirt | Cotton...',
      imageAsset: 'assets/images/recently_view_3.png',
      originalPrice: 59.99,
      discountPrice: 5535,
      rating: 4.0,
      reviewCount: 453,
      isFavorite: true,
    ),
    const MenProductModel(
      id: 'wish_3',
      title: 'Regular Fit Shirt | Cotton...',
      subtitle: 'Regular Fit Shirt | Cotton...',
      imageAsset: 'assets/images/men_shirt_pink.png',
      originalPrice: 59.99,
      discountPrice: 5535,
      rating: 4.0,
      reviewCount: 453,
      isFavorite: true,
    ),
    const MenProductModel(
      id: 'wish_4',
      title: 'Regular Fit Shirt | Cotton...',
      subtitle: 'Regular Fit Shirt | Cotton...',
      imageAsset: 'assets/images/recently_view_1.png',
      originalPrice: 59.99,
      discountPrice: 5535,
      rating: 4.0,
      reviewCount: 453,
      isFavorite: true,
    ),
  ];

  List<MenProductModel> get items => List<MenProductModel>.from(_items);
  int get itemCount => _items.length;

  bool isWishlisted(String productId) {
    return _items.any((item) => item.id == productId);
  }

  bool toggleWishlist(MenProductModel product) {
    final existingIndex = _items.indexWhere((item) => item.id == product.id);
    bool added = false;
    if (existingIndex >= 0) {
      _items.removeAt(existingIndex);
      added = false;
    } else {
      _items.add(product.copyWith(isFavorite: true));
      added = true;
    }
    notifyListeners();
    return added;
  }

  void removeItem(String productId) {
    _items.removeWhere((item) => item.id == productId);
    notifyListeners();
  }
}
