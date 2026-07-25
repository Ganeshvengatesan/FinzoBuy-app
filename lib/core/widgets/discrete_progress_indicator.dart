import 'package:flutter/material.dart';

class DiscreteProgressIndicator extends StatelessWidget {
  final double size;
  final Color color;
  final double strokeWidth;

  const DiscreteProgressIndicator({
    super.key,
    this.size = 20.0,
    this.color = Colors.white,
    this.strokeWidth = 2.2,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        strokeCap: StrokeCap.round,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
