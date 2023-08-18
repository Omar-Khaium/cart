import 'package:cart/cart.dart';

void main(List<String> arguments) {

  final Delivery delivery = HomeDelivery(fee: 40);

  final CouponDiscount couponDiscount = CouponDiscount(
    code: "TEST",
    discount: PercentageDiscount(
      percent: 20,
      id: 0,
      from: DateTime(2023, 8, 1),
      to: DateTime(2023, 8, 31),
    ),
  );

  final Discount restaurantDiscount = CashDiscount(
    amount: 40,
    minimumPurchase: 200,
    id: 0,
    from: DateTime(2023, 8, 1),
    to: DateTime(2023, 8, 31),
  );

  final Restaurant restaurant = Restaurant(
    name: "Omar's Tong",
    discount: restaurantDiscount,
  );

  final Cart cart = MyCart.create(
    item: Item(id: 0, name: "Oven baked pasta", quantity: 2, price: 150),
    restaurant: restaurant,
  );

  final Item variantItem = VariantItem(id: 1, name: "Salami pizza", quantity: 1, price: 450, variant: "8 inch");
  cart.add(item: variantItem);

  cart.changeDelivery(delivery: delivery);

  final Item toppingItem = ToppingItem(
    toppings: [
      Topping(
        id: 0,
        name: "Extra",
        category: ToppingCategory(
          id: 0,
          name: "Cheese",
          minimumOption: 1,
        ),
        price: 10,
      ),
    ],
    id: 2,
    name: "Chicken burger",
    quantity: 1,
    price: 80,
  );
  cart.add(item: toppingItem);

  cart.applyCoupon(coupon: couponDiscount);

  final Item variantToppingItem = VariantToppingItem(
    id: 3,
    name: "Mutton Kacchi",
    quantity: 4,
    price: 100,
    variant: "4:1",
    toppings: [
      Topping(
        id: 1,
        name: "200 ml",
        category: ToppingCategory(
          id: 2,
          name: "Borhani",
          minimumOption: 0,
        ),
        price: 20,
      ),
      Topping(
        id: 1,
        name: "Small cup",
        category: ToppingCategory(
          id: 2,
          name: "Jorda",
          minimumOption: 0,
        ),
        price: 15,
      ),
    ],
  );
  cart.add(item: variantToppingItem);
  cart.add(item: variantToppingItem);

  cart.incrementQuantity(id: toppingItem.id);
  // cart.incrementQuantity(id: 100);
}
