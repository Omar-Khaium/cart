class Delivery {
  final String type;
  final int fee;
  Delivery({
    required this.type,
    required this.fee,
  });
}

class PickUp extends Delivery {
  PickUp() : super(fee: 0, type: "Pickup");
}

class HomeDelivery extends Delivery {
  HomeDelivery({
    required super.fee,
  }) : super(
          type: "Home delivery",
        );
}

class DineIn extends Delivery {
  DineIn() : super(fee: 0, type: "Dine-in");
}
