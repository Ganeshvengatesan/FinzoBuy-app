import '../../data/models/shop_category_model.dart';

abstract class CategoryRepository {
  Future<List<ShopCategoryModel>> getShopCategories();
}
