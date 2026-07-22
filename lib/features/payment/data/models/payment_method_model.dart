import 'package:flutter/material.dart';

class PaymentMethodModel {
  final int index;
  final String title;
  final IconData icon;
  final bool isExpanded;

  PaymentMethodModel({
    required this.index,
    required this.title,
    required this.icon,
    this.isExpanded = false,
  });
}
