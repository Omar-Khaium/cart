import 'package:cart/cart.dart';

extension DiscountExtension on Discount? {
  bool get expired {
    if (this == null) return true;
    final DateTime now = DateTime.now();
    return this!.from.isAfter(now) && this!.to.isBefore(now);
  }

  int on(int askingPrice) {
    if (this is CashDiscount?) {
      return (this as CashDiscount?).on(askingPrice);
    } else if (this is PercentageDiscount?) {
      return (this as PercentageDiscount?).on(askingPrice);
    } else if (this is CouponDiscount?) {
      return (this as CouponDiscount?).on(askingPrice);
    } else {
      return 0;
    }
  }
}

extension CashDiscountExtension on CashDiscount? {
  int on(int askingPrice) {
    if (this == null || expired) return 0;

    if (askingPrice > this!.minimumPurchase) {
      return this!.value as int;
    } else {
      return 0;
    }
  }

  String get info {
    if (this != null) {
      return "BDT ${this!.amount} flat-discount${this!.minimumPurchase > 0 ? " on minimum purchase of BDT ${this!.minimumPurchase}" : ""}";
    } else {
      logger.e("Cash-Discount not found");
      return "";
    }
  }
}

extension PercentageDiscountExtension on PercentageDiscount? {
  int on(int askingPrice) {
    if (this == null || expired) return 0;

    return (this!.value * askingPrice / 100).round();
  }

  String get info {
    if (this != null) {
      return "${this!.percent}% discount";
    } else {
      logger.e("Percentage-Discount not found");
      return "";
    }
  }
}
