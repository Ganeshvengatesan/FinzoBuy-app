import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../domain/repositories/category_repository.dart';
import '../controllers/category_controller.dart';
import '../widgets/category_card.dart';
import '../widgets/category_header.dart';

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
                      ? const Center(child: CircularProgressIndicator())
                      : _controller.errorMessage != null
                          ? Center(child: Text(_controller.errorMessage!))
                          : SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                top: 2.0, // Reduced even further to bring cards closer to header
                                bottom: 24.0,
                              ),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _controller.categories.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 14.0,
                                  mainAxisSpacing: 16.0,
                                  childAspectRatio: 193 / 199, // 193px width x 199px height per Figma (Group 1000011092)
                                ),
                                itemBuilder: (context, index) {
                                  final category = _controller.categories[index];
                                  return CategoryCard(category: category);
                                },
                              ),
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

