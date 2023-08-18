import '../cart.dart';

extension CouponDiscountExtension on CouponDiscount? {
  int on(int askingPrice) {
    if (this == null || expired) return 0;

    return this!.discount.on(askingPrice);
  }

  String get info {
    if (this != null) {
      return "CODE: ${this!.code} ----  ${(this!.discount is CashDiscount ? (this!.discount as CashDiscount).info : (this!.discount as PercentageDiscount).info)}";
    } else {
      logger.e("Coupon not found");
      return "";
    }
  }
}
