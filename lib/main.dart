import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:menu_master/provider/akunprovider.dart';

import 'package:provider/provider.dart';
import '../provider/auth.dart';
import '../provider/product.dart';

import '../view/profile/profile.dart';
import '../view/login.dart';
import '../view/register.dart';
import '../view/home.dart';

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
          create: (ctx) => Product(),
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
            if (auth.isAuth) {
              if (kDebugMode) {
                print(set);
              }
              if (kDebugMode) {
                print(auth.isAuth);
              }
              return [
                MaterialPageRoute(
                    builder: (context) => const Home(title: 'Menu Master'),
                    settings: const RouteSettings(name: Home.nameRoute))
              ];
            }
            return [
              MaterialPageRoute(
                  builder: (context) => const Login(title: "Login Menu Master"),
                  settings: const RouteSettings(name: Login.nameRoute))
            ];
          },
          routes: {
            Home.nameRoute: (context) => const Home(title: 'Menu Master'),
            Profile.nameRoute: (context) => const Profile(),
            Login.nameRoute: (context) =>
                const Login(title: 'Login Menu Master'),
            Register.nameRoute: (context) => const Register(),
          },
        ),
      ),
    );
  }
}
