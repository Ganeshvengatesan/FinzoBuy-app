import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class AddressItemCard extends StatelessWidget {
  final String title;
  final String address;
  final bool isSelected;
  final VoidCallback onTap;

  const AddressItemCard({
    super.key,
    required this.title,
    required this.address,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 400,
        height: 106,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE1DFFF) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFE5E5E5),
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Radio Selection Indicator
            Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.menPrimaryBlue : Colors.grey.shade400,
                  width: isSelected ? 6.0 : 1.5,
                ),
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),

            // Address Info Column (281px x 74px)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 281,
                    height: 22,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'AnekLatin',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF151515),
                        height: 1.22,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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

            const SizedBox(width: 8),

            // Options menu icon
            const Icon(
              Icons.more_vert,
              color: Colors.black87,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
