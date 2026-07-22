import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryHeader extends StatelessWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onSearchTap;

  const CategoryHeader({
    super.key,
    this.onBackTap,
    this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: topPadding + 14.0,
        bottom: 16.0,
        left: 16.0,
        right: 16.0,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFF4F3FF), // Figma header background #F4F3FF
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
        border: Border(
          left: BorderSide(color: Colors.white, width: 1.0),
          right: BorderSide(color: Colors.white, width: 1.0),
          bottom: BorderSide(color: Colors.white, width: 1.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onBackTap ?? () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                behavior: HitTestBehavior.opaque,
                child: const Padding(
                  padding: EdgeInsets.only(right: 6.0),
                  child: Icon(
                    Icons.chevron_left,
                    size: 28.0,
                    color: Color(0xFF151515),
                  ),
                ),
              ),
              const Text(
                'Shop by Categories',
                style: TextStyle(
                  fontFamily: 'AnekLatin',
                  fontWeight: FontWeight.w700, // 700 Bold per Figma
                  fontSize: 22.0, // 22px per Figma
                  height: 1.0,
                  letterSpacing: 0.0,
                  color: Color(0xFF151515), // #151515 per Figma
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onSearchTap ?? () {},
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: 30.0,
              height: 30.0,
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/ic_search.svg',
                  width: 22.0,
                  height: 22.0,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF151515),
                    BlendMode.srcIn,
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

