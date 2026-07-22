import 'package:flutter/foundation.dart';
import '../../data/models/order_model.dart';
import '../../domain/repositories/order_repository.dart';

class OrderController extends ChangeNotifier {
  final OrderRepository _repository;

  OrderController(this._repository);

  List<OrderModel> _orders = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<OrderModel> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadOrders() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _orders = await _repository.getOrders();
    } catch (e) {
      _errorMessage = 'Failed to load orders. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
