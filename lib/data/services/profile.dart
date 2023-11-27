import 'package:vesam_shop/data/models/user_info.dart';
import 'package:vesam_shop/utils/http_client.dart';

class PROFILE_SERVICE {
  Future<List<MY_COMMENTS>> get_my_comment() async {
    List<MY_COMMENTS> mycomment = [];
    var response = await http_client.get("users/me/comments");
    for (var my_comment in response.data) {
      mycomment.add(MY_COMMENTS.fromJson(my_comment));
    }

    return mycomment;
  }

  Future<List<SUCCESS_PAYMENT>> get_user_payment() async {
    List<SUCCESS_PAYMENT> success_payment = [];
    var response = await http_client.get("users/me/succeeded-orders");
    for (var payment in response.data) {
      success_payment.add(SUCCESS_PAYMENT.fromJson(payment));
    }
    return success_payment;
  }
}
