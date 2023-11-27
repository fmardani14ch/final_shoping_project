import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:vesam_shop/data/models/product.dart';
import 'package:vesam_shop/data/services/authentication.dart';
import 'package:vesam_shop/data/services/home.dart';
import 'package:vesam_shop/data/services/product.dart';
import 'package:vesam_shop/data/services/profile.dart';
import 'package:vesam_shop/data/services/user_basket.dart';
import 'package:vesam_shop/screens/account/bloc/authentication_bloc.dart';
import 'package:vesam_shop/screens/account/loging.dart';
import 'package:vesam_shop/screens/basket/bloc/basket_bloc.dart';
import 'package:vesam_shop/screens/home/bloc/home_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vesam_shop/screens/home/splash_screen.dart';
import 'package:vesam_shop/screens/product/bloc/product_bloc.dart';
import 'package:vesam_shop/screens/profile/bloc/profile_bloc.dart';
import 'package:vesam_shop/theme.dart';

final navigatorKey = GlobalKey<NavigatorState>();

late final SharedPreferences loged_in_key;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  loged_in_key = await SharedPreferences.getInstance();

  await Hive.initFlutter();
  Hive.registerAdapter(ProductsAdapter());
  Hive.openBox<Products>("favorite_product");

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => HomeBloc(HOME_SERVICE()),
      ),
      BlocProvider(
        create: (context) => ProductBloc(PRODUCT_SERVICE()),
      ),
      BlocProvider(
        create: (context) =>
            AuthenticationBloc(AUTHENTICATION_SERVICE(), HOME_SERVICE()),
      ),
      BlocProvider(
        create: (context) => ProfileBloc(PROFILE_SERVICE()),
      ),
      BlocProvider(
        create: (context) => BasketBloc(BASKET_SERVICE()),
      )
    ],
    child: MYAPP(),
  ));
}

class MYAPP extends StatefulWidget {
  @override
  State<MYAPP> createState() => _MYAPPState();
}

class _MYAPPState extends State<MYAPP> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: navigatorKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [Locale("fa", "IR")],
      title: "vesam_shop",
      locale: Locale("fa", "IR"),
      theme: light_theme(),
      home: SPLASH(),
    );
  }
}
