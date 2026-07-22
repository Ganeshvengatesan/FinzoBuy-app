import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/route_names.dart';
import '../../controllers/address_controller.dart';
import '../widgets/address_item_card.dart';

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({super.key});

  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  final AddressController _addressController = AddressController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _addressController,
          builder: (context, _) {
            final addresses = _addressController.addresses;
            final selectedIndex = _addressController.selectedAddressIndex;

            return Column(
              children: [
                // Top Header Bar (< Your Address with Right Search Icon)
                Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  color: Colors.white,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (context.canPop()) {
                            context.pop();
                          }
                        },
                        child: const SizedBox(
                          width: 24,
                          height: 24,
                          child: Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Your Address',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          fontFamily: 'AnekLatin',
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(
                        width: 30,
                        height: 30,
                        child: Icon(Icons.search, size: 24, color: Colors.black),
                      ),
                    ],
                  ),
                ),

                // Main Body Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section Header Row: "Select Address" & "+ Add Address" Blue Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 118,
                              height: 18,
                              child: Text(
                                'Select Address',
                                style: TextStyle(
                                  fontFamily: 'AnekLatin',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF151515),
                                  height: 1.0,
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 117,
                              height: 34,
                              child: ElevatedButton(
                                onPressed: () {
                                  context.push(RouteNames.addAddressPath);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.menPrimaryBlue,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.add_circle, size: 16, color: Colors.white),
                                    SizedBox(width: 4),
                                    Text(
                                      'Add Address',
                                      style: TextStyle(
                                        fontFamily: 'AnekLatin',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Address Cards List
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: addresses.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 9),
                          itemBuilder: (context, index) {
                            final address = addresses[index];
                            final isSelected = selectedIndex == index;

                            return AddressItemCard(
                              title: address.title,
                              address: address.fullAddress,
                              isSelected: isSelected,
                              onTap: () {
                                _addressController.selectAddress(index);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Sticky Bottom Action Button ("Select Address")
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 10,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.menPrimaryBlue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const SizedBox(
                        width: 113,
                        height: 20,
                        child: Center(
                          child: Text(
                            'Select Address',
                            style: TextStyle(
                              fontFamily: 'AnekLatin',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
