import 'package:flutter/material.dart';

class ShopCategoryModel {
  final String id;
  final String title;
  final Color backgroundColor;
  final String imageUrl;

  const ShopCategoryModel({
    required this.id,
    required this.title,
    required this.backgroundColor,
    required this.imageUrl,
  });
}
