import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

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

                  // Navigation Row: < Terms & Conditions & Search Icon
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
                        'Terms & Conditions',
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

            // Terms Content Body Container
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.04),
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
                    children: const [
                      Text(
                        'This document is an electronic record in terms of Information Technology Act, 2000 and rules there under as applicable and the amended provisions pertaining to electronic records in various statutes as amended by the Information Technology Act, 2000. This electronic record is generated by a computer system and does not require any physical or digital signatures.',
                        style: TextStyle(
                          fontFamily: 'AnekLatin',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF4A4A4A),
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'This document is published in accordance with the provisions of Rule 3 (1) of the Information Technology (Intermediaries guidelines) Rules, 2011 that require publishing the rules and regulations, privacy policy and Terms of Use for access or usage of domain name ("Website"), including the related mobile site and mobile application (hereinafter referred to as "Platform")',
                        style: TextStyle(
                          fontFamily: 'AnekLatin',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF4A4A4A),
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'The Platform is owned by Flipkart Internet Private Limited, a company incorporated under the Companies Act, 1956 with its registered office at Buildings Alyssa, Begonia & Clover, Embassy Tech Village, Outer Ring Road, Devarabeesanahalli Village, Bengaluru – 560103, Karnataka, India and its branch offices at 2nd Floor, Block F (Flora), Embassy Tech Village, Outer Ring Road, Devarabeesanahalli Village, Bengaluru-560103, Karnataka, India and; 447/C, 12th Main, 4th Block, Koramangala, Bengaluru-560034, Karnataka, India',
                        style: TextStyle(
                          fontFamily: 'AnekLatin',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF4A4A4A),
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Your use of the Platform and services and tools are governed by the following terms and conditions ("Terms of Use") as applicable to the Platform including the applicable policies which are incorporated herein by way of reference. If You transact on the Platform, You shall be subject to the policies that are applicable to the Platform for such transaction. By mere use of the Platform, You shall be contracting with Flipkart Internet Private Limited and these terms and conditions including the policies constitute Your binding obligations.',
                        style: TextStyle(
                          fontFamily: 'AnekLatin',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF4A4A4A),
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 16),
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
}
