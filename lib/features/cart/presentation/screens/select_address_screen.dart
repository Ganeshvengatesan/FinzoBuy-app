import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/route_names.dart';

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({super.key});

  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  int _selectedAddressIndex = 0; // 0 for Home, 1 for Office, 2 for Others

  final List<Map<String, String>> _addresses = [
    {
      'title': 'Home',
      'address': 'No: 21, Greams Lane, Off, Greams Road, Chennai, Tamil Nadu - 600006, India',
    },
    {
      'title': 'Office',
      'address': 'No: 21, Greams Lane, Off, Greams Road, Chennai, Tamil Nadu - 600006, India',
    },
    {
      'title': 'Others',
      'address': 'No: 21, Greams Lane, Off, Greams Road, Chennai, Tamil Nadu - 600006, India',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // EXACT FIGMA SPEC: Top Header Bar (< Your Address with Right Search Icon)
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
                    // Section Header Row: "Select Address" (118px x 18px, Anek Latin 18px 700 Bold #151515) & "+ Add Address" (Group 1000011185: 117px x 34px)
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
                        // Group 1000011185: + Add Address Button (117px x 34px, Radius 6px, #4D43FE)
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

                    // EXACT FIGMA SPEC: Address Cards Stack (Frame 1261154856: Width 400px, Gap 9px)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _addresses.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 9),
                      itemBuilder: (context, index) {
                        final address = _addresses[index];
                        final isSelected = _selectedAddressIndex == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedAddressIndex = index;
                            });
                          },
                          // Rectangle 3463322 / Group 1000011182: Address Item Container Card (400px x 106px, Radius 10px, Border 1px #E5E5E5, Selected: #E1DFFF, Unselected: #FFFFFF)
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

                                // Address Info Column (281px x 74px, Title: Anek Latin 18px 600 SemiBold #151515, 281px x 22px)
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 281,
                                        height: 22,
                                        child: Text(
                                          address['title']!,
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
                                        address['address']!,
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

                                // Vertical 3 dots options menu icon
                                const Icon(
                                  Icons.more_vert,
                                  color: Colors.black87,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // EXACT FIGMA SPEC: Frame 49 Sticky Bottom Action Button (Width 401px, Height 45px, Radius 5px, Solid Royal Blue #4D43FE)
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
        ),
      ),
    );
  }
}
