import 'package:cart/cart.dart';
import 'package:collection/collection.dart';

extension CartExtension on Cart {
  int get subtotal {
    return items.calculate;
  }

  int get total {
    if (delivery == null) {
      throw DeliveryMethodRequired();
    }
    assert(delivery != null);
    final int deliveryFee = delivery!.fee;

    final int couponDiscount = coupon.on(subtotal);

    return subtotal + deliveryFee - couponDiscount;
  }

  Item find({
    required int id,
  }) {
    final Item? item = items.firstWhereOrNull((element) => element.id == id);
    if (item == null) {
      throw ItemNotFound();
    }
    return item;
  }

  String get statistics {
    final String header = """
\nCart report: ${items.length} item${items.length > 1 ? "s" : ""}
  =======================================================
  || Name			Qty		Price	||
  =======================================================""";

    final String itemsBody = """
${items.map<String>((item) => "  ${item.info}").join("\n  =======================================================").toString()}
\n=======================================================
""";

    final String subtotalBody = """
  Subtotal	:				BDT $subtotal
=======================================================
""";

    final String deliveryBody = """
  Delivery	:				BDT ${delivery?.fee ?? "-"}
""";

    final String couponBody = """
  Coupon	:				BDT ${coupon.on(subtotal) == 0 ? "-" : coupon.on(subtotal)}${coupon == null ? "" : "\n    ${coupon.info}"}
""";

    late String totalvalueText;

    try {
      totalvalueText = "BDT $total";
    } on DeliveryMethodRequired {
      totalvalueText = "Delivery method required";
    }
    final String totalBody = """
=======================================================
  Total	:				$totalvalueText
""";
    return "$header$itemsBody$subtotalBody$deliveryBody$couponBody$totalBody";
  }
}
