import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/widgets/discrete_progress_indicator.dart';
import '../../../category/presentation/widgets/category_header.dart';

class ProfileMenuScreen extends StatefulWidget {
  const ProfileMenuScreen({super.key});

  @override
  State<ProfileMenuScreen> createState() => _ProfileMenuScreenState();
}

class _ProfileMenuScreenState extends State<ProfileMenuScreen> {
  bool _isLoggingOut = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6FB),
        body: Column(
          children: [
            // Standard White App Bar
            CategoryHeader(
              title: 'Profile',
              onBackTap: () {
                if (context.canPop()) {
                  context.pop();
                }
              },
            ),

            // Scrollable Content Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 16),
                child: Column(
                  children: [
                    // EXACT FIGMA SPEC: Rectangle 3463309 Welcome Profile Header Card (406px x 85px, Radius 10px, Border 2px #FFFFFF)
                    GestureDetector(
                      onTap: () => context.push(RouteNames.myProfilePath),
                      child: Container(
                        width: double.infinity,
                        height: 85,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white, width: 2.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // User Avatar Container
                            Container(
                              width: 54,
                              height: 54,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFF1F1F1),
                                border: Border.all(color: AppColors.menPrimaryBlue, width: 1.5),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(27),
                                child: Image.asset(
                                  'assets/images/get_started_1.png',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(
                                    Icons.person,
                                    size: 32,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),

                            // Welcome Text & Cameron Williamson Name
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Welcome',
                                    style: TextStyle(
                                      fontFamily: 'AnekLatin',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF767676),
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Cameron Williamson',
                                    style: TextStyle(
                                      fontFamily: 'AnekLatin',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF151515),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right_rounded,
                              size: 24,
                              color: Color(0xFF151515),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // EXACT FIGMA SPEC: Group 1000011196 Account Section Card 1 (406px x 199px, Radius 16px, Border 2px #FFFFFF)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white, width: 2.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildMenuItem(
                            icon: Icons.person_outline_rounded,
                            title: 'My Profile',
                            onTap: () => context.push(RouteNames.myProfilePath),
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            icon: Icons.inventory_2_outlined,
                            title: 'My Order',
                            onTap: () => context.push(RouteNames.myOrderPath),
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            icon: Icons.favorite_border_rounded,
                            title: 'Wishlist',
                            onTap: () => context.push(RouteNames.wishlistPath),
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            icon: Icons.location_on_outlined,
                            title: 'Your Address',
                            onTap: () => context.push(RouteNames.selectAddressPath),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // EXACT FIGMA SPEC: Group 1000011197 Settings & Policies Section Card 2 (406px x 296px, Radius 16px, Border 2px #FFFFFF)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white, width: 2.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildMenuItem(
                            icon: Icons.headset_mic_outlined,
                            title: 'Customer Care',
                            onTap: () {},
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            icon: Icons.notifications_none_rounded,
                            title: 'Notification',
                            onTap: () => context.push(RouteNames.notificationsPath),
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            icon: Icons.undo_rounded,
                            title: 'How to Return',
                            onTap: () {},
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            icon: Icons.shield_outlined,
                            title: 'Terms & Conditions',
                            onTap: () => context.push(RouteNames.termsAndConditionsPath),
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            icon: Icons.monetization_on_outlined,
                            title: 'Returns & Refund Policy',
                            onTap: () {},
                          ),
                          _buildDivider(),
                          _buildMenuItem(
                            icon: Icons.percent_rounded,
                            title: 'Fees & Payment',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // EXACT FIGMA SPEC: Logout Button (Width 406px, Height 48px, Radius 10px, Background #4D43FE)
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _isLoggingOut
                            ? null
                            : () async {
                                HapticFeedback.mediumImpact();
                                setState(() {
                                  _isLoggingOut = true;
                                });
                                await AuthService.setLoggedIn(false);
                                if (mounted) {
                                  context.go(RouteNames.loginPath);
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.menPrimaryBlue,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _isLoggingOut
                            ? const DiscreteProgressIndicator(color: Colors.white, size: 22)
                            : const Text(
                                'Logout',
                                style: TextStyle(
                                  fontFamily: 'AnekLatin',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        child: Row(
          children: [
            Icon(icon, size: 22, color: const Color(0xFF767676)),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'AnekLatin',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF151515),
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: Color(0xFF151515),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 0.8,
      color: Colors.grey.shade200,
      indent: 16,
      endIndent: 16,
    );
  }
}
