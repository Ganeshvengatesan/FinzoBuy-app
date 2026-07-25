import 'package:flutter/material.dart';
import '../../data/models/order_model.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onTap;
  final VoidCallback? onBuyAgainTap;

  const OrderCard({
    super.key,
    required this.order,
    this.onTap,
    this.onBuyAgainTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: const Color(0xFFEFEFEF),
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order ID & Circular Navigation Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order ID ${order.orderId}',
                style: const TextStyle(
                  fontFamily: 'AnekLatin',
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                  color: Color(0xFF151515),
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4C4DDC), // Blue action button per Figma
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),

          // List of Items inside Order
          ...order.items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Item Thumbnail
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: item.imageUrl.startsWith('http')
                          ? Image.network(
                              item.imageUrl,
                              width: 64.0,
                              height: 64.0,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 64.0,
                                height: 64.0,
                                color: Colors.grey.shade200,
                                child: const Icon(Icons.image_not_supported, color: Colors.grey),
                              ),
                            )
                          : Image.asset(
                              item.imageUrl,
                              width: 64.0,
                              height: 64.0,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 64.0,
                                height: 64.0,
                                color: Colors.grey.shade200,
                                child: const Icon(Icons.image_not_supported, color: Colors.grey),
                              ),
                            ),
                    ),
                    const SizedBox(width: 14.0),

                    // Item Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'AnekLatin',
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                              color: Color(0xFF151515),
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            item.size,
                            style: const TextStyle(
                              fontFamily: 'AnekLatin',
                              fontWeight: FontWeight.w400,
                              fontSize: 13.0,
                              color: Color(0xFF888888),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),

          const SizedBox(height: 4.0),

          // Status Banner / Action Row
          _buildStatusBanner(),
        ],
      ),
    );
  }

  Widget _buildStatusBanner() {
    switch (order.status) {
      case OrderStatusType.delivering:
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF6D8), // Soft yellow banner per Figma
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            order.statusMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'AnekLatin',
              fontWeight: FontWeight.w600,
              fontSize: 13.5,
              color: Color(0xFF151515),
            ),
          ),
        );

      case OrderStatusType.scheduled:
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFE2FBE3), // Soft green banner per Figma
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            order.statusMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'AnekLatin',
              fontWeight: FontWeight.w600,
              fontSize: 13.5,
              color: Color(0xFF1E7E34),
            ),
          ),
        );

      case OrderStatusType.canceled:
        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onBuyAgainTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEDFF), // Light purple button per Figma
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Text(
                    'Buy Again',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'AnekLatin',
                      fontWeight: FontWeight.w600,
                      fontSize: 13.5,
                      color: Color(0xFF5E49FF),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE4E4), // Light pink/red banner per Figma
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  order.statusMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'AnekLatin',
                    fontWeight: FontWeight.w600,
                    fontSize: 13.5,
                    color: Color(0xFFD32F2F),
                  ),
                ),
              ),
            ),
          ],
        );

      case OrderStatusType.delivered:
        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onBuyAgainTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEDFF), // Light purple button per Figma
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Text(
                    'Buy Again',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'AnekLatin',
                      fontWeight: FontWeight.w600,
                      fontSize: 13.5,
                      color: Color(0xFF5E49FF),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2FBE3), // Light green banner per Figma
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  order.statusMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'AnekLatin',
                    fontWeight: FontWeight.w600,
                    fontSize: 13.5,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ),
            ),
          ],
        );
    }
  }
}
