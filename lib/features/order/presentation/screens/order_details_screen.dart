import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/models/order_model.dart';
import '../widgets/order_header.dart';
import 'track_order_screen.dart';
import '../../../review/presentation/screens/write_review_screen.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderModel? order;
  final VoidCallback? onBackTap;
  final VoidCallback? onTrackOrderTap;

  const OrderDetailsScreen({
    super.key,
    this.order,
    this.onBackTap,
    this.onTrackOrderTap,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late final OrderModel _order;

  @override
  void initState() {
    super.initState();
    // Default sample order matching Figma design if none passed
    const sampleShirtItem = OrderItemModel(
      id: 'item_1',
      title: 'Regular Fit Shirt | Cotton...',
      size: 'Size : 38',
      imageUrl: 'https://images.unsplash.com/photo-1617137984095-74e4e5e3613f?q=80&w=600&auto=format&fit=crop',
      price: 2999,
    );

    _order = widget.order ??
        const OrderModel(
          orderId: '#3454545',
          items: [sampleShirtItem, sampleShirtItem],
          status: OrderStatusType.delivering,
          statusMessage: 'Order Delivery On 01 April 2026',
        );
  }

  @override
  Widget build(BuildContext context) {
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
            // Custom Figma Header Card
            OrderHeader(
              title: 'Order Details',
              onBackTap: widget.onBackTap,
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                  bottom: 24.0,
                ),
                child: Column(
                  children: [
                    // 1. Order Items Card
                    _buildOrderItemsCard(),
                    const SizedBox(height: 16.0),

                    // 2. Delivery Address Card
                    _buildDeliveryAddressCard(),
                    const SizedBox(height: 16.0),

                    // 3. Order Summary Card
                    _buildOrderSummaryCard(),
                    const SizedBox(height: 20.0),

                    // 4. Action Button (Track Your Order / Write a Review)
                    _buildActionButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      body: body,
    );
  }

  // Card 1: Order Items Card
  Widget _buildOrderItemsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0), // 10px per Figma
        border: Border.all(
          color: Colors.white, // 1px #FFFFFF per Figma
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order ID & Circular Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order ID ${_order.orderId}',
                style: const TextStyle(
                  fontFamily: 'AnekLatin',
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                  color: Color(0xFF151515),
                ),
              ),
              Container(
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
            ],
          ),
          const SizedBox(height: 14.0),

          // Items List
          ..._order.items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14.0),
                    child: Image.network(
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
            ),
          ),
          const SizedBox(height: 4.0),

          // Status Banner / Action Row
          _buildStatusBanner(),
        ],
      ),
    );
  }

  Widget _buildStatusBanner() {
    switch (_order.status) {
      case OrderStatusType.delivering:
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFE8E7FF), // Exact Figma fill #E8E7FF
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.white, width: 1.0),
          ),
          child: Text(
            _order.statusMessage,
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
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFE2FBE3), // Soft green banner per Figma
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.white, width: 1.0),
          ),
          child: Text(
            _order.statusMessage,
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
            const SizedBox(width: 12.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE4E4), // Light pink/red banner per Figma
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  _order.statusMessage,
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
            const SizedBox(width: 12.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2FBE3), // Light green banner per Figma
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  _order.statusMessage,
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

  // Card 2: Delivery Address Card
  Widget _buildDeliveryAddressCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0), // 10px per Figma
        border: Border.all(
          color: Colors.white, // 1px #FFFFFF per Figma
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Delivery Address',
            style: TextStyle(
              fontFamily: 'AnekLatin',
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Color(0xFF151515),
            ),
          ),
          const SizedBox(height: 12.0),
          // Inner Address Box (Rectangle 3463320)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: const Color(0xFFE8E7FF), // Exact Figma fill #E8E7FF
              borderRadius: BorderRadius.circular(10.0), // 10px per Figma
              border: Border.all(
                color: Colors.white,
                width: 1.0,
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Deo',
                  style: TextStyle(
                    fontFamily: 'AnekLatin',
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0,
                    color: Color(0xFF151515),
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  'No: 4, White avenue Green park Extension, Madurai, Tamil Nadu - 625018, India',
                  style: TextStyle(
                    fontFamily: 'AnekLatin',
                    fontWeight: FontWeight.w400, // 400 Regular per Figma
                    fontSize: 15.0, // 15px per Figma
                    height: 1.46, // Line height 22px / 15px per Figma
                    color: Color(0xFF221F1F), // #221F1F per Figma
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Card 3: Order Summary Card
  Widget _buildOrderSummaryCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0), // 10px per Figma
        border: Border.all(
          color: Colors.white, // 1px #FFFFFF per Figma
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(
              fontFamily: 'AnekLatin',
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              color: Color(0xFF151515),
            ),
          ),
          const SizedBox(height: 14.0),

          // MRP Row
          _buildSummaryRow(label: 'MRP', value: '₹3,999', isBold: true),
          const SizedBox(height: 10.0),

          // Platform Fee Row
          _buildSummaryRow(label: 'Platfrom Fee', value: '20'),
          const SizedBox(height: 10.0),

          // Discounts Row
          _buildSummaryRow(
            label: 'Discounts',
            value: '-2600',
            valueColor: const Color(0xFF1E7E34),
          ),
          const SizedBox(height: 10.0),

          // Coupon Discount Row
          _buildSummaryRow(
            label: 'Coupon Discount',
            value: '-20',
            valueColor: const Color(0xFF1E7E34),
          ),
          const SizedBox(height: 14.0),

          // Total Highlight Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFE8E7FF), // Exact Figma fill #E8E7FF
              borderRadius: BorderRadius.circular(10.0), // 10px per Figma
              border: Border.all(
                color: Colors.white,
                width: 1.0,
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontFamily: 'AnekLatin',
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0,
                    color: Color(0xFF151515),
                  ),
                ),
                Text(
                  '₹699',
                  style: TextStyle(
                    fontFamily: 'AnekLatin',
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0,
                    color: Color(0xFF4C4DDC), // Blue/Purple highlight per Figma
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow({
    required String label,
    required String value,
    Color? valueColor,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'AnekLatin',
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
            color: Color(0xFF666666),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'AnekLatin',
            fontWeight: isBold || valueColor != null ? FontWeight.w700 : FontWeight.w500,
            fontSize: 14.0,
            color: valueColor ?? const Color(0xFF151515),
          ),
        ),
      ],
    );
  }

  // 4. Action Button (Track Your Order / Write a Review)
  Widget _buildActionButton() {
    final bool isDeliveredOrCanceled =
        _order.status == OrderStatusType.delivered || _order.status == OrderStatusType.canceled;
    final String buttonText = isDeliveredOrCanceled ? 'Write a Review' : 'Track Your Order';

    return SizedBox(
      width: double.infinity,
      height: 52.0,
      child: ElevatedButton(
        onPressed: () {
          if (isDeliveredOrCanceled) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WriteReviewScreen(
                  orderId: _order.orderId,
                  productTitle: _order.items.isNotEmpty ? _order.items.first.title : 'Regular Fit Shirt | Cotton...',
                  productImageUrl: _order.items.isNotEmpty ? _order.items.first.imageUrl : '',
                ),
              ),
            );
          } else {
            if (widget.onTrackOrderTap != null) {
              widget.onTrackOrderTap!();
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrackOrderScreen(
                    orderId: _order.orderId,
                  ),
                ),
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4C4DDC), // Figma blue button #4C4DDC
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontFamily: 'AnekLatin',
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
