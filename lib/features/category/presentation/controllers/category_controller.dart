import 'package:flutter/material.dart';
import '../../data/models/shop_category_model.dart';
import '../../domain/repositories/category_repository.dart';

class CategoryController extends ChangeNotifier {
  final CategoryRepository _repository;

  CategoryController(this._repository);

  List<ShopCategoryModel> _categories = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ShopCategoryModel> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadCategories() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _categories = await _repository.getShopCategories();
    } catch (e) {
      _errorMessage = 'Failed to load categories: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
