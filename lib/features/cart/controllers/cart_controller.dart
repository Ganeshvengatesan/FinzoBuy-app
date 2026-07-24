import 'package:flutter/material.dart';
import '../data/models/cart_item_model.dart';
import '../data/models/order_summary_model.dart';

class CartController extends ChangeNotifier {
  static final CartController _instance = CartController._internal();
  factory CartController() => _instance;
  CartController._internal();

  final List<CartItemModel> _items = [
    CartItemModel(
      id: '1',
      title: 'Men Dark Green Cotton Slim Fit Shirt',
      sizeText: 'Size: L | Color: Dark Green',
      imageAsset: 'assets/images/men_shirt_dark_green.png',
      rating: '4.8',
      deliveryDate: 'Delivery by Thu, 25 Jul',
      price: 409,
      originalPrice: 1999,
      quantity: 1,
    ),
    CartItemModel(
      id: '2',
      title: 'Men Pink Cotton Casual Shirt',
      sizeText: 'Size: M | Color: Soft Pink',
      imageAsset: 'assets/images/men_shirt_pink.png',
      rating: '4.6',
      deliveryDate: 'Delivery by Fri, 26 Jul',
      price: 290,
      originalPrice: 2000,
      quantity: 1,
    ),
  ];

  List<CartItemModel> get items => List<CartItemModel>.from(_items);

  OrderSummaryModel get summary {
    double totalMrp = 0;
    for (var item in _items) {
      totalMrp += item.originalPrice * item.quantity;
    }
    return OrderSummaryModel(
      mrp: totalMrp > 0 ? totalMrp : 3999,
      platformFee: 20,
      discounts: 2600,
      couponDiscount: 20,
    );
  }

  double get totalPrice {
    double total = 0;
    for (var item in _items) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void addItem(CartItemModel item) {
    final existingIndex = _items.indexWhere(
      (i) => i.title == item.title && i.sizeText == item.sizeText,
    );
    if (existingIndex != -1) {
      _items[existingIndex].quantity += item.quantity;
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void incrementQuantity(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1 && _items[index].quantity > 1) {
      _items[index].quantity--;
      notifyListeners();
    }
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}

