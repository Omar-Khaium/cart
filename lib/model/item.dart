import '../cart.dart';

class Item {
  final int id;
  final String name;
  late int quantity;
  final int price;
  final Discount? discount;

  Item({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    this.discount,
  });
}

class ToppingCategory {
  final int id;
  final String name;
  final int minimumOption;

  ToppingCategory({
    required this.id,
    required this.name,
    required this.minimumOption,
  });
}

class Topping {
  final int id;
  final String name;
  final ToppingCategory category;
  final int price;

  Topping({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
  });
}

class ToppingItem extends Item {
  final List<Topping> toppings;

  ToppingItem({
    required this.toppings,
    required super.id,
    required super.name,
    required super.quantity,
    required super.price,
    super.discount,
  });
}

class VariantItem extends Item {
  final String variant;

  VariantItem({
    required this.variant,
    required super.id,
    required super.name,
    required super.quantity,
    required super.price,
    super.discount,
  });
}

class VariantToppingItem extends VariantItem {
  final List<Topping> toppings;

  VariantToppingItem({
    required this.toppings,
    required super.id,
    required super.variant,
    required super.name,
    required super.quantity,
    required super.price,
    super.discount,
  });
}
