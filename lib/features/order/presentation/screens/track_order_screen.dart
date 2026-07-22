import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/order_header.dart';

class TrackOrderStep {
  final String title;
  final String? date;
  final bool isCompleted;
  final bool isCurrent;
  final List<TrackOrderSubStep> subSteps;

  const TrackOrderStep({
    required this.title,
    this.date,
    required this.isCompleted,
    this.isCurrent = false,
    required this.subSteps,
  });
}

class TrackOrderSubStep {
  final String title;
  final String? timeLocation;

  const TrackOrderSubStep({
    required this.title,
    this.timeLocation,
  });
}

class TrackOrderScreen extends StatelessWidget {
  final String orderId;
  final VoidCallback? onBackTap;

  const TrackOrderScreen({
    super.key,
    this.orderId = '#3454545',
    this.onBackTap,
  });

  List<TrackOrderStep> _getSteps() {
    return const [
      TrackOrderStep(
        title: 'Ordered',
        date: "Tue, 22nd Sep '20",
        isCompleted: true,
        subSteps: [
          TrackOrderSubStep(
            title: 'Your Order Has Been Placed.',
            timeLocation: 'Tue, 22nd Mar 26 - 3:43pm',
          ),
        ],
      ),
      TrackOrderStep(
        title: 'Packed',
        date: 'Monday, 21 July',
        isCompleted: true,
        subSteps: [
          TrackOrderSubStep(
            title: 'Seller Has Processed Your Order',
            timeLocation: 'Package has left an Amazon facility at GURUGRAM, HARIYANA at 6:30 AM Tuesday, 21 Mar',
          ),
        ],
      ),
      TrackOrderStep(
        title: 'Shipped',
        isCompleted: true,
        isCurrent: true,
        subSteps: [
          TrackOrderSubStep(
            title: 'Your Item Has Arrived At A Our Facility',
            timeLocation: 'Thu, 24th Mar 26-4:00am - Surat',
          ),
          TrackOrderSubStep(
            title: 'Your Item Has Left A Our Facility',
            timeLocation: "Thu, 24th Mar '26-9:10am - Surat",
          ),
          TrackOrderSubStep(
            title: 'Your Item Has Arrived At A Our Facility',
            timeLocation: 'Sun, 27th Mar 26 1:22pm - Gurgaon',
          ),
        ],
      ),
      TrackOrderStep(
        title: 'Out for delivery',
        isCompleted: false,
        subSteps: [
          TrackOrderSubStep(
            title: 'Item yet to reach hub nearest to you.',
          ),
          TrackOrderSubStep(
            title: 'Item yet to be delivered.',
          ),
        ],
      ),
      TrackOrderStep(
        title: 'Arriving Today',
        isCompleted: false,
        subSteps: [
          TrackOrderSubStep(
            title: 'Item yet to be delivered.',
          ),
          TrackOrderSubStep(
            title: 'Expected by Sun, 27th Mar',
          ),
          TrackOrderSubStep(
            title: 'Expected by Wed, 30th Mar',
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final steps = _getSteps();

    final body = AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Container(
        color: const Color(0xFFF3F5F7), // Background color #F3F5F7
        child: Column(
          children: [
            // Custom Figma Header Card
            OrderHeader(
              title: 'Track Order',
              onBackTap: onBackTap,
            ),

            // Scrollable Track Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                  bottom: 24.0,
                ),
                child: Container(
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
                      // Order ID Title
                      Text(
                        'Order ID $orderId',
                        style: const TextStyle(
                          fontFamily: 'AnekLatin',
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Color(0xFF000000),
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      // Timeline Steps
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: steps.length,
                        itemBuilder: (context, index) {
                          final step = steps[index];
                          final isLast = index == steps.length - 1;
                          final nextStepCompleted = !isLast && steps[index + 1].isCompleted;

                          return _buildTimelineStep(
                            step: step,
                            isLast: isLast,
                            lineIsGreen: step.isCompleted && nextStepCompleted,
                          );
                        },
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

    return Scaffold(
      body: body,
    );
  }

  Widget _buildTimelineStep({
    required TrackOrderStep step,
    required bool isLast,
    required bool lineIsGreen,
  }) {
    final Color activeGreen = const Color(0xFF10B981); // Bright status green per Figma
    final Color inactiveGrey = const Color(0xFFD1D5DB); // Grey for pending steps

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Vertical Indicator Line + Icon Circle
          SizedBox(
            width: 32.0,
            child: Column(
              children: [
                // Step Circle
                step.isCompleted
                    ? Container(
                        width: 24.0,
                        height: 24.0,
                        decoration: BoxDecoration(
                          color: activeGreen,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16.0,
                        ),
                      )
                    : Container(
                        width: 24.0,
                        height: 24.0,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: inactiveGrey,
                            width: 2.0,
                          ),
                        ),
                      ),

                // Connecting Line underneath
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 3.0,
                      color: lineIsGreen ? activeGreen : inactiveGrey,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12.0),

          // Right Step Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Step Header Row (Title + Date)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        step.title,
                        style: TextStyle(
                          fontFamily: 'AnekLatin',
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          color: step.isCompleted ? activeGreen : const Color(0xFF888888),
                        ),
                      ),
                      if (step.date != null)
                        Text(
                          step.date!,
                          style: const TextStyle(
                            fontFamily: 'AnekLatin',
                            fontWeight: FontWeight.w400,
                            fontSize: 13.0,
                            color: Color(0xFF666666),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6.0),

                  // Sub-steps
                  ...step.subSteps.map(
                    (subStep) => Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subStep.title,
                            style: TextStyle(
                              fontFamily: 'AnekLatin',
                              fontWeight: step.isCompleted ? FontWeight.w600 : FontWeight.w400,
                              fontSize: 14.0,
                              color: step.isCompleted ? const Color(0xFF151515) : const Color(0xFF888888),
                            ),
                          ),
                          if (subStep.timeLocation != null) ...[
                            const SizedBox(height: 2.0),
                            Text(
                              subStep.timeLocation!,
                              style: TextStyle(
                                fontFamily: 'AnekLatin',
                                fontWeight: FontWeight.w400,
                                fontSize: 13.0,
                                color: step.isCompleted ? const Color(0xFF7E7E7E) : const Color(0xFFAAAAAA),
                              ),
                            ),
                          ],
                        ],
                      ),
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
}
