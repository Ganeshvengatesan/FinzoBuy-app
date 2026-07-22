class OrderSummaryModel {
  final double mrp;
  final double platformFee;
  final double discounts;
  final double couponDiscount;

  OrderSummaryModel({
    required this.mrp,
    required this.platformFee,
    required this.discounts,
    required this.couponDiscount,
  });

  double get total => (mrp + platformFee) - (discounts + couponDiscount);

  String get mrpFormatted => '₹${mrp.toStringAsFixed(0)}';
  String get platformFeeFormatted => platformFee.toStringAsFixed(0);
  String get discountsFormatted => '-${discounts.toStringAsFixed(0)}';
  String get couponDiscountFormatted => '-${couponDiscount.toStringAsFixed(0)}';
  String get totalFormatted => '₹${total.toStringAsFixed(0)}';
}
