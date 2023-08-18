import 'cart.dart';

export 'package:logger/logger.dart';
export 'model/item.dart';
export 'model/cart.dart';
export 'model/restaurant.dart';
export 'model/discount.dart';
export 'model/delivery.dart';
export 'extension/cart.dart';
export 'extension/delivery.dart';
export 'extension/discount.dart';
export 'extension/item.dart';
export 'extension/coupon.dart';
export 'error/exception.dart';

final logger = Logger(
  printer: PrettyPrinter(),
);

class MyCart extends Cart {
  MyCart({
    required super.items,
    required super.restaurant,
    super.coupon,
    super.delivery,
  });

  factory MyCart.create({
    required Item item,
    required Restaurant restaurant,
  }) {
    final MyCart cart = MyCart(
      items: [item],
      restaurant: restaurant,
    );

    logger.d("New cart created");
    logger.i(cart.statistics);

    return cart;
  }

  @override
  void add({
    required Item item,
  }) {
    logger.d("Adding new item.");
    logger.i(item.info);

    try {
      find(id: item.id);
      logger.d("Item already exists in cart.");
      updateQuantity(id: item.id, quantity: item.quantity);
    } on ItemNotFound {
      logger.d("This is a new item.");
      items.add(item);
      logger.w("Item added.");
    }

    logger.i(statistics);
  }

  @override
  void applyCoupon({
    required CouponDiscount coupon,
  }) {
    logger.d("Applying new coupon.");
    logger.i(coupon.info);

    this.coupon = coupon;
    logger.w("Coupon applied.");

    logger.i(statistics);
  }

  @override
  void changeDelivery({
    required Delivery delivery,
  }) {
    logger.d("Changing delivery method.");
    logger.i(delivery.info);

    this.delivery = delivery;
    logger.w("Delivery method changed.");

    logger.i(statistics);
  }

  @override
  void decrementQuantity({required int id}) {
    logger.d("Decrementing quantity.");

    try {
      final Item item = find(id: id);
      logger.i(item.info);

      if (item.quantity > 1) {
        item.quantity -= 1;
        logger.d("Quantity incremented.");

        logger.d(statistics);
      } else {
        remove(id: id);
      }
    } on ItemNotFound {
      logger.e("This is a new item. Please add this item to the cart before incrementing");
    }
  }

  @override
  void incrementQuantity({
    required int id,
  }) {
    logger.d("Incrementing quantity.");

    try {
      final Item item = find(id: id);
      logger.i(item.info);

      item.quantity += 1;
      logger.d("Quantity incremented.");

      logger.d(statistics);
    } on ItemNotFound {
      logger.e("This is a new item. Please add this item to the cart before incrementing");
    }
  }

  @override
  void remove({
    required int id,
  }) {
    logger.d("Removing item.");

    try {
      find(id: id);
      logger.i("Found the item in cart.");

      items.removeWhere((element) => element.id == id);
      logger.i("Item removed.");
      logger.i(statistics);
    } on ItemNotFound {
      logger.e("This is a new item. Please add this item to the cart before incrementing");
    }
  }

  @override
  void removeCoupon() {
    logger.i("Removing coupon.");
    coupon = null;
    logger.i("Coupon removed.");
    logger.i(statistics);
  }

  @override
  void updateQuantity({
    required int id,
    required int quantity,
  }) {
    logger.d("Updating quantity.");
    final Item oldItem = find(id: id);
    oldItem.quantity += quantity;

    logger.w("Quantity updated");
  }
}
