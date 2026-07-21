import 'package:flutter/material.dart';
import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart';
import '../../domain/repositories/product_repository.dart';

class HomeController extends ChangeNotifier {
  final ProductRepository _repository;

  HomeController(this._repository);

  // States
  int _currentNavIndex = 0;
  int _carouselIndex = 0;
  bool _isLoading = false;
  String? _errorMessage;

  List<CategoryModel> _categories = [];
  List<ProductModel> _recentlyViewed = [];
  List<ProductModel> _topDeals = [];
  List<ProductModel> _techDeals = [];
  List<ProductModel> _bestSellers = [];

  // Getters
  int get currentNavIndex => _currentNavIndex;
  int get carouselIndex => _carouselIndex;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<CategoryModel> get categories => _categories;
  List<ProductModel> get recentlyViewed => _recentlyViewed;
  List<ProductModel> get topDeals => _topDeals;
  List<ProductModel> get techDeals => _techDeals;
  List<ProductModel> get bestSellers => _bestSellers;

  // Setters/Actions
  void setNavIndex(int index) {
    _currentNavIndex = index;
    notifyListeners();
  }

  void setCarouselIndex(int index) {
    _carouselIndex = index;
    notifyListeners();
  }

  Future<void> loadHomeData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Fetch everything concurrently to optimize performance
      final results = await Future.wait([
        _repository.getCategories(),
        _repository.getRecentlyViewed(),
        _repository.getTopDealGridCategories(),
        _repository.getTechDeals(),
        _repository.getBestSellers(),
      ]);

      _categories = results[0] as List<CategoryModel>;
      _recentlyViewed = results[1] as List<ProductModel>;
      _topDeals = results[2] as List<ProductModel>;
      _techDeals = results[3] as List<ProductModel>;
      _bestSellers = results[4] as List<ProductModel>;
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
