import '../cart.dart';

abstract class Cart {
  final List<Item> items;
  final Restaurant restaurant;
  late Delivery? delivery;
  late CouponDiscount? coupon;

  Cart({
    required this.items,
    required this.restaurant,
    required this.delivery,
    this.coupon,
  });

  void add({
    required Item item,
  });

  void incrementQuantity({
    required int id,
  });

  void updateQuantity({
    required int id,
    required int quantity,
  });

  void decrementQuantity({
    required int id,
  });

  void remove({
    required int id,
  });

  void changeDelivery({
    required Delivery delivery,
  });

  void applyCoupon({
    required CouponDiscount coupon,
  });

  void removeCoupon();
}
