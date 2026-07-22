import 'package:flutter/material.dart';

class DeliveryAddressHeaderCard extends StatelessWidget {
  final String name;
  final String address;
  final VoidCallback onChangeAddress;

  const DeliveryAddressHeaderCard({
    super.key,
    required this.name,
    required this.address,
    required this.onChangeAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 401,
      padding: const EdgeInsets.all(12),
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
            'Delivery Address',
            style: TextStyle(
              fontFamily: 'AnekLatin',
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),

          // Address Lavender Box (376px x 96px, #E8E7FF)
          Container(
            width: 376,
            height: 96,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE8E7FF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
                width: 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontFamily: 'AnekLatin',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF151515),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  address,
                  style: const TextStyle(
                    fontFamily: 'AnekLatin',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF151515),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Change Delivery Address Button (212px x 38px)
          Container(
            width: 212,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: const Color(0xFFC5C5C5),
                width: 1.0,
              ),
            ),
            child: InkWell(
              onTap: onChangeAddress,
              borderRadius: BorderRadius.circular(5),
              child: const Center(
                child: Text(
                  'Change Delivery Address',
                  style: TextStyle(
                    fontFamily: 'AnekLatin',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF151515),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
