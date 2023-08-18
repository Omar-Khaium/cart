import '../cart.dart';

extension DeliveryExtesion on Delivery? {
  String get info {
    if (this != null) {
      return "Method: ${this!.type} ----  Fee: ${this!.fee}";
    } else {
      logger.e("Delivery method not found");
      return "";
    }
  }
}
