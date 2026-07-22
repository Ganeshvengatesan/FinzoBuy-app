import 'package:flutter/material.dart';

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOutCubic;
            final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}

class SearchScreen extends StatefulWidget {
  final String? initialQuery;
  const SearchScreen({super.key, this.initialQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;
  final List<String> _popularSearches = const [
    'Kurta Sets for Women',
    'T-Shirts For Women',
    'Womens Kurtas',
    'T-Shirts For Men',
    'tops for women',
    'Dresses for women',
    'Shirts for women',
    'Shirts For Men',
    'Jeans For Women',
    'kurtas for women',
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery ?? '');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchSubmit(String query) {
    if (query.trim().isEmpty) return;
    _searchController.text = query;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header: Back Arrow + Clean Focus Input Box
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 16.0, top: 10.0, bottom: 10.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: TextField(
                          controller: _searchController,
                          autofocus: true,
                          cursorColor: const Color(0xFF00B4D8), // Thin cyan/teal cursor
                          cursorWidth: 1.8,
                          scrollPadding: EdgeInsets.zero,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.black87,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                          onSubmitted: _onSearchSubmit,
                          decoration: const InputDecoration(
                            hintText: 'What are you looking for?',
                            hintStyle: TextStyle(
                              color: Color(0xFF9E9E9E),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1, color: Color(0xFFEEEEEE)),

            // Popular Searches Section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Popular searches',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Wrap list of popular search chips
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 10.0,
                      children: _popularSearches.map((term) {
                        return InkWell(
                          onTap: () => _onSearchSubmit(term),
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: const Color(0xFFD0D0D0),
                                width: 1.0,
                              ),
                            ),
                            child: Text(
                              term,
                              style: const TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 13.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
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
}
