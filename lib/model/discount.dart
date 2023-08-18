class Discount {
  final int id;
  final num value;
  final DateTime from;
  final DateTime to;

  Discount({
    required this.id,
    required this.value,
    required this.from,
    required this.to,
  });
}

class CashDiscount extends Discount {
  final int amount;
  final int minimumPurchase;

  CashDiscount({
    required this.amount,
    required this.minimumPurchase,
    required super.id,
    required super.from,
    required super.to,
  }) : super(value: amount);
}

class PercentageDiscount extends Discount {
  final double percent;

  PercentageDiscount({
    required this.percent,
    required super.id,
    required super.from,
    required super.to,
  }) : super(value: percent);
}

class CouponDiscount extends Discount {
  final String code;
  final Discount discount;

  CouponDiscount({
    required this.code,
    required this.discount,
  }) : super(
          id: discount.id,
          value: discount.value,
          from: discount.from,
          to: discount.to,
        );
}
