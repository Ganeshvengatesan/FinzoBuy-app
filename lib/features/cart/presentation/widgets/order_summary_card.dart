import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class OrderSummaryCard extends StatelessWidget {
  final String mrp;
  final String platformFee;
  final String discounts;
  final String couponDiscount;
  final String total;

  const OrderSummaryCard({
    super.key,
    this.mrp = '₹3,999',
    this.platformFee = '20',
    this.discounts = '-2600',
    this.couponDiscount = '-20',
    this.total = '₹699',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 401,
      height: 237,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(
              fontFamily: 'AnekLatin',
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),

          _buildSummaryRow(label: 'MRP', value: mrp),
          const SizedBox(height: 8),
          _buildSummaryRow(label: 'Platfrom Fee', value: platformFee),
          const SizedBox(height: 8),
          _buildSummaryRow(label: 'Discounts', value: discounts, isGreen: true),
          const SizedBox(height: 8),
          _buildSummaryRow(label: 'Coupon Discount', value: couponDiscount, isGreen: true),

          const SizedBox(height: 12),

          // Total Pill Row Container (376px x 41px, Radius 10px, Border 1px #FFFFFF, #E8E7FF Soft Lavender)
          Container(
            width: 376,
            height: 41,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFE8E7FF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
                width: 1.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontFamily: 'AnekLatin',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 36,
                  height: 16,
                  child: Text(
                    total,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontFamily: 'AnekLatin',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.menPrimaryBlue,
                      height: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow({required String label, required String value, bool isGreen = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 127,
          height: 20,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'AnekLatin',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF151515),
              height: 1.44,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'AnekLatin',
            fontSize: isGreen ? 16 : 15,
            fontWeight: isGreen ? FontWeight.w500 : FontWeight.w600,
            color: isGreen ? const Color(0xFF008B15) : Colors.black,
            height: 1.0,
          ),
        ),
      ],
    );
  }
}
