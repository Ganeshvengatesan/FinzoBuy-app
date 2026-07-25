import 'package:flutter/material.dart';
import '../../domain/repositories/category_repository.dart';
import '../models/shop_category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  @override
  Future<List<ShopCategoryModel>> getShopCategories() async {
    // Simulate brief network latency
    await Future.delayed(const Duration(milliseconds: 150));
    
    return const [
      ShopCategoryModel(
        id: 'cat_women_fashion',
        title: "Women Fashion's",
        backgroundColor: Color(0xFFFFF6E5), // Soft pastel yellow-cream
        imageUrl: 'assets/images/women-fashion.png',
      ),
      ShopCategoryModel(
        id: 'cat_men_fashion',
        title: "Men Fashion's",
        backgroundColor: Color(0xFFE4EBFD), // Soft pastel blue/lavender
        imageUrl: 'assets/images/men-fashion.png',
      ),
      ShopCategoryModel(
        id: 'cat_kids_fashion',
        title: "Kids Fashion's",
        backgroundColor: Color(0xFFFDE8F5), // Soft pastel pink/magenta
        imageUrl: 'assets/images/kids fashion.png',
      ),
      ShopCategoryModel(
        id: 'cat_luxury_beauty',
        title: 'Luxury Beauty',
        backgroundColor: Color(0xFFEEF8DB), // Soft pastel yellow-green
        imageUrl: 'assets/images/luxury.png',
      ),
      ShopCategoryModel(
        id: 'cat_mobile',
        title: 'Mobile',
        backgroundColor: Color(0xFFFFF5D6), // Soft warm cream
        imageUrl: 'assets/images/moble.png',
      ),
      ShopCategoryModel(
        id: 'cat_bag_wallet',
        title: 'Bag wallet',
        backgroundColor: Color(0xFFFFEDE4), // Soft pastel peach
        imageUrl: 'assets/images/bag-wallet.png',
      ),
      ShopCategoryModel(
        id: 'cat_home_appliances',
        title: 'Home Appliances',
        backgroundColor: Color(0xFFFFF6E5), // Soft pastel yellow-cream
        imageUrl: 'assets/images/home-applicatns.png',
      ),
      ShopCategoryModel(
        id: 'cat_pets',
        title: 'Pets',
        backgroundColor: Color(0xFFFFEDE4), // Soft pastel peach
        imageUrl: 'assets/images/animals.png',
      ),
    ];
  }
}
