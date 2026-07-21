import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<CategoryModel>> getCategories() async {
    // Delay to simulate network call
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      CategoryModel(
        id: 'cat_for_you',
        name: 'For You',
        iconPath: 'assets/icons/ic_for_u.svg',
      ),
      CategoryModel(
        id: 'cat_fashion',
        name: 'Fashion',
        iconPath: 'assets/icons/ic_fashion.svg',
      ),
      CategoryModel(
        id: 'cat_mobile',
        name: 'Mobile',
        iconPath: 'assets/icons/ic_mobile.svg',
      ),
      CategoryModel(
        id: 'cat_electronics',
        name: 'Electronics',
        iconPath: 'assets/icons/ic_electronics.svg',
      ),
      CategoryModel(
        id: 'cat_beauty',
        name: 'Beauty',
        iconPath: 'assets/icons/ic_beauty.svg',
      ),
    ];
  }

  @override
  Future<List<ProductModel>> getRecentlyViewed() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      ProductModel(
        id: 'rv_sony_camera',
        title: 'Sony Digital Camera ZV-1F',
        brand: 'Sony',
        rating: 4.2,
        reviewCount: 1508,
        oldPrice: 42990,
        price: 37198,
        images: [
          'https://images.unsplash.com/photo-1502920917128-1da500764c6e?q=80&w=600&auto=format&fit=crop'
        ],
        tag: null,
      ),
      ProductModel(
        id: 'rv_redmi_watch',
        title: 'Redmi Watch 5 Active',
        brand: 'Xiaomi',
        rating: 4.5,
        reviewCount: 452,
        oldPrice: 5999,
        price: 5535,
        images: [
          'https://images.unsplash.com/photo-1542496658-e33a6d0d50f6?q=80&w=600&auto=format&fit=crop'
        ],
        tag: 'Fastest growing smartwatch maker',
      ),
      ProductModel(
        id: 'rv_boat_rockerz',
        title: 'BoAt Rockerz 480 Wireless',
        brand: 'boAt',
        rating: 4.0,
        reviewCount: 2016,
        oldPrice: 2499,
        price: 1999,
        images: [
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=600&auto=format&fit=crop'
        ],
        tag: 'Recently Launched',
      ),
    ];
  }

  @override
  Future<List<ProductModel>> getTopDealGridCategories() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [
      ProductModel(
        id: 'grid_clothing',
        title: 'Clothing',
        brand: 'Multiple',
        rating: 4.5,
        reviewCount: 0,
        price: 0,
        images: [
          'https://images.unsplash.com/photo-1525507119028-ed4c629a60a3?q=80&w=300&auto=format&fit=crop', // Yellow dress
          'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?q=80&w=300&auto=format&fit=crop', // Fashion model
          'https://images.unsplash.com/photo-1483985988355-763728e1935b?q=80&w=300&auto=format&fit=crop', // Shopping bags model
          'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?q=80&w=300&auto=format&fit=crop', // Rack of clothes
        ],
      ),
      ProductModel(
        id: 'grid_shoes',
        title: 'Shoes',
        brand: 'Multiple',
        rating: 4.7,
        reviewCount: 0,
        price: 0,
        images: [
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=300&auto=format&fit=crop', // Red sneaker
          'https://images.unsplash.com/photo-1460353581641-37baddab0fa2?q=80&w=300&auto=format&fit=crop', // Shoes hanger/hanging
          'https://images.unsplash.com/photo-1549298916-b41d501d3772?q=80&w=300&auto=format&fit=crop', // Blue sneaker
          'https://images.unsplash.com/photo-1520639888713-7851133b1ed0?q=80&w=300&auto=format&fit=crop', // Heels/boots
        ],
      ),
      ProductModel(
        id: 'grid_bags',
        title: 'Bags',
        brand: 'Multiple',
        rating: 4.3,
        reviewCount: 0,
        price: 0,
        images: [
          'https://images.unsplash.com/photo-1584917865442-de89df76afd3?q=80&w=300&auto=format&fit=crop', // White bag
          'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?q=80&w=300&auto=format&fit=crop', // Pink bag
          'https://images.unsplash.com/photo-1591561954557-26941169b49e?q=80&w=300&auto=format&fit=crop', // Brown bag
          'https://images.unsplash.com/photo-1547949003-9792a18a2601?q=80&w=300&auto=format&fit=crop', // Replaced bag 4
        ],
      ),
      ProductModel(
        id: 'grid_watches',
        title: 'Watches',
        brand: 'Multiple',
        rating: 4.6,
        reviewCount: 0,
        price: 0,
        images: [
          'https://images.unsplash.com/photo-1524592094714-0f0654e20314?q=80&w=300&auto=format&fit=crop', // Replaced watch 1
          'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?q=80&w=300&auto=format&fit=crop', // Classic watch
          'https://images.unsplash.com/photo-1539874754764-5a96559165b0?q=80&w=300&auto=format&fit=crop', // Black mechanical watch
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=300&auto=format&fit=crop', // Replaced watch 4
        ],
      ),
    ];
  }

  @override
  Future<List<ProductModel>> getTechDeals() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [
      ProductModel(
        id: 'td_infinix',
        title: 'Infinix',
        brand: 'Infinix',
        rating: 4.1,
        reviewCount: 948,
        price: 27999,
        oldPrice: 9999,
        images: [
          'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?q=80&w=400&auto=format&fit=crop'
        ],
        tag: 'Comes in Two Color Variants.',
      ),
      ProductModel(
        id: 'td_jbl',
        title: 'JBL Speaker',
        brand: 'JBL',
        rating: 4.5,
        reviewCount: 3045,
        price: 1499,
        oldPrice: 3999,
        images: [
          'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?q=80&w=400&auto=format&fit=crop'
        ],
        tag: '6 HOURS OF PLAYTIME',
      ),
      ProductModel(
        id: 'td_oppo',
        title: 'OPPO',
        brand: 'OPPO',
        rating: 4.0,
        reviewCount: 739,
        price: 10499,
        oldPrice: 14999,
        images: [
          'https://images.unsplash.com/photo-1598327105666-5b89351aff97?q=80&w=400&auto=format&fit=crop'
        ],
        tag: 'Welcome to Oppo F27',
      ),
    ];
  }

  @override
  Future<List<ProductModel>> getBestSellers() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      ProductModel(
        id: 'bs_skechers',
        title: 'Skechers Men Summits',
        brand: 'Skechers',
        rating: 4.4,
        reviewCount: 9162,
        price: 3198,
        oldPrice: 4799,
        images: [
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=500&auto=format&fit=crop' // Running shoes
        ],
        tag: null,
      ),
      ProductModel(
        id: 'bs_damensch',
        title: "DAMENSCH Men's Polo",
        brand: 'DAMENSCH',
        rating: 4.3,
        reviewCount: 1194,
        price: 1535,
        oldPrice: 1999,
        images: [
          'https://images.unsplash.com/photo-1581655353564-df123a1eb820?q=80&w=500&auto=format&fit=crop' // Polo T-Shirt
        ],
        tag: null,
      ),
      ProductModel(
        id: 'bs_lymio',
        title: 'Lymio Men Shorts',
        brand: 'Lymio',
        rating: 3.9,
        reviewCount: 2336,
        price: 999,
        oldPrice: 1499,
        images: [
          'https://images.unsplash.com/photo-1591195853828-11db59a44f6b?q=80&w=500&auto=format&fit=crop' // Shorts
        ],
        tag: null,
      ),
    ];
  }
}
