import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/route_names.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoadingGoogle = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onContinueWithGoogle() {
    setState(() {
      _isLoadingGoogle = true;
    });
    // Simulate brief login check & navigate directly to Home Screen
    Future.delayed(const Duration(milliseconds: 600), () async {
      await AuthService.setLoggedIn(true);
      if (mounted) {
        setState(() {
          _isLoadingGoogle = false;
        });
        context.go(RouteNames.homePath);
      }
    });
  }

  void _onContinueAsGuest() async {
    await AuthService.setLoggedIn(true);
    if (mounted) {
      context.go(RouteNames.homePath);
    }
  }

  void _onSendOtp() async {
    final phone = _phoneController.text.trim();
    if (phone.length < 10) {
      return;
    }
    await AuthService.setLoggedIn(true);
    if (mounted) {
      context.go(RouteNames.homePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Text(
                'Welcome Back 👋',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontFamily: 'AnekLatin',
                  fontWeight: FontWeight.w800,
                  fontSize: 28.0,
                  color: const Color(0xFF1E1E1E),
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Sign in to explore your personalized fashion recommendations, order tracking & exclusive member discounts.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontFamily: 'AnekLatin',
                  color: Colors.black54,
                  fontSize: 14.5,
                  height: 1.45,
                ),
              ),

              const SizedBox(height: 32),

              // 2. Continue with Google Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: _isLoadingGoogle ? null : _onContinueWithGoogle,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFE0E0E0), width: 1.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoadingGoogle
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.2,
                            color: AppColors.lightPrimary,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/ic_google.svg',
                              width: 22,
                              height: 22,
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Continue with Google',
                              style: TextStyle(
                                fontFamily: 'AnekLatin',
                                fontSize: 15.5,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2C2523),
                              ),
                            ),
                          ],
                        ),
                ),
              ),

              const SizedBox(height: 14),

              // 3. Continue as Guest Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _onContinueAsGuest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF5F5F7),
                    foregroundColor: const Color(0xFF2C2523),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: const BorderSide(color: Color(0xFFE5E5EA), width: 1),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_outline, size: 20, color: Color(0xFF2C2523)),
                      SizedBox(width: 10),
                      Text(
                        'Continue as Guest',
                        style: TextStyle(
                          fontFamily: 'AnekLatin',
                          fontSize: 15.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2C2523),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // 4. Divider OR
              Row(
                children: [
                  const Expanded(child: Divider(color: Color(0xFFE5E5EA), thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                      'OR WITH MOBILE',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontFamily: 'AnekLatin',
                        color: Colors.black45,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(color: Color(0xFFE5E5EA), thickness: 1)),
                ],
              ),

              const SizedBox(height: 28),

              // 5. Mobile Phone Number Input Box
              const Text(
                'Mobile Number',
                style: TextStyle(
                  fontFamily: 'AnekLatin',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C2523),
                ),
              ),

              const SizedBox(height: 8),

              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: const Color(0xFFE0E0E0), width: 1.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  children: [
                    const Text(
                      '🇮🇳 +91',
                      style: TextStyle(
                        fontFamily: 'AnekLatin',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const VerticalDivider(
                      color: Color(0xFFD1D1D6),
                      indent: 14,
                      endIndent: 14,
                      thickness: 1,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        style: const TextStyle(
                          fontFamily: 'AnekLatin',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter 10-digit number',
                          hintStyle: TextStyle(
                            fontFamily: 'AnekLatin',
                            color: Colors.black38,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w400,
                          ),
                          counterText: '',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Send OTP / Sign In Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _onSendOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightPrimary,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    'Get OTP',
                    style: TextStyle(
                      fontFamily: 'AnekLatin',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 36),

              // 6. Terms & Conditions Disclaimer
              Center(
                child: Text(
                  'By continuing, you agree to Finzo Fashion\'s\nTerms of Service & Privacy Policy',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontFamily: 'AnekLatin',
                    color: Colors.black45,
                    height: 1.4,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
