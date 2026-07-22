import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../search/presentation/screens/search_screen.dart';
import '../../data/services/location_service.dart';
import 'location_bottom_sheet.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  final LocationService _locationService = LocationService();
  LocationResult _currentLocation = LocationResult(
    locality: 'Madurai',
    pincode: '625006',
    fullAddress: 'Madurai - 625006',
  );
  bool _isLoadingLocation = false;

  // Sliding keywords list
  static const List<String> _searchKeywords = [
    "Products",
    "Fashion Clothes",
    "Kurta Sets",
    "Smartphones",
    "Jeans & Tops",
    "Footwear & Shoes",
    "Wireless Earbuds",
    "Lipstick & Beauty",
  ];

  int _keywordPageIndex = 0;
  late final PageController _searchPageController;
  Timer? _keywordTimer;

  @override
  void initState() {
    super.initState();
    _searchPageController = PageController();
    _initLocation();
    _startKeywordAnimation();
  }

  void _startKeywordAnimation() {
    _keywordTimer = Timer.periodic(const Duration(seconds: 2, milliseconds: 600), (timer) {
      if (mounted && _searchPageController.hasClients) {
        _keywordPageIndex++;
        _searchPageController.animateToPage(
          _keywordPageIndex,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _keywordTimer?.cancel();
    _searchPageController.dispose();
    super.dispose();
  }

  Future<void> _initLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      final loc = await _locationService.fetchCurrentLocation();
      if (mounted) {
        setState(() {
          _currentLocation = loc;
        });
      }
    } catch (_) {
      // Fallback silently to default initial location on startup error
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingLocation = false;
        });
      }
    }
  }

  void _openLocationBottomSheet() {
    LocationBottomSheet.show(
      context: context,
      currentLocation: _currentLocation,
      onLocationSelected: (newLoc) {
        setState(() {
          _currentLocation = newLoc;
        });
      },
    );
  }

  void _openSearchScreen([String? query]) {
    Navigator.push(
      context,
      SlideRightRoute(page: SearchScreen(initialQuery: query)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16, vertical: AppSizes.p8),
      child: Column(
        children: [
          // 1. Full Row: Location + Notification Bell + Menu
          SizedBox(
            height: 44.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Location Selector Widget
                Expanded(
                  child: InkWell(
                    onTap: _openLocationBottomSheet,
                    borderRadius: BorderRadius.circular(8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        children: [
                          // Location Icon
                          SvgPicture.asset(
                            'assets/icons/location.svg',
                            width: 20,
                            height: 20,
                            colorFilter: const ColorFilter.mode(
                              Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                          AppSizes.wGap8,

                          // Location Text Column
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Deliver to',
                                  style: TextStyle(
                                    fontFamily: 'AnekLatin',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.0,
                                    height: 1.1,
                                    color: Colors.black54,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        _isLoadingLocation
                                            ? 'Location...'
                                            : _currentLocation.displayLocation,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontFamily: 'AnekLatin',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15.0,
                                          height: 1.1,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    // Chevron Down Icon
                                    SvgPicture.asset(
                                      'assets/icons/ic_chevron_down.svg',
                                      width: 14,
                                      height: 14,
                                      colorFilter: const ColorFilter.mode(
                                        Colors.black87,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Notification Bell Icon Button
                Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/Bell.svg',
                        width: 22,
                        height: 22,
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 38, minHeight: 38),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 4),

                // Menu Icon Button
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/Menu.svg',
                    width: 22,
                    height: 22,
                    colorFilter: const ColorFilter.mode(
                      Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 38, minHeight: 38),
                ),
              ],
            ),
          ),

          AppSizes.hGap12,

          // 2. Home Search Bar: Fixed "Search for " Prefix with Vertical Sliding Keyword Ticker
          InkWell(
            onTap: () => _openSearchScreen(),
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: const Color(0x221F1F1A),
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(11.0),
                child: Row(
                  children: [
                    // Search SVG Icon
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                      child: SvgPicture.asset(
                        'assets/icons/ic_search.svg',
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(
                          Colors.black87,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),

                    // Fixed "Search for " Prefix Label
                    Text(
                      'Search for ',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.unselectedIcon,
                        fontSize: 14.0,
                      ),
                    ),

                    // Vertical Sliding Keyword Ticker Display
                    Expanded(
                      child: SizedBox(
                        height: 22,
                        child: PageView.builder(
                          controller: _searchPageController,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final keyword = _searchKeywords[index % _searchKeywords.length];
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "'$keyword'",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.unselectedIcon,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // Mic Suffix Icon
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 12.0),
                      child: SvgPicture.asset(
                        'assets/icons/mic.svg',
                        width: AppSizes.iconXs,
                        height: AppSizes.iconXs,
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
