import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fashion_app/features/category/presentation/screens/shop_by_category_screen.dart';
import 'package:fashion_app/features/category/data/repositories/category_repository_impl.dart';

void main() {
  testWidgets('ShopByCategoryScreen renders all categories with local image assets', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ShopByCategoryScreen(
          repository: CategoryRepositoryImpl(),
        ),
      ),
    );

    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text("Women Fashion's"), findsOneWidget);
    expect(find.text("Men Fashion's"), findsOneWidget);
    expect(find.text("Kids Fashion's"), findsOneWidget);

    // Scroll grid down to view remaining items
    await tester.drag(find.byType(GridView), const Offset(0, -300));
    await tester.pumpAndSettle();

    expect(find.text('Mobile'), findsOneWidget);
  });
}
