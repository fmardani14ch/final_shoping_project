import 'package:dio/dio.dart';
import 'package:vesam_shop/main.dart';
import 'package:vesam_shop/screens/account/loging.dart';
import 'package:vesam_shop/utils/navigator.dart';

final Dio http_client =
    Dio(BaseOptions(baseUrl: "https://flutter.vesam24.com/api/"))
      ..interceptors.add(InterceptorsWrapper(
        onError: (e, handler) {
          if (e.response!.statusCode == 401) {
            login = false;
            goto(navigatorKey.currentContext!, LOGIN());
          }
        },
        onRequest: (options, handler) {
          String? user_token = key_token;
          if (user_token != "") {
            options.headers["Authorization"] = "Bearer $user_token";
          }
          handler.next(options);
        },
      ));
