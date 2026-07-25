import '../../domain/repositories/order_repository.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  @override
  Future<List<OrderModel>> getOrders() async {
    await Future.delayed(const Duration(milliseconds: 150));

    const item1 = OrderItemModel(
      id: 'item_1',
      title: 'Men\'s Dark Green Shirt | Cotton Blend',
      size: 'Size : 38',
      imageUrl: 'assets/images/men_shirt_dark_green.png',
      price: 2999,
    );

    const item2 = OrderItemModel(
      id: 'item_2',
      title: 'Men\'s Cream Casual Wear',
      size: 'Size : 40',
      imageUrl: 'assets/images/men_banner.png',
      price: 3499,
    );

    const item3 = OrderItemModel(
      id: 'item_3',
      title: 'Men\'s Denim Blue Shirt',
      size: 'Size : 39',
      imageUrl: 'assets/images/men_shirt_dark_blue.png',
      price: 1999,
    );

    const item4 = OrderItemModel(
      id: 'item_4',
      title: 'Urban Streetwear Outerwear',
      size: 'Size : XL',
      imageUrl: 'assets/images/get_started_1.png',
      price: 4500,
    );

    const item5 = OrderItemModel(
      id: 'item_5',
      title: 'Formal Luxury Tailored Blazer',
      size: 'Size : L',
      imageUrl: 'assets/images/get_started_2.png',
      price: 5999,
    );

    return const [
      OrderModel(
        orderId: '#3454545',
        items: [item1, item2],
        status: OrderStatusType.delivering,
        statusMessage: 'Order Delivery On 01 April 2026',
      ),
      OrderModel(
        orderId: '#3454546',
        items: [item3],
        status: OrderStatusType.scheduled,
        statusMessage: 'Order Delivery On Tomorrow 10.00 Am',
      ),
      OrderModel(
        orderId: '#3454547',
        items: [item4],
        status: OrderStatusType.canceled,
        statusMessage: 'Your Order Canceled',
      ),
      OrderModel(
        orderId: '#3454548',
        items: [item5],
        status: OrderStatusType.delivered,
        statusMessage: 'Your Order Delivered',
      ),
    ];
  }
}
