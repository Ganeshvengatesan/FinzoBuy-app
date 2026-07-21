import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart';

abstract class ProductRepository {
  Future<List<CategoryModel>> getCategories();
  Future<List<ProductModel>> getRecentlyViewed();
  Future<List<ProductModel>> getTopDealGridCategories();
  Future<List<ProductModel>> getTechDeals();
  Future<List<ProductModel>> getBestSellers();
}
