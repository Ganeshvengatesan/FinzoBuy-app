import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _accountNotifications = true;
  bool _shipmentNotifications = true;
  bool _recommendationNotifications = true;
  bool _dealsNotifications = true;

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

                  // Navigation Row: < Notifications & Search Icon
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
                        'Notifications',
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

            // Main Settings Card Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 20),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.08),
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
                    children: [
                      // 1. Your Account
                      _buildNotificationRow(
                        title: 'Your Account',
                        sub1: 'Get Notified for account alerts',
                        sub2: 'Important Message Alerts',
                        value: _accountNotifications,
                        onChanged: (val) => setState(() => _accountNotifications = val),
                      ),

                      _buildDivider(),

                      // 2. Your Shipments
                      _buildNotificationRow(
                        title: 'Your Shipments',
                        sub1: 'Find out when packages ship & arrive',
                        sub2: 'Shipment Notifications',
                        value: _shipmentNotifications,
                        onChanged: (val) => setState(() => _shipmentNotifications = val),
                      ),

                      _buildDivider(),

                      // 3. Your Recommendations
                      _buildNotificationRow(
                        title: 'Your Recommendations',
                        sub1: 'Receive recommendations based on you Shop',
                        sub2: 'Personalized Notifications',
                        value: _recommendationNotifications,
                        onChanged: (val) => setState(() => _recommendationNotifications = val),
                      ),

                      _buildDivider(),

                      // 4. Your Watched & Waitlisted Deals
                      _buildNotificationRow(
                        title: 'Your Watched & Waitlisted Deals',
                        sub1: 'Find out when Lighting Deals Happen',
                        sub2: 'Your Watched & Waitlisted Deals',
                        value: _dealsNotifications,
                        onChanged: (val) => setState(() => _dealsNotifications = val),
                      ),
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

  Widget _buildNotificationRow({
    required String title,
    required String sub1,
    required String sub2,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'AnekLatin',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF151515),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  sub1,
                  style: const TextStyle(
                    fontFamily: 'AnekLatin',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF555555),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  sub2,
                  style: const TextStyle(
                    fontFamily: 'AnekLatin',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF757575),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // EXACT FIGMA SPEC: Group 1000011208 Switch Toggle (Width 45px, Height 24px, Color #4D43FE)
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: AppColors.menPrimaryBlue, // Solid #4D43FE Blue
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFFE0E0E0),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
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
