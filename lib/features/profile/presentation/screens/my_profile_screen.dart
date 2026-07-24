import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController(text: 'Cameron');
  final TextEditingController _lastNameController = TextEditingController(text: 'Williamson');
  final TextEditingController _phoneController = TextEditingController(text: '+91 98765 43210');
  final TextEditingController _emailController = TextEditingController(text: 'cameron.williamson@example.com');
  final TextEditingController _dobController = TextEditingController(text: '14/08/1995');

  String _selectedGender = 'Male';

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _resetForm() {
    setState(() {
      _firstNameController.text = 'Cameron';
      _lastNameController.text = 'Williamson';
      _phoneController.text = '+91 98765 43210';
      _emailController.text = 'cameron.williamson@example.com';
      _dobController.text = '14/08/1995';
      _selectedGender = 'Male';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Form Reset to Default Values'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _updateProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile Updated Successfully!'),
        backgroundColor: AppColors.menPrimaryBlue,
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1995, 8, 14),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.menPrimaryBlue,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // EXACT FIGMA SPEC: Top Header Container (Rectangle 1632: Height 148px, Background #F4F3FF, Radius 30px, Border 1px #FFFFFF)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F3FF),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
                border: Border.all(
                  color: Colors.white,
                  width: 1.0,
                ),
              ),
              child: Column(
                children: [
                  // Top Status Bar (09:30 PM & Icons)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '09:30 PM',
                        style: TextStyle(
                          fontFamily: 'AnekLatin',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.bluetooth, size: 16, color: Colors.black),
                          SizedBox(width: 6),
                          Icon(Icons.wifi, size: 16, color: Colors.black),
                          SizedBox(width: 6),
                          Icon(Icons.signal_cellular_alt, size: 16, color: Colors.black),
                          SizedBox(width: 6),
                          Icon(Icons.battery_full, size: 16, color: Colors.black),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Navigation Row: < My Profile & Search Icon
                  Row(
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
                        'My Profile',
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
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 12),

                    // EXACT FIGMA SPEC: Ellipse 41 User Avatar Container (Width: 135px, Height: 135px, Border: 1px #D2D2D2)
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 135,
                            height: 135,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFF1F1F1),
                              border: Border.all(
                                color: const Color(0xFFD2D2D2),
                                width: 1.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(67.5),
                              child: Image.asset(
                                'assets/images/get_started_1.png',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(
                                  Icons.person,
                                  size: 70,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),

                          // Edit Pencil Icon Badge Overlay at Bottom Right
                          Positioned(
                            bottom: 2,
                            right: 2,
                            child: GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Change Profile Picture')),
                                );
                              },
                              child: Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(color: const Color(0xFFE5E5E5), width: 1.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.1),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.edit_outlined,
                                    size: 18,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // EXACT FIGMA SPEC: Frame 21 Profile Form Fields Container (Width: 400px, Gap: 12px)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // First Name Field
                        _buildFieldLabel('First Name'),
                        const SizedBox(height: 6),
                        _buildInputField(
                          controller: _firstNameController,
                          hintText: 'Enter Full Name',
                        ),

                        const SizedBox(height: 12),

                        // Last Name Field
                        _buildFieldLabel('Last Name'),
                        const SizedBox(height: 6),
                        _buildInputField(
                          controller: _lastNameController,
                          hintText: 'Enter Full Name',
                        ),

                        const SizedBox(height: 12),

                        // Phone Number Field
                        _buildFieldLabel('Phone Number'),
                        const SizedBox(height: 6),
                        _buildInputField(
                          controller: _phoneController,
                          hintText: 'Enter Full Name',
                          keyboardType: TextInputType.phone,
                        ),

                        const SizedBox(height: 12),

                        // Email Address Field
                        _buildFieldLabel('Email Address'),
                        const SizedBox(height: 6),
                        _buildInputField(
                          controller: _emailController,
                          hintText: 'Enter City',
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 12),

                        // Date of Birth Field with Calendar Icon
                        _buildFieldLabel('Date of Birth'),
                        const SizedBox(height: 6),
                        _buildInputField(
                          controller: _dobController,
                          hintText: 'DD/MM/YYYY',
                          readOnly: true,
                          onTap: _selectDate,
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.calendar_month_outlined,
                              size: 22,
                              color: Color(0xFFEBA928),
                            ),
                            onPressed: _selectDate,
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Gender Field
                        _buildFieldLabel('Gender'),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            _buildRadioOption('Male'),
                            const SizedBox(width: 16),
                            _buildRadioOption('Female'),
                            const SizedBox(width: 16),
                            _buildRadioOption('Others'),
                          ],
                        ),

                        const SizedBox(height: 28),

                        // Action Buttons Row: Reset (186x45px, border #C5C5C5) & Update (186x45px, bg #4D43FE)
                        Row(
                          children: [
                            // Reset Button
                            Expanded(
                              child: SizedBox(
                                height: 45,
                                child: OutlinedButton(
                                  onPressed: _resetForm,
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side: const BorderSide(color: Color(0xFFC5C5C5), width: 1.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: const Text(
                                    'Reset',
                                    style: TextStyle(
                                      fontFamily: 'AnekLatin',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.menPrimaryBlue,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 14),

                            // Update Button
                            Expanded(
                              child: SizedBox(
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: _updateProfile,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.menPrimaryBlue,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: const Text(
                                    'Update',
                                    style: TextStyle(
                                      fontFamily: 'AnekLatin',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontFamily: 'AnekLatin',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF151515),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    VoidCallback? onTap,
    Widget? suffixIcon,
  }) {
    // EXACT FIGMA SPEC: Rectangle 3463273 (Width: 400px, Height: 50px, Radius: 5px, Background: #FFFFFF)
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color(0xFFE8E8E8),
          width: 1.0,
        ),
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboardType,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(
          fontFamily: 'AnekLatin',
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Color(0xFF151515),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'AnekLatin',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFFB0B0B0),
          ),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  Widget _buildRadioOption(String value) {
    final isSelected = _selectedGender == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = value;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: isSelected ? AppColors.menPrimaryBlue : const Color(0xFFCCCCCC),
                width: isSelected ? 6.0 : 1.5,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'AnekLatin',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF151515),
            ),
          ),
        ],
      ),
    );
  }
}
