import 'package:shared_preferences/shared_preferences.dart';
import 'package:vesam_shop/data/models/authentication.dart';
import 'package:vesam_shop/utils/http_client.dart';

class AUTHENTICATION_SERVICE {
  Future<void> register_user(AUTHENTICATION_MODEL authentication_model) async {
    await http_client.post("accounts/signup",
        data: authentication_model.toJson());
  }

  Future<AUTHENTICATION_MODEL> login_user(
      AUTHENTICATION_MODEL authentication_model) async {
    var response = await http_client.post("accounts/login",
        data: authentication_model.toJson());

    return AUTHENTICATION_MODEL.fromJson(response.data);
  }
}
