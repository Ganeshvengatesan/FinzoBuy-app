enum OrderStatusType {
  delivering,
  scheduled,
  canceled,
  delivered,
}

class OrderItemModel {
  final String id;
  final String title;
  final String size;
  final String imageUrl;
  final double price;

  const OrderItemModel({
    required this.id,
    required this.title,
    required this.size,
    required this.imageUrl,
    required this.price,
  });
}

class OrderModel {
  final String orderId;
  final List<OrderItemModel> items;
  final OrderStatusType status;
  final String statusMessage;
  final String? deliveryDate;

  const OrderModel({
    required this.orderId,
    required this.items,
    required this.status,
    required this.statusMessage,
    this.deliveryDate,
  });
}
