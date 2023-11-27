import 'package:vesam_shop/data/models/home.dart';
import 'package:vesam_shop/data/models/user_info.dart';
import 'package:vesam_shop/utils/http_client.dart';

class HOME_SERVICE {
  Future<HOME_MODEL> get_general_info() async {
    var response = await http_client.get("home");
    return HOME_MODEL.fromJson(response.data);
  }

  Future<USER_INFO> get_user_info() async {
    var response = await http_client.get("users/me");

    return USER_INFO.fromJson(response.data);
  }
}
