import 'package:hive_flutter/adapters.dart';
import 'package:vesam_shop/data/models/home.dart';
import 'package:vesam_shop/data/models/product.dart';

class FAVORITE_PRODUCT {
  static final Box<Products> favorite_product_box =
      Hive.box<Products>("favorite_product");

  ////////////////////////////////////////////////////////////////
  static Future<void> add_product(Products productx) async {
    await favorite_product_box.put(productx.id, productx);
  }

  static Future<void> remove_product(Products productx) async {
    await favorite_product_box.delete(productx.id);
  }

  static List<Products> get_favorite_list() {
    return favorite_product_box.values.toList();
  }

  static bool isinbox(Products productx) {
    return favorite_product_box.containsKey(productx.id);
  }
}
