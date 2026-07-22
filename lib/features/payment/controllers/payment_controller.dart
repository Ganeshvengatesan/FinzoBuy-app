import 'package:flutter/material.dart';

class PaymentController extends ChangeNotifier {
  static final PaymentController _instance = PaymentController._internal();
  factory PaymentController() => _instance;
  PaymentController._internal();

  int _selectedMethodIndex = 1; // 0: UPI, 1: Credit Card, 2: Net Banking, 3: COD

  int get selectedMethodIndex => _selectedMethodIndex;

  void selectPaymentMethod(int index) {
    _selectedMethodIndex = index;
    notifyListeners();
  }
}
