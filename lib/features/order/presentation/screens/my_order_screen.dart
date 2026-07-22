import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../domain/repositories/order_repository.dart';
import '../controllers/order_controller.dart';
import '../widgets/order_card.dart';
import '../widgets/order_header.dart';
import 'order_details_screen.dart';

class MyOrderScreen extends StatefulWidget {
  final OrderRepository? repository;
  final VoidCallback? onBackTap;

  const MyOrderScreen({
    super.key,
    this.repository,
    this.onBackTap,
  });

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  late final OrderController _controller;

  @override
  void initState() {
    super.initState();
    _controller = OrderController(widget.repository ?? OrderRepositoryImpl());
    _controller.loadOrders();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) {
        final body = AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          child: Container(
            color: const Color(0xFFF3F5F7), // Figma background color #F3F5F7
            child: Column(
              children: [
                // Custom Figma Header Card (extends under status bar)
                OrderHeader(
                  onBackTap: widget.onBackTap,
                ),

                // Main Orders Content
                Expanded(
                  child: _controller.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _controller.errorMessage != null
                          ? Center(
                              child: Text(
                                _controller.errorMessage!,
                                style: const TextStyle(
                                  fontFamily: 'AnekLatin',
                                  fontSize: 16.0,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                top: 16.0,
                                bottom: 24.0,
                              ),
                              child: Column(
                                children: _controller.orders.map((order) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16.0),
                                    child: OrderCard(
                                      order: order,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => OrderDetailsScreen(order: order),
                                          ),
                                        );
                                      },
                                      onBuyAgainTap: () {
                                        // Handle Buy Again action
                                      },
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                ),
              ],
            ),
          ),
        );

        return Scaffold(
          body: body,
        );
      },
    );
  }
}
