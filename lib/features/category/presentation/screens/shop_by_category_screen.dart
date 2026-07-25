import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_names.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../domain/repositories/category_repository.dart';
import '../controllers/category_controller.dart';
import '../widgets/category_card.dart';
import '../widgets/category_header.dart';
import '../widgets/category_shimmer_loading.dart';

class ShopByCategoryScreen extends StatefulWidget {
  final bool isEmbedded;
  final VoidCallback? onBackTap;
  final CategoryRepository? repository;

  const ShopByCategoryScreen({
    super.key,
    this.isEmbedded = false,
    this.onBackTap,
    this.repository,
  });

  @override
  State<ShopByCategoryScreen> createState() => _ShopByCategoryScreenState();
}

class _ShopByCategoryScreenState extends State<ShopByCategoryScreen> {
  late final CategoryController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CategoryController(widget.repository ?? CategoryRepositoryImpl());
    _controller.loadCategories();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        final body = AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          child: Container(
            color: const Color(0xFFF3F5F7), // Figma background color #F3F5F7
            child: Column(
              children: [
                // Custom Figma Header Card (extends into status bar area)
                CategoryHeader(
                  onBackTap: widget.onBackTap,
                ),
                
                // Main Content
                Expanded(
                  child: _controller.isLoading
                      ? const CategoryShimmerLoading()
                      : _controller.errorMessage != null
                          ? Center(child: Text(_controller.errorMessage!))
                          : GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                top: 16.0,
                                bottom: 24.0,
                              ),
                              itemCount: _controller.categories.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 14.0,
                                mainAxisSpacing: 16.0,
                                childAspectRatio: 193 / 199,
                              ),
                              itemBuilder: (context, index) {
                                final category = _controller.categories[index];
                                return CategoryCard(
                                  category: category,
                                  onTap: () {
                                    context.pushNamed(RouteNames.menFashion);
                                  },
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
        );

        if (widget.isEmbedded) {
          return body;
        }

        return Scaffold(
          body: body,
        );
      },
    );
  }
}
