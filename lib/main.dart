import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:menu_master/provider/akunprovider.dart';
import 'package:menu_master/view/homeseller.dart';
import 'package:menu_master/view/product/product_detail.dart';

import 'package:provider/provider.dart';
import '../provider/auth.dart';
import 'provider/products.dart';

import '../view/profile/profilecustomer.dart';
import '../view/profile/profileseller.dart';
import '../view/login.dart';
import '../view/register.dart';
import '../view/homecustomer.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AkunProvider(),
        ),
      ],
      builder: (context, child) => Consumer<Auth>(
        builder: (context, auth, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Menu Master',
          initialRoute: Login.nameRoute,
          onGenerateInitialRoutes: (set) {
            if (auth.isAuth != false) {
              if (kDebugMode) {
                print(set);
              }
              if (kDebugMode) {
                print(auth.isAuth);
              }
              return [
                MaterialPageRoute(
                    builder: (context) =>
                        const HomeCustomer(title: 'Menu Master'),
                    settings: const RouteSettings(name: HomeCustomer.nameRoute))
              ];
            }
            return [
              MaterialPageRoute(
                  builder: (context) => const Login(title: "Login Menu Master"),
                  settings: const RouteSettings(name: Login.nameRoute))
            ];
          },
          routes: {
            //custumer
            HomeCustomer.nameRoute: (context) =>
                const HomeCustomer(title: 'Menu Master'),
            Profilecustomer.nameRoute: (context) => const Profilecustomer(),
            Login.nameRoute: (context) =>
                const Login(title: 'Login Menu Master'),
            Register.nameRoute: (context) => const Register(),
            //seller
            HomeSeller.nameRoute: (context) =>
                const HomeSeller(title: 'Menu Master'),
            Profileseller.nameRoute: (context) => const Profileseller(),
            ProductDetailView.nameRoute: (context) => const ProductDetailView(),
          },
        ),
      ),
    );
  }
}
