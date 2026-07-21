import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fashion_app/features/home/domain/repositories/product_repository.dart';
import 'package:fashion_app/features/home/data/models/category_model.dart';
import 'package:fashion_app/features/home/data/models/product_model.dart';
import 'package:fashion_app/features/home/presentation/screens/home_screen.dart';

class MockProductRepository implements ProductRepository {
  @override
  Future<List<CategoryModel>> getCategories() async {
    return [
      CategoryModel(id: 'cat_for_you', name: 'For You', iconPath: 'assets/icons/ic_for_u.svg'),
      CategoryModel(id: 'cat_fashion', name: 'Fashion', iconPath: 'assets/icons/ic_fashion.svg'),
    ];
  }

  @override
  Future<List<ProductModel>> getRecentlyViewed() async {
    return [];
  }

  @override
  Future<List<ProductModel>> getTopDealGridCategories() async {
    return [];
  }

  @override
  Future<List<ProductModel>> getTechDeals() async {
    return [];
  }

  @override
  Future<List<ProductModel>> getBestSellers() async {
    return [];
  }
}

void main() {
  testWidgets('App landing screen smoke test', (WidgetTester tester) async {
    // Build our app under test with the mock repository to prevent NetworkImage HTTP requests.
    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(repository: MockProductRepository()),
      ),
    );
    await tester.pump(); // Start fetching
    await tester.pumpAndSettle(); // Settle transition and loading animation

    // Verify location text exists
    expect(find.text('Madurai-625006'), findsOneWidget);
    expect(find.text('Deliver to'), findsOneWidget);
    
    // Verify search bar hint exists
    expect(find.text('Search For Product'), findsOneWidget);
    
    // Verify category labels are rendered on screen
    expect(find.text('For You'), findsOneWidget);
    expect(find.text('Fashion'), findsOneWidget);
  });
}
