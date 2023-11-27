import 'package:vesam_shop/data/models/product.dart';
import 'package:vesam_shop/screens/product/product_detail.dart';
import 'package:vesam_shop/utils/http_client.dart';

class PRODUCT_SERVICE {
  Future<PRODUCT_MODEL> latest_product_model() async {
    var response = await http_client.get('products?order=latest');
    return PRODUCT_MODEL.fromJson(response.data);
  }

  Future<PRODUCT_MODEL> popular_product_model() async {
    var response = await http_client.get('products?order=popular');
    return PRODUCT_MODEL.fromJson(response.data);
  }

  Future<COMMENTS> product_detail_model(int product_id) async {
    var response = await http_client.get('products/$product_id');
    return COMMENTS.fromJson(response.data);
  }

  Future<void> send_comment(Comments comment) async {
    await http_client.post("comments", data: comment.toJson());
  }
}
