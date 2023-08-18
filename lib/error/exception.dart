class ItemNotFound extends Error {
  @override
  String toString() {
    return "Following item doesn't exists in Cart.";
  }
}

class DeliveryMethodRequired extends Error {
  @override
  String toString() {
    return "Delivery method is required to finalize Total order value.";
  }
}
