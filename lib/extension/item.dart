import '../cart.dart';

extension ItemsExtension on List<Item> {
  int get calculate {
    final int value = fold<int>(0, (old, item) => old + item.calculate);

    return value;
  }
}

extension ItemExtension on Item {
  int get calculate {
    if (this is ToppingItem) {
      return (this as ToppingItem).calculate;
    } else if (this is VariantItem) {
      return (this as VariantItem).calculate;
    } else if (this is VariantToppingItem) {
      return (this as VariantToppingItem).calculate;
    } else {
      return basePrice;
    }
  }

  int get basePrice => quantity * (price - discount.on(price));

  String get info {
    return "\n  $name${this is VariantItem ? ", ${(this as VariantItem).variant}" : ""}		${quantity}x$price		$basePrice${(this is ToppingItem || this is VariantToppingItem) ? """
    \n  Toppings:
    =======================================================
    || Name		    Category      	  Price  ||
    =======================================================
    ${(this is ToppingItem ? (this as ToppingItem).toppings : (this as VariantToppingItem).toppings).map<String>((item) => "${item.name}		    ${item.category.name}		  ${item.price}").join("\n    -------------------------------------------------------\n    ").toString()}
""" : ""}";
  }
}

extension ToppingItemExtension on ToppingItem {
  int get calculate {
    final int toppingsPrice = toppings.fold<int>(0, (old, topping) => old + topping.price);
    final int amount = quantity * (price + toppingsPrice - discount.on(price));
    return amount;
  }
}

extension VarinatItemExtension on VariantItem {
  int get calculate {
    final int amount = quantity * (price - discount.on(price));
    return amount;
  }
}

extension VariantToppingItemExtension on VariantToppingItem {
  int get calculate {
    final int toppingsPrice = toppings.fold<int>(0, (old, topping) => old + topping.price);
    final int amount = quantity * (price + toppingsPrice - discount.on(price));
    return amount;
  }
}
