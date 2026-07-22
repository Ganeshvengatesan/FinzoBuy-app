import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../order/presentation/widgets/order_header.dart';
import '../../data/repositories/review_repository_impl.dart';
import '../../domain/repositories/review_repository.dart';
import '../controllers/write_review_controller.dart';

class WriteReviewScreen extends StatefulWidget {
  final String orderId;
  final String productTitle;
  final String productImageUrl;
  final ReviewRepository? repository;
  final VoidCallback? onBackTap;
  final VoidCallback? onSubmitSuccess;

  const WriteReviewScreen({
    super.key,
    this.orderId = '#3454545',
    this.productTitle = 'Regular Fit Shirt | Cotton...',
    this.productImageUrl = 'https://images.unsplash.com/photo-1617137984095-74e4e5e3613f?q=80&w=600&auto=format&fit=crop',
    this.repository,
    this.onBackTap,
    this.onSubmitSuccess,
  });

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  late final WriteReviewController _controller;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = WriteReviewController(widget.repository ?? ReviewRepositoryImpl());
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
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
            color: const Color(0xFFF3F5F7), // Figma background #F3F5F7
            child: Column(
              children: [
                // Custom Figma Header
                OrderHeader(
                  title: 'Write a Review',
                  onBackTap: widget.onBackTap,
                ),

                // Main Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 16.0,
                      bottom: 24.0,
                    ),
                    child: Column(
                      children: [
                        // Card 1: Order / Product Item Card
                        _buildProductCard(),
                        const SizedBox(height: 16.0),

                        // Card 2: Add Photo & Video Card
                        _buildUploadMediaCard(),
                        const SizedBox(height: 16.0),

                        // Card 3: Write Review Text Area Card
                        _buildReviewTextCard(),
                        const SizedBox(height: 20.0),

                        // Bottom Action Button
                        _buildSubmitButton(),
                      ],
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

  // Card 1: Order / Product Item Card
  Widget _buildProductCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0), // 10px per Figma
        border: Border.all(
          color: Colors.white,
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order ID ${widget.orderId}',
            style: const TextStyle(
              fontFamily: 'AnekLatin',
              fontWeight: FontWeight.w700,
              fontSize: 20.0,
              color: Color(0xFF000000),
            ),
          ),
          const SizedBox(height: 14.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14.0),
                child: Image.network(
                  widget.productImageUrl,
                  width: 64.0,
                  height: 64.0,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 64.0,
                    height: 64.0,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'AnekLatin',
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0,
                        color: Color(0xFF151515),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'Item yet to reach hub nearest to you.',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'AnekLatin',
                        fontWeight: FontWeight.w400,
                        fontSize: 13.0,
                        color: Color(0xFF888888),
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    const Text(
                      'Item yet to be delivered.',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'AnekLatin',
                        fontWeight: FontWeight.w400,
                        fontSize: 13.0,
                        color: Color(0xFF888888),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Card 2: Add Photo & Video Card
  Widget _buildUploadMediaCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0), // 10px per Figma
        border: Border.all(
          color: Colors.white,
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add photo & Video',
            style: TextStyle(
              fontFamily: 'AnekLatin',
              fontWeight: FontWeight.w700,
              fontSize: 20.0,
              color: Color(0xFF000000),
            ),
          ),
          const SizedBox(height: 14.0),
          GestureDetector(
            onTap: () {
              // Trigger image / video picker action
            },
            child: Container(
              width: double.infinity,
              height: 130.0,
              decoration: BoxDecoration(
                color: const Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                  width: 1.0,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    size: 44.0,
                    color: Color(0xFF888888),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Click here to upload',
                    style: TextStyle(
                      fontFamily: 'AnekLatin',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      color: Color(0xFF444444),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Card 3: Write Review Text Area Card
  Widget _buildReviewTextCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0), // 10px per Figma
        border: Border.all(
          color: Colors.white,
          width: 1.0,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add photo & Video',
            style: TextStyle(
              fontFamily: 'AnekLatin',
              fontWeight: FontWeight.w700,
              fontSize: 20.0,
              color: Color(0xFF000000),
            ),
          ),
          const SizedBox(height: 14.0),
          Container(
            width: double.infinity,
            height: 140.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: const Color(0xFFE5E7EB),
                width: 1.0,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
            child: TextField(
              controller: _textController,
              maxLines: 5,
              onChanged: _controller.setComment,
              style: const TextStyle(
                fontFamily: 'AnekLatin',
                fontSize: 14.0,
                color: Color(0xFF151515),
              ),
              decoration: const InputDecoration(
                hintText: 'Write something about this product',
                hintStyle: TextStyle(
                  fontFamily: 'AnekLatin',
                  fontSize: 14.0,
                  color: Color(0xFF888888),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Bottom Action Button ("Write a Review")
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 52.0,
      child: ElevatedButton(
        onPressed: _controller.isSubmitting
            ? null
            : () async {
                final success = await _controller.submitReview(
                  orderId: widget.orderId,
                  productId: 'prod_1',
                  productTitle: widget.productTitle,
                  productImageUrl: widget.productImageUrl,
                );

                if (mounted && success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Review submitted successfully!')),
                  );
                  if (widget.onSubmitSuccess != null) {
                    widget.onSubmitSuccess!();
                  } else if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4C4DDC), // Figma blue #4C4DDC
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: _controller.isSubmitting
            ? const SizedBox(
                width: 24.0,
                height: 24.0,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
              )
            : const Text(
                'Write a Review',
                style: TextStyle(
                  fontFamily: 'AnekLatin',
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
