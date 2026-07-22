import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isDefaultAddress = false;
  String? _selectedState;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  final List<String> _states = [
    'Tamil Nadu',
    'Kerala',
    'Karnataka',
    'Andhra Pradesh',
    'Maharashtra',
    'Delhi',
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _cityController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

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

            // Scrollable Form Area (Frame 21: Width 400px, Gap 12px)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Full Name Field (Label: 62px x 23px, Field: 400px x 50px)
                      _buildLabel('Full Name', 62),
                      const SizedBox(height: 6),
                      _buildTextField(
                        controller: _fullNameController,
                        hintText: 'Enter Full Name',
                      ),
                      const SizedBox(height: 12),

                      // Phone Number Field
                      _buildLabel('Phone Number', 100),
                      const SizedBox(height: 6),
                      _buildTextField(
                        controller: _phoneController,
                        hintText: 'Enter Full Name',
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 12),

                      // Address Line 1 Field
                      _buildLabel('Address Line 1', 100),
                      const SizedBox(height: 6),
                      _buildTextField(
                        controller: _addressLine1Controller,
                        hintText: 'Address Line 2',
                      ),
                      const SizedBox(height: 12),

                      // Address Line 2 Field
                      _buildLabel('Address Line 2', 100),
                      const SizedBox(height: 6),
                      _buildTextField(
                        controller: _addressLine2Controller,
                        hintText: 'Address Line 2',
                      ),
                      const SizedBox(height: 12),

                      // City Field
                      _buildLabel('City', 50),
                      const SizedBox(height: 6),
                      _buildTextField(
                        controller: _cityController,
                        hintText: 'Enter City',
                      ),
                      const SizedBox(height: 12),

                      // State Dropdown (189px x 50px) & Zip Code (189px x 50px) Side-by-Side Row
                      Row(
                        children: [
                          // State Dropdown (189px width)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('State', 60),
                                const SizedBox(height: 6),
                                Container(
                                  height: 50,
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.03),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _selectedState,
                                      hint: const Text(
                                        'Select State',
                                        style: TextStyle(
                                          fontFamily: 'AnekLatin',
                                          fontSize: 14,
                                          color: Colors.black38,
                                        ),
                                      ),
                                      isExpanded: true,
                                      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                                      items: _states.map((String state) {
                                        return DropdownMenuItem<String>(
                                          value: state,
                                          child: Text(
                                            state,
                                            style: const TextStyle(
                                              fontFamily: 'AnekLatin',
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedState = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 12),

                          // Zip Code Field (189px width)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel('Zip Code', 70),
                                const SizedBox(height: 6),
                                _buildTextField(
                                  controller: _zipCodeController,
                                  hintText: 'Zip Code',
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Checkbox Row (Rectangle 3463287: 17px x 17px, Radius 4px, Border 1px 30% #151515; Text: 206px x 23px #221F1F)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isDefaultAddress = !_isDefaultAddress;
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 17,
                              height: 17,
                              decoration: BoxDecoration(
                                color: _isDefaultAddress ? AppColors.menPrimaryBlue : Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: _isDefaultAddress ? AppColors.menPrimaryBlue : const Color(0xFF151515).withValues(alpha: 0.3),
                                  width: 1.0,
                                ),
                              ),
                              child: _isDefaultAddress
                                  ? const Icon(Icons.check, size: 13, color: Colors.white)
                                  : null,
                            ),
                            const SizedBox(width: 8),
                            const SizedBox(
                              width: 206,
                              height: 23,
                              child: Text(
                                'Make this my default address',
                                style: TextStyle(
                                  fontFamily: 'AnekLatin',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF221F1F),
                                  height: 1.53,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Frame 49: Submit Solid Royal Blue Button (401px x 45px, Radius 5px, Background #4D43FE)
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Address Saved Successfully!'),
                                backgroundColor: AppColors.menPrimaryBlue,
                              ),
                            );
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
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              fontFamily: 'AnekLatin',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Frame 23: Divider Row (Hug 390px x 23px, Gap 14px)
                      Row(
                        children: const [
                          Expanded(child: Divider(color: Color(0xFFE5E5E5))),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: Text(
                              'Or',
                              style: TextStyle(
                                fontFamily: 'AnekLatin',
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: Color(0xFFE5E5E5))),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // "Use Current Location" Button (388px x 45px, Radius 4px, Background #ECECEC, Border 1px 20% #151515)
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Fetching Current Location...'),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFECECEC),
                            foregroundColor: AppColors.menPrimaryBlue,
                            elevation: 0,
                            side: BorderSide(
                              color: const Color(0xFF151515).withValues(alpha: 0.2),
                              width: 1.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: const Text(
                            'Use Current Location',
                            style: TextStyle(
                              fontFamily: 'AnekLatin',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.menPrimaryBlue,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Label Helper Widget (Anek Latin 15px 400 Regular #151515, Height 23px)
  Widget _buildLabel(String text, double width) {
    return SizedBox(
      height: 23,
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'AnekLatin',
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Color(0xFF151515),
          height: 1.0,
        ),
      ),
    );
  }

  // Text Field Helper Widget (Rectangle 3463273: Height 50px, Radius 10px, Background #FFFFFF)
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontFamily: 'AnekLatin',
          fontSize: 14,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'AnekLatin',
            fontSize: 14,
            color: Colors.black38,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        ),
      ),
    );
  }
}
