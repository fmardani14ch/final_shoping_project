import 'dart:io';

import 'package:vesam_shop/data/models/basket.dart';
import 'package:vesam_shop/utils/http_client.dart';

class BASKET_SERVICE {
  Future<USER_BASKET> get_all_basket() async {
    var response = await http_client.get("shopcarts");
    return USER_BASKET.fromJson(response.data);
  }

  Future<void> add_basket(int product_id) async {
    var response = await http_client.post("shopcarts/add-product/$product_id");
  }

  Future<void> increase_to_basket(int product_id) async {
    var response =
        await http_client.patch("shopcarts/$product_id/increase-count");
  }

  Future<void> decrease_from_basket(int product_id) async {
    var response =
        await http_client.patch("shopcarts/$product_id/decrease-count");
  }

  Future<void> delete_from_basket(int product_id) async {
    var response =
        await http_client.post("shopcarts/remove-product/$product_id");
  }

  Future<String> go_to_pay(PAYMENT payment) async {
    var response = await http_client.post("https://flutter.vesam24.com/payment",
        data: payment.toJson());
    return response.data;
  }
}
