import '../../domain/repositories/order_repository.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  @override
  Future<List<OrderModel>> getOrders() async {
    // Simulate brief network latency
    await Future.delayed(const Duration(milliseconds: 150));

    const sampleShirtItem = OrderItemModel(
      id: 'item_1',
      title: 'Regular Fit Shirt | Cotton...',
      size: 'Size : 38',
      imageUrl: 'https://images.unsplash.com/photo-1617137984095-74e4e5e3613f?q=80&w=600&auto=format&fit=crop',
      price: 2999,
    );

    return const [
      OrderModel(
        orderId: '#3454545',
        items: [sampleShirtItem, sampleShirtItem],
        status: OrderStatusType.delivering,
        statusMessage: 'Order Delivery On 01 April 2026',
      ),
      OrderModel(
        orderId: '#3454545',
        items: [sampleShirtItem],
        status: OrderStatusType.scheduled,
        statusMessage: 'Order Delivery On Tomorrow 10.00 Am',
      ),
      OrderModel(
        orderId: '#3454545',
        items: [sampleShirtItem],
        status: OrderStatusType.canceled,
        statusMessage: 'Your Order Canceled',
      ),
      OrderModel(
        orderId: '#3454545',
        items: [sampleShirtItem],
        status: OrderStatusType.delivered,
        statusMessage: 'Your Order Delivered',
      ),
    ];
  }
}
