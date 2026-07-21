class ApiEndpoints {
  ApiEndpoints._();

  // Base URL
  static const String baseUrl = 'https://dummyjson.com';

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);

  // Endpoints
  static const String getProducts = '/products';
  static const String getSingleProduct = '/products/'; // Append product ID
  static const String searchProducts = '/products/search';
  static const String getCategories = '/products/categories';
  static const String authLogin = '/auth/login';
}
