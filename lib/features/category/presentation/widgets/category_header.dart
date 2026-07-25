import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_names.dart';

class CategoryHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBackTap;
  final VoidCallback? onSearchTap;

  const CategoryHeader({
    super.key,
    this.title = 'Shop by Categories',
    this.onBackTap,
    this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: topPadding + 10.0,
        bottom: 12.0,
        left: 16.0,
        right: 16.0,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE5E7EB),
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onBackTap ?? () {
                  if (context.canPop()) {
                    context.pop();
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
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'AnekLatin',
                  fontWeight: FontWeight.w700,
                  fontSize: 22.0,
                  height: 1.0,
                  letterSpacing: 0.0,
                  color: Color(0xFF151515),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onSearchTap ?? () => context.push(RouteNames.searchPath),
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
