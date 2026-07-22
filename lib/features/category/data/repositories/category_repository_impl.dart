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
        imageUrl: 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?q=80&w=600&auto=format&fit=crop',
      ),
      ShopCategoryModel(
        id: 'cat_men_fashion',
        title: "Men Fashion's",
        backgroundColor: Color(0xFFE4EBFD), // Soft pastel blue/lavender
        imageUrl: 'https://images.unsplash.com/photo-1617137984095-74e4e5e3613f?q=80&w=600&auto=format&fit=crop',
      ),
      ShopCategoryModel(
        id: 'cat_kids_fashion',
        title: "Kids Fashion's",
        backgroundColor: Color(0xFFFDE8F5), // Soft pastel pink/magenta
        imageUrl: 'https://images.unsplash.com/photo-1519238263530-99bdd11df2ea?q=80&w=600&auto=format&fit=crop',
      ),
      ShopCategoryModel(
        id: 'cat_luxury_beauty',
        title: 'Luxury Beauty',
        backgroundColor: Color(0xFFEEF8DB), // Soft pastel yellow-green
        imageUrl: 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?q=80&w=600&auto=format&fit=crop',
      ),
      ShopCategoryModel(
        id: 'cat_mobile',
        title: 'Mobile',
        backgroundColor: Color(0xFFFFF5D6), // Soft warm cream
        imageUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?q=80&w=600&auto=format&fit=crop',
      ),
      ShopCategoryModel(
        id: 'cat_bag_wallet',
        title: 'Bag wallet',
        backgroundColor: Color(0xFFFFEDE4), // Soft pastel peach
        imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?q=80&w=600&auto=format&fit=crop',
      ),
      ShopCategoryModel(
        id: 'cat_home_appliances',
        title: 'Home Appliances',
        backgroundColor: Color(0xFFFFF6E5), // Soft pastel yellow-cream
        imageUrl: 'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?q=80&w=600&auto=format&fit=crop',
      ),
      ShopCategoryModel(
        id: 'cat_pets',
        title: 'Pets',
        backgroundColor: Color(0xFFFFEDE4), // Soft pastel peach
        imageUrl: 'https://images.unsplash.com/photo-1583511655857-d19b40a7a54e?q=80&w=600&auto=format&fit=crop',
      ),
    ];
  }
}
